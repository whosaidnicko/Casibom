
import SwiftUI


struct ARHomeView: View {
    
    @EnvironmentObject var vm: ARGameVM
    @EnvironmentObject var soundVM: ARSoundManager
    
    @State private var isRulesShow: Bool = false
    @State private var isSettingShow: Bool = false
    @State private var isRoulette: Bool = false
    @State private var isRoulleteSetting: Bool = false
    @State private var isBlackJack: Bool = false
    @State private var isHomeShow: Bool = false
    
    var body: some View {
        ZStack {
            switch true {
            case isRulesShow:
                ARRulesView(isCancel: $isRulesShow)
                    .transition(.move(edge: .bottom))
                
            case isSettingShow:
                ARSettingView(isCancel: $isSettingShow)
                    .transition(.move(edge: .bottom))
                
            case isRoulleteSetting:
                ARRouletteSetting( isBlackJack: $isBlackJack,isHomeShow: $isHomeShow )
                    .transition(.move(edge: .trailing))
                
            default :
                HomeView()
                .transition(.move(edge: .leading))
                .onAppear{
                    vm.logo = true
                    soundVM.playMusic()
                }
                .sheet(isPresented: $isBlackJack) {
                    ARMainTableView(
                        isRoullette: $isRoulette,
                        isHome: $isHomeShow,
                        isBlackJack: $isBlackJack
                    )
                    .onDisappear{
                        vm.logo = true
                        soundVM.playMusic()
                    }
                }
            }
        }
    }
    
//MARK: -HomeView
    @ViewBuilder
    func HomeView() -> some View {
        ZStack {
            HStack {
                ARSilverFrame(image: .coinIcon, title: "\(vm.myCost)")
                Spacer()
                ARSilverFrame(image: .starIcon, title: "0")
                Spacer()
                ARSettingRuleView()
            }
            .verAlig(.top, 40)
            
            ARSelectPlayView()
        }
    }
    
//MARK: -ARSelectPlayView
    @ViewBuilder
    func ARSelectPlayView() -> some View {
        HStack(spacing: 30) {
            HapticButton {
                vm.logo = false
                withAnimation(.linear(duration: 0.3)) {
                    isBlackJack = true
                }
            } label: {
                Image(.btnBlackJack)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 90)
            }
            
            HapticButton {
                vm.logo = false
                withAnimation(.linear(duration: 0.3)) {
                    isRoulleteSetting = true
                }
            } label: {
                Image(.btnRoulete)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 90)
            }
        }
        .verAlig(.bottom, 20)
    }
    
//MARK: -ARSettingRuleView
    @ViewBuilder
    func ARSettingRuleView() -> some View {
        HStack(spacing: 20) {
            HapticButton {
                vm.logo = false
                withAnimation(.linear(duration: 0.3)) {
                    isSettingShow = true
                }
            } label: {
                Image(.setting)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 68, height: 68)
            }
            
            HapticButton {
                vm.logo = false
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
    }
}

#Preview {
    ARHomeView()
        .environmentObject(ARGameVM())
        .environmentObject(ARSoundManager())
}

