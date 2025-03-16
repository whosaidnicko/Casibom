
import SwiftUI

@MainActor
class ARBlackJackVM: ObservableObject {
    @Published var gameVM = ARGameVM.shared
    @Published var deck: [Card] = []
    @Published var playerHand: [Card] = []
    @Published var dealerHand: [Card] = []
    @Published var bet: Int = 0
    @Published var gameOver: Bool = false
    @Published var playerWins: Bool?
    @Published var betArray: [Int] = []
    @Published var isBetEmpty: Bool = true
    @Published var isHideCard = false
    @Published var addBet: Int = 0
    
    init() {
        resetDeck()
    }
    
    func resetDeck() {
        deck = CardRank.allCases.flatMap { rank in
            CardSuit.allCases.map { suit in Card(rank: rank, suit: suit) }
        }
        .shuffled()
        
    }
    
    func deal()   {
        guard deck.count > 4 else { return resetDeck() }
        playerHand = [deck.removeFirst(), deck.removeFirst()]
        dealerHand = [deck.removeFirst(), deck.removeFirst()]
        gameOver = false
        playerWins = nil
        isBetEmpty = true
        betArray = []
        bet = 0
        isHideCard = false
        addBet = 0
        gameVM.isSelectedChip = false
        
        withAnimation(.linear(duration: 0.2)){
            if gameVM.myCost <= 0 {
                gameVM.myCost = 1000
            }
        }
    }
    
    func hit() {
        guard !gameOver else { return }
        playerHand.append(deck.removeFirst())
        if handValue(playerHand) > 21 { endGame() }
    }
    
    func stand() {
        while handValue(dealerHand) < 17 {
            dealerHand.append(deck.removeFirst())
        }
        endGame()
        betArray = []
    }
    
    func endGame() {
        let playerScore = handValue(playerHand)
        let dealerScore = handValue(dealerHand)
        
        if playerScore > 21 || (dealerScore <= 21 && dealerScore >= playerScore) {
            playerWins = false
            gameVM.myCost -= bet
        } else {
            playerWins = true
            gameVM.myCost += (bet * 3)
        }

        Task {
            try await Task.sleep(for: .seconds(1))
            isBetEmpty = true
            gameOver = true
        }
    }
    
    func handValue(_ hand: [Card]) -> Int {
        var total = hand.reduce(0) { $0 + $1.rank.value }
        let aceCount = hand.filter { $0.rank == .ace }.count
        
        while total > 21 && aceCount > 0 {
            total -= 10
        }
        return total
    }
    
    func placeBet(_ amount: Int) {
        if  gameVM.myCost >= amount &&   gameVM.myCost >= bet {
            bet += amount
            betArray.append(amount)
        }
    }
    
    func bet2X() {
        if  gameVM.myCost >= bet {
            bet *= 2
        }
        
        if bet > 0  && addBet > 0 {
            addBet = bet
        }
    }
    
    func calculateWin() -> Int{
        if playerWins  == true {
          let  new =  bet * 3
            return new
        } else {
            return  bet
        }
    }
    
}


