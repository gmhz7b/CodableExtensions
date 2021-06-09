import Foundation


/// A `protocol` signifying that an object's `Type ` can provide a `JSONDecoder`.
public protocol HasJSONDecoder: Decodable {
    
    static var decoder: JSONDecoder { get }
}

extension HasJSONDecoder {
    
    /// Default implementation.
    ///
    /// - SeeAlso: `HasJSONDecoder`.
    public static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }
}
