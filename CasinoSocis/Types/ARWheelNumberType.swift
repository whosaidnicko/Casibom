
import SwiftUI

enum ARWheelNumberType: String, CaseIterable {
    case zero
    case twentyEight
    case nine
    case twentySix
    case thirty
    case eleven
    case seven
    case twenty
    case thirtyTwo
    case seventeen
    case five
    case twentyTwo
    case thirtyFour
    case fifteen
    case three
    case twentyFour
    case thirtySix
    case thirteen
    case one
    case zeroX2
    case twentySeven
    case ten
    case twentyFive
    case twentyNine
    case twelve
    case eight
    case nineteen
    case thirtyOne
    case eighteen
    case six
    case twentyOne
    case thirtyThree
    case sixteen
    case four
    case twentyThree
    case thirtyFive
    case fourteen
    case two
    
    
    var value: (String, String) {
        switch self {
        case .zero: return ("0", "")
        case .zeroX2: return ("00", "")
        case .one: return ("1", "RED")
        case .two: return ("2", "BLACK")
        case .three: return ("3", "RED")
        case .four: return ("4", "BLACK")
        case .five: return ("5", "RED")
        case .six: return ("6", "BLACK")
        case .seven: return ("7", "RED")
        case .eight: return ("8", "BLACK")
        case .nine: return ("9", "RED")
        case .ten: return ("10", "BLACK")
        case .eleven: return ("11", "BLACK")
        case .twelve: return ("12", "RED")
        case .thirteen: return ("13", "BLACK")
        case .fourteen: return ("14", "RED")
        case .fifteen: return ("15", "BLACK")
        case .sixteen: return ("16", "RED")
        case .seventeen: return ("17", "BLACK")
        case .eighteen: return ("18", "RED")
        case .nineteen: return ("19", "RED")
        case .twenty: return ("20", "BLACK")
        case .twentyOne: return ("21", "RED")
        case .twentyTwo: return ("22", "BLACK")
        case .twentyThree: return ("23", "RED")
        case .twentyFour: return ("24", "BLACK")
        case .twentyFive: return ("25", "RED")
        case .twentySix: return ("26", "BLACK")
        case .twentySeven: return ("27", "RED")
        case .twentyEight: return ("28", "BLACK")
        case .twentyNine: return ("29", "BLACK")
        case .thirty: return ("30", "RED")
        case .thirtyOne: return ("31", "BLACK")
        case .thirtyTwo: return ("32", "RED")
        case .thirtyThree: return ("33", "BLACK")
        case .thirtyFour: return ("34", "RED")
        case .thirtyFive: return ("35", "BLACK")
        case .thirtySix: return ("36", "RED")
        }
    }
}
