import Foundation

/// Enables decoding/encoding of `[String: Any]`.
extension KeyedEncodingContainerProtocol {
    
    public mutating func encode(_ value: [String: Any], forKey key: Key) throws {
        var container = nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        
        try container.encode(value)
    }
    
    public mutating func encode(_ value: [Any], forKey key: Key) throws {
        var container = nestedUnkeyedContainer(forKey: key)
        
        try container.encode(value)
    }
}

/// Enables decoding/encoding of `[String: Any]`.
extension KeyedEncodingContainerProtocol where Key == JSONCodingKeys {
    
    mutating func encode(_ value: [String: Any]) throws {
        try value.forEach {
            let key = JSONCodingKeys(stringValue: $0.key)
            
            switch $0.value {
            case let value as Bool:
                try encode(value, forKey: key)
                
            case let value as Int:
                try encode(value, forKey: key)
                
            case let value as String:
                try encode(value, forKey: key)
                
            case let value as Double:
                try encode(value, forKey: key)
                
            case Optional<Any>.none:
                try encodeNil(forKey: key)
                
            case let value as [String: Any]:
                try encode(value, forKey: key)
                
            case let value as [Any]:
                try encode(value, forKey: key)
                
            case let value as Encodable:
                try value.encode(to: superEncoder())
                
            default:
                
                throw EncodingError.invalidValue(
                    value,
                    EncodingError.Context(
                        codingPath: codingPath + [key],
                        debugDescription: "Invalid JSON value"
                    )
                )
            }
        }
    }
}
