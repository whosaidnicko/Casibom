
import SwiftUI

struct ARRouletteSetting: View {
    @EnvironmentObject var vm: ARGameVM
    
    @State private var isRulesShow: Bool = false
    @State private var isSettingShow: Bool = false
    @State private var selectCost: Int = 0
    
    @Binding var isBlackJack: Bool
    @State private var isRoulette: Bool = false
    @Binding var isHomeShow: Bool
   
    var body: some View {
        if isRulesShow {
            ARRulesView(isCancel: $isRulesShow)
                .transition(.move(edge: .bottom))
            
        } else  if isSettingShow {
            ARSettingView(isCancel: $isSettingShow)
                .transition(.move(edge: .bottom))
            
        }  else  if isHomeShow {
            ARHomeView()
                .transition(.move(edge: .leading))
            
        } else {
            ZStack {
                ARTopView()
                ARYourBetView()
                ARGoldFrame(text: .next){
                    if selectCost != 0 {
                        isRoulette.toggle()
                    }
                }
                .verAlig(.bottom, 30)
            }
            .transition(.move(edge: .top))
            .sheet(isPresented: $isRoulette) {
                ARMainTableView(
                    isRoullette: $isRoulette,
                    isHome: $isHomeShow,
                    isBlackJack: $isBlackJack
                )
                .onDisappear{
                    withAnimation{
                        isHomeShow = true
                    }
                }
            }
        }
    }
        
//MARK: -ARTopView
    @ViewBuilder
    func ARTopView() -> some View {
        HStack {
            HapticButton {
                withAnimation(.linear(duration: 0.3)) {
                    isSettingShow = true
                }
            } label: {
                Image(.setting)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 68, height: 68)
            }
            
            Spacer()
            
            ARSilverFrame(image: .coinIcon, title: "\(vm.myCost)")
                
            Spacer()
            
            HapticButton {
                withAnimation(.linear(duration: 0.3)) {
                    isRulesShow = true
                }
            } label: {
                Image(.rule)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 68, height: 68)
            }
        }
        .verAlig(.top,40)
    }

//MARK: -ARYourBetView
    @ViewBuilder
    func ARYourBetView() -> some View {
        VStack(spacing: 6) {
            Text("YOUR BET")
                .fonts(.titleSize30)
                .foregroundStyle(Color.goldColor)
            
            HStack(spacing: 16) {
                HapticButton {
                    withAnimation{
                        if selectCost != 0 {
                            selectCost -= 25
                        }
                    }
                } label: {
                    Image(.minusBet)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 68, height: 68)
                }

                ZStack {
                    Image(.frameBet)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 68)
                    
                        Text("\(selectCost)")
                            .foregroundStyle(Color.whiteColor)
                            .fonts(.titleSize30)
                            .contentTransition(.numericText())
                }
                
                HapticButton {
                    withAnimation {
                        if selectCost < vm.myCost {
                            selectCost += 25
                        }
                    }
                } label: {
                    Image(.plusBet)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 68, height: 68)
                }
            }
        }
    }
}

#Preview {
    ARRouletteSetting(isBlackJack: .constant(false), isHomeShow: .constant(true))
        .environmentObject(ARGameVM())
        .environmentObject(ARSoundManager())
}
