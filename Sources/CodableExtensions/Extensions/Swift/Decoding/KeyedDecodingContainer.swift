import Foundation

/// Enables decoding/encoding of `[String: Any]`.
extension KeyedDecodingContainer {
    
    public func decode(_ type: [String: Any].Type) throws -> [String: Any] {
        
        return allKeys.reduce(into: [String: Any]()) {
            
            $0[$1.stringValue] = failableDecode(Bool.self, forKey: $1)
                ?? failableDecode(String.self, forKey: $1)
                ?? failableDecode(Int.self, forKey: $1)
                ?? failableDecode(Double.self, forKey: $1)
                ?? (try? decode([String: Any].self, forKey: $1))
                ?? (try? decode([Any].self, forKey: $1))
        }
    }
    
    public func decode(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any] {

        return try nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key).decode(type)
    }
    
    public func decode(_ type: [Any].Type, forKey key: K) throws -> [Any] {
        var container = try nestedUnkeyedContainer(forKey: key)
        
        return try container.decode(type)
    }
}

extension KeyedDecodingContainer {
  
    private func failableDecode<T: Decodable>(_ type: T.Type, forKey key: K) -> T? {
        
        return try? decode(T.self, forKey: key)
    }
}
