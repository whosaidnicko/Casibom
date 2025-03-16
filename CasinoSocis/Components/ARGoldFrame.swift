
import SwiftUI

struct ARGoldFrame: View {

    var text: ARTableType
    var action: () -> Void
    
    var body: some View {
        HapticButton(action: {
                action()
        }, label: {
            ZStack {
                Image(.goldFrame)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 225, height: 60)
                
                Title(text.title.uppercased())
                    .fonts(.titleSize30)
                    .foregroundStyle(Color.black)

            }
        })
    }
    
    @ViewBuilder
    private func Title(_ title: String) -> some View {
        Group {
            switch text {
            case .bet: Text(title)
            case .x2: Text(title)
            case .check: Text(title)
            case .restart: Text(title)
            default: Text(title)
            }
        }
        .transitionEffect()
    }
}
