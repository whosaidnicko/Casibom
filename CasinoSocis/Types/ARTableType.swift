
import SwiftUI

enum ARTableType: String {
    case start
    case spin
    case bet
    case gain
    case claim
    case continu
    case restart
    case win
    case lose
    case x2
    case check
    case next
    
    var title: String {
        switch self {
        case .start: return "start"
        case .spin: return "spin"
        case .bet: return "bet"
        case .gain: return "gain"
        case .claim: return "claim"
        case .continu: return "continue"
        case .restart: return "restart"
        case .win: return "win!"
        case .lose: return "lose"
        case .x2: return "X2"
        case .check: return "check"
        case .next: return "next"
        }
    }
}
