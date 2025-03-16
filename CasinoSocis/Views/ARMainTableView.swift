
import SwiftUI

struct ARMainTableView: View {
    
    @EnvironmentObject var soundVM: ARSoundManager
 
    @Binding var isRoullette: Bool
    @Binding var isHome: Bool
    @Binding var isBlackJack: Bool
    
    @State private var isWin: Bool?
    @State private var isResult: Bool = false
 
    var body: some View {
        ARMainTableComponents(cost: "+150", isWin: $isWin, isResult: $isResult) {
   
           if let isWin, isWin {
                 self.isWin = nil
                 self.isResult = false
            
           } else {
               self.isWin = nil
               self.isResult = false
           }
        } homeButtonAction: {
          
            Task {
                if isRoullette {
                    isRoullette = false
                }
                if isBlackJack {
                    isBlackJack = false
                }
                    isHome = false
            }
        } content: {
            if isRoullette {
                ARRouletteView()
            }
            
            if isBlackJack {
                ARBlackJackView()
            }
        }
        .animation(.linear(duration: 0.3), value: isResult)
        .onAppear{
            soundVM.stopMusic()
            soundVM.playChip()
        }

    }
}


#Preview {
    ARMainTableView(isRoullette: .constant(false), isHome: .constant(false), isBlackJack: .constant(false))
        .environmentObject(ARSoundManager())
        .environmentObject(ARGameVM())
        .environmentObject(ARBlackJackVM())
}






