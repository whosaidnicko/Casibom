
import SwiftUI

struct ARBlackJackView: View {
    
    @EnvironmentObject var gameVM: ARGameVM
    @EnvironmentObject var game: ARBlackJackVM
    @EnvironmentObject var soundVM: ARSoundManager
        
    var body: some View {
        ZStack {
            ZStack {
                HStack(spacing: screenSize().height) {
                    HideCard()
                    HideCard()
                }
                .verAlig(.bottom, 60)
                .padding(.trailing, 35)
                
                VStack(spacing: 20) {
                    VStack(spacing: 20) {
                        if !game.isBetEmpty {
                            CardView(cards: game.dealerHand, valueCars: game.handValue(game.dealerHand), diller: true)
                              
                            CardView(cards: game.playerHand, valueCars: game.handValue(game.playerHand))
                                
                        }
                    }
                    .padding(.bottom, 40)
                    .padding(.leading, 30)
                }
            }
            .padding(.bottom, 80)
            .padding(.leading, 80)
            .blur(radius: game.gameOver ? 20 : 0)
            
            VStack(spacing: 20) {
                BetField()
                ButtonView()
            }
                .horAlig(.trailing, 100)
                .verAlig(.bottom, 20)
                .blur(radius: game.gameOver ? 20 : 0)
            
            if game.gameOver {

                    ARResultViewCell(
                        cost: "\(game.playerWins == true  ? "+\(game.calculateWin())" : "-\(game.calculateWin())")",
                        isWin: game.playerWins == true  ? true : false,
                        isBackGround: true,
                        action: {
                                game.gameOver = false
                                game.deal()
                        }
                    )
                    .transition(.asymmetric(insertion: .scale, removal: .scale).animation(.linear(duration: 0.2)))

            }
                
        }
        .task { game.deal() }
    }
    
    @ViewBuilder
    private func CardView(cards: [Card], valueCars: Int, diller: Bool = false) -> some View {
        
        HStack(alignment: .top,spacing: 20) {
            HStack(spacing: 20) {
                ForEach(cards.indices, id: \.self) { index in
                        HStack {
                            if diller {
                                if index == cards.count - 1 && !game.isHideCard {
                                    Image(.bgCard)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 45, height: 70)
                                        .transition(.flipBack)
                                        .onTapGesture {
                                            feedBackGeneration()
                                            soundVM.playCardHide()
                                            withAnimation {
                                                game.isHideCard.toggle()
                                            }
                                        }
                                        
                                } else {
                                    CardViewCell(card: cards[index])
                                        .transition(.flip)
                                }
                            } else {
                                CardViewCell(card: cards[index])
                            }
                        }
                        .transition(.flip)
                    }
            }
            VStack {
                Text(!game.isHideCard && diller ? "" : "\(valueCars)")
                    .fonts(.titleSize28)
                    .frame(width: 50)
                    .foregroundStyle(Color.whiteColor)
                    .multilineTextAlignment(.leading)
                
                if game.isHideCard && !diller && game.addBet > 0 {
                    Text("+\(game.addBet)")
                        .fonts(.titleSize22)
                        .foregroundStyle(Color.goldColor)
                        .multilineTextAlignment(.leading)
                        .contentTransition(.numericText())
                }
            }
        }
        .transition(
            .push(from: .trailing)
            .combined(with: .scale)
            .animation(.spring(response: 0.6, dampingFraction: 0.6))
        )
        
    }
    
    @ViewBuilder
    private func BetField() -> some View {
        ZStack {
            Image(.betFiled)
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 60)
                .clipped()
                
            Text("FOR BET")
                .fonts(.cornerRadius25)
                .foregroundStyle(Color.gold.opacity(0.7))

            HStack(spacing: 4) {
                ForEach(game.betArray, id: \.self){ bet in
                    HStack {
                        ForEach(ARChipsType.allCases){chip in
                            if chip.value == bet {
                                Image(chip.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func ButtonView() -> some View {
        HStack(spacing: 20) {
            ARGoldFrame(text: game.isBetEmpty ? .bet : .x2){
                withAnimation (.linear(duration: 0.3)){
                    if !game.isBetEmpty {
                        game.bet2X()
                    } else {
                        if !game.betArray.isEmpty {
                            game.isBetEmpty = false
                            soundVM.playRazdacha()
                        }
                    }
                }
            }
            
            ARGoldFrame(text: game.isHideCard ? .check : .restart) {
                if !game.isBetEmpty && !game.isHideCard {
                    game.deal()
                } else {
                    game.stand()
                }
            }
            ARSilverFrame(image: .coinIcon, title: "\(gameVM.myCost)",isCoinRight: true)
        }
    }
    
    @ViewBuilder
    private func HideCard() -> some View {
        HapticButton(action: {
            guard game.isHideCard else { return }
            withAnimation {
                game.hit()
            }
        }) {
            Image(.bgCard)
                .resizable()
                .scaledToFit()
                .frame(width: 46, height: 70)
        }
    }
}

#Preview {
    ARBlackJackView()
        .environmentObject(ARGameVM())
        .environmentObject(ARBlackJackVM())
        .environmentObject(ARSoundManager())
}
