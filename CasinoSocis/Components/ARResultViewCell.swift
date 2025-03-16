
import SwiftUI

struct ARResultViewCell: View {
    @EnvironmentObject var vm: ARGameVM
    @EnvironmentObject var soundVM: ARSoundManager
    
    var cost: String
    var isWin: Bool?
    var isBackGround: Bool?
    var action: () -> Void
    
    var colors: LinearGradient {
        if let isWin, isWin {
            LinearGradient(colors: [.orangeColor, .yellowColor, .orangeColor], startPoint: .leading, endPoint: .trailing)
        } else {
            LinearGradient(colors: [.whiteColor], startPoint: .center, endPoint: .center)
        }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                Text((isWin != nil && isWin == true) ? ARTableType.win.title.uppercased() : ARTableType.lose.title.uppercased())
                .font(.custom("PoetsenOne-Regular", size: 64))
                .foregroundStyle(colors)
                
                ARSilverFrame(image: .coinIcon, title: cost)
            }
            .verAlig(.top, 60)
            
            ARGoldFrame(text: (isWin != nil && isWin == true) ? .continu : vm.myCost <= 0 ? .restart : .continu) {
                    action()
            }
            .verAlig(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
            soundVM.playCoinDrop()
        }
        .background(.ultraThinMaterial.blendMode(.darken).opacity(isBackGround != nil ? 1 : 0))
    }
}
