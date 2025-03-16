
import SwiftUI

struct ARRulesView: View {
    @EnvironmentObject var vm: ARGameVM
    
    @StateObject private var rulesVM = ARRulesVM()
    @State private var selectedIndex: Int = 0
    @Binding var isCancel: Bool
    
    var body: some View {
       
            ZStack {
                HapticButton {
                    withAnimation(.linear(duration: 0.3)) {
                        isCancel.toggle()
                    }
                } label: {
                    Image(.houseIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 68, height: 68)
                }
                .verAlig(.top, 40)
                .horAlig(.leading)
                
                VStack(spacing: 16) {
                    Text(ARRuleTypes.rules.title)
                        .font(.custom("PoetsenOne-Regular", size: 64))
                        .colorGradient()
                        .padding(.top, 30)
                        
                    CellView(item: rulesVM.arrayRules[selectedIndex])
                }
            }        
    }
    
    @ViewBuilder
    private func CellView(item: ARRulesModel) -> some View {
        VStack(spacing: 12) {
            TitleCell(item.title)
                .fonts(.titleSize35)
                
            TitleCell(item.subTitle)
                .fonts(.titleSizeStandart)
            
            Spacer()
            
            HStack{
                HapticButton {
                    withAnimation(.smooth(duration: 0.5)){
                        if selectedIndex != 0 {
                            selectedIndex -= 1
                        }
                    }
                } label: {
                    Image(.arrowLeft)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                
                TitleCell("\(item.image)/2")
                    .fonts(.titleSize30)
                    .colorGradient()
                 
                HapticButton {
                    withAnimation(.smooth(duration: 0.5)){
                        if selectedIndex < rulesVM.arrayRules.count - 1 {
                            selectedIndex += 1
                        }
                    }
                } label: {
                    Image(.arrowRight)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }

            }
            .padding(.bottom, 16)
        }
        .foregroundStyle(Color.whiteColor)
        .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    private  func TitleCell(_ text: String) -> some View {
        Group {
            switch selectedIndex {
            case 0: Text(text)
            case 1: Text(text)
            default: Text("")
            }
        }
        .transitionEffect()
    }
}

#Preview {
    ARRulesView(isCancel: .constant(true))
        .environmentObject(ARGameVM())
}


