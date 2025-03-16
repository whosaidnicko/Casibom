
import SwiftUI

struct ARMainTableComponents<Content: View>: View {
    @EnvironmentObject var gameVM: ARGameVM
    @EnvironmentObject var jackBlackVM: ARBlackJackVM
    
    var cost: String
    @Binding var isWin: Bool?
    @Binding var isResult: Bool
    var action: () -> ()
    var homeButtonAction: () -> ()
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            Image(.tableBG)
                .resizable()
                .scaledToFill()
                .frame(width: screenSize().width, height: screenSize().height)
                .ignoresSafeArea(edges: .all)
            
            content
            
            ChipButton()
                .horAlig(.leading, 80)
                .padding(.top, 16)
                .blur(radius: jackBlackVM.gameOver || gameVM.isStart || gameVM.isClaim ? 20 : 0)
            
            if isResult {
                ARResultViewCell(cost: cost, isWin: isWin) { action() }
                    .transition(.scale.animation(.linear(duration: 0.2)))
            }
            
            HomeButton()
        }
    }
    
    
//MARK: -ChipButton
    @ViewBuilder
    private func ChipButton() -> some View {
        VStack(spacing: 10) {
            ForEach(ARChipsType.allCases, id:\.self) {item in
                HapticButton {
                    if gameVM.currentChip.id != item.id {
                        gameVM.isSelectedChip = true
                        gameVM.currentChip = Chip(amount: item.value, chipIcon: item.icon)
                       
                    }
                    jackBlackVM.placeBet(item.value)
                    if jackBlackVM.isHideCard {
                        withAnimation{
                            jackBlackVM.addBet += item.value
                        }
                    }
                   
                } label: {
                        Image(item.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .scaleEffect(gameVM.isSelectedChip && gameVM.currentChip.amount == item.value ? 1.3 : 1)
                            .animation(.spring(), value: gameVM.currentChip.amount)
                }
            }
        }
    }
    
//MARK: -HomeButton
    @ViewBuilder
    private func HomeButton() -> some View {
        HapticButton {
            withAnimation(.linear(duration: 0.3)) {
                homeButtonAction()
                gameVM.isSelectedChip = false
                gameVM.isHomeShow = true
            }
        } label: {
            Image(.houseIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 68, height: 68)
        }
        .verAlig(.top, 35)
        .horAlig(.trailing, 20)
    }
}
