
import SwiftUI

struct ARNumberButton: View {
    let number: String
    let bet: Bet?
    let color: Color
    var width: CGFloat = 50
    var height: CGFloat = 30
    let action: () -> Void
    
    var body: some View {
        HapticButton(action: action) {
            Text(number)
                .font(.system(size: 20, weight: .bold))
                .frame(width: width, height: height)
                .foregroundColor(.clear)
                .overlay {
                    if let bet = bet {
                        Image(bet.chip.chipIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .transitionEffect()
                    }
                }
        }
    }
}
