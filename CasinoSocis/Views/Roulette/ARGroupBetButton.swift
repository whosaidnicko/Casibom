
import SwiftUI

struct ARGroupBetButton: View {
    let title: String
    let bet: Bet?
    let width: CGFloat
    let height: CGFloat = 42
    let action: () -> Void
    
    var body: some View {
        HapticButton(action: action) {
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .padding(6)
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
