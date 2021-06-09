import Foundation

/// Assists in decoding/encoding of  unkeyed and dynamically-keyed containers..
struct JSONCodingKeys: CodingKey {
    
    var stringValue: String
    
    init(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = Int(stringValue)
    }
    
    var intValue: Int?
    
    init(intValue: Int) {        
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }
}
