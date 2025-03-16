
import SwiftUI

struct ARLaunchView: View {
    var body: some View {
        
        ZStack {
            ARLottieView(filename: "Animation - 1741520383145", color: UIColor(resource: .gold))
                .frame(width: 130, height: 130)
                .verAlig(.bottom, 50)
            
            Text(ARTitleTypes.subLaunch.title)
                .fonts(.titleSize18)
                .foregroundStyle(Color.whiteColor)
                .multilineTextAlignment(.center)
                .verAlig(.bottom, 25)
        }
    }
}

#Preview {
    ARLaunchView()
}
