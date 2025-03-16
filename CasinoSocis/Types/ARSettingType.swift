

import SwiftUI

enum ARSettingType: String {
    
    case settings
    case music
    case sound
    
    var title: String {
        switch self {
        case .settings:
            return "SETTIINGS"
        case .music:
            return "MUSIC"
        case .sound:
            return "SOUND"
        }
    }
    
}

