import Foundation


/// An object-wrapper around a `Decodable` `rawValue`.
///
/// If the `rawValue` fails to decode, the resulting error for that object is
/// stored without interupting the `Decoder`.
public struct FailableDecodable<T: Decodable> {
    
    public let rawValue: T?
    public let error: Error?
    
    public init(rawValue: T?, error: Error?) {
        self.rawValue = rawValue
        self.error = error
    }
    
    public init(from decoder: Decoder) throws {
        do {
            rawValue = try decoder.singleValueContainer().decode(T.self)
            error = nil
        } catch {
            self.error = error
            rawValue = nil
        }
    }
}
