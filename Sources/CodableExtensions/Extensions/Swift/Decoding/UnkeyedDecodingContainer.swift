import Foundation

/// Enables decoding/encoding of `[String: Any]`.
extension UnkeyedDecodingContainer {
    
    public mutating func decode(_ type: [String: Any].Type) throws -> [String: Any] {

        return try nestedContainer(keyedBy: JSONCodingKeys.self).decode(type)
    }
    
    public mutating func decode(_ type: [Any].Type) throws -> [Any] {
        var values: [Any] = []
        
        while !isAtEnd {
            guard let value = try decodedValue() else {
                continue
            }
            
            values.append(value)
        }
        
        return values
    }
}

extension UnkeyedDecodingContainer {
    
    private mutating func decodedValue() throws -> Any? {
        guard try decodeNil() == false else {
            return nil
        }
        
        return failableDecode(Bool.self)
            ?? failableDecode(Int.self)
            ?? failableDecode(Double.self)
            ?? failableDecode(String.self)
            ?? (try? decode([String: Any].self))
            ?? (try? decode([Any].self))
    }
  
    private mutating func failableDecode<T: Decodable>(_ type: T.Type) -> T? {
        
        return try? decode(T.self)
    }
}
