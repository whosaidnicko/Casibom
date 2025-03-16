
import SwiftUI

enum ARChipsType: String, CaseIterable, Identifiable {
    case chip1 = "1"
    case chip5 = "5"
    case chip10 = "10"
    case chip20 = "20"
    case chip50 = "50"
    case chip100 = "100"
    
    var value: Int {
        switch self {
        case .chip1: 1
        case .chip5: 5
        case .chip10: 10
        case .chip20: 20
        case .chip50: 50
        case .chip100: 100
        }
    }
    
    var icon: ImageResource {
        switch self {
        case .chip1: .chip1
        case .chip5: .chip5
        case .chip10: .chip10
        case .chip20: .chip20
        case .chip50: .chip50
        case .chip100: .chip100
        }
    }
    
    var id: String {
           return self.rawValue  
       }
}
