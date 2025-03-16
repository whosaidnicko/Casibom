
import SwiftUI

enum CardRank: String, CaseIterable {
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case jack = "J"
    case queen = "Q"
    case king = "K"
    case ace = "A"
    
    var value: Int {
        switch self {
        case .ace: return 11
        case .king, .queen, .jack, .ten: return 10
        default: return Int(self.rawValue) ?? 0
        }
    }
}

enum CardSuit: String, CaseIterable {
    case hearts = "hearts"
    case diamonds = "diamonds"
    case clubs = "clubs"
    case spades = "spades"
}

struct Card {
    let rank: CardRank
    let suit: CardSuit
}
