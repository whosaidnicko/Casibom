

enum ARRuleTypes: String {
    case rules 
    case roulette
    case blackjack
    
    var title: String {
        switch self {
        case .rules: "RULES"
        case .roulette: "ROULETTE"
        case .blackjack: "BLACKJACK"
        }
    }
    
    var subTitle: String {
        switch self {
        case .roulette:
            "Roulette is a casino game where players bet on numbers, colors, or groups of numbers. The dealer spins the wheel and releases a ball, which lands on a numbered pocket. There are different types of bets, including inside bets (specific numbers) and outside bets (groups like red/black or odd/even). European roulette has better odds than American roulette due to a single zero. Players can use strategies, but the house always has an edge."
        case .blackjack:
            "Blackjack is a card game where players try to get a hand closer to 21 than the dealer without going over. Each player is dealt two cards and can hit (take another card) or stand (keep their total). Face cards are worth 10, and Aces can be 1 or 11. The dealer must hit until 17 or higher. Players can use strategies, but the casino always has an advantage."
        case .rules: ""
        }
    }
    
    var icon: String {
        switch self {
        case .roulette: "1"
        case .blackjack: "2"
        case .rules: ""
        }
    }
}
