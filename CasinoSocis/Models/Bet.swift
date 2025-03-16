
import SwiftUI

struct Bet: Identifiable {
    let id = UUID().uuidString
    let number: String
    let chip: Chip
}

struct Chip: Identifiable {
    let id = UUID().uuidString
    let amount: Int
    let chipIcon: ImageResource
}
