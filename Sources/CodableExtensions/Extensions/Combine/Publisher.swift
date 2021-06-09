import Foundation
import Combine

extension Publisher {

    /// A convenience method for `Publisher`s who's `Output` conforms to `HasDecoder`.
    ///
    /// - SeeAlso: `HasDecoder`.
    public func jsonDecode<T: Decodable>(_ type: T.Type) -> Publishers.Decode<Self, T, JSONDecoder> {
        
        return (type as? HasJSONDecoder.Type)
            .map { decode(type: type, decoder: $0.decoder) }
            ?? decode(type: type, decoder: JSONDecoder())
    }
}
