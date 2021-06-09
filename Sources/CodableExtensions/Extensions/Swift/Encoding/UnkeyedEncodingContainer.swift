import Foundation

/// Enables decoding/encoding of `[String: Any]`.
extension UnkeyedEncodingContainer {
    
    public mutating func encode(_ value: [String: Any]) throws {
        var container = nestedContainer(keyedBy: JSONCodingKeys.self)
        
        try container.encode(value)
    }
    
    public mutating func encode(_ value: [Any]) throws {
        
        try value.enumerated().forEach({
            switch $0.element {
            case let value as Bool:
                try encode(value)

            case let value as Int:
                try encode(value)

            case let value as String:
                try encode(value)

            case let value as Double:
                try encode(value)
                
            case Optional<Any>.none:
                try encodeNil()
                
            case let value as [String: Any]:
                try encode(value)
                
            case let value as [Any]:
                try encode(value)
                
            case let value as Encodable:
                try value.encode(to: superEncoder())
                
            default:

                throw EncodingError.invalidValue(
                    value,
                    EncodingError.Context(
                        codingPath: codingPath + [JSONCodingKeys(intValue: $0.offset)],
                        debugDescription: "Invalid JSON value"
                    )
                )
            }
        })
    }
}
