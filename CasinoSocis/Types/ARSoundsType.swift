
enum ARSoundsType: String,CaseIterable {
    
    case wheelPlay
    case wheelStop
    case chipsSound
    case casinoMusic
    case buttonClick
    case coinDrop
    case razdacha
    case cardHide
    
    var sounds: (String, String) {
        switch self {
        case .wheelPlay: return ("wheelPlay", "mp3")
        case .wheelStop: return ("wheelStop", "mp3")
        case .chipsSound: return ("chipsSound", "mp3")
        case .casinoMusic: return ("casinoMusic", "mp3")
        case .buttonClick: return ("buttonClick", "mp3")
        case .coinDrop: return ("coinDrop", "mp3")
        case .razdacha: return ("razdacha", "mp3")
        case .cardHide: return ("cardHide", "mp3")
        }
    }
}
