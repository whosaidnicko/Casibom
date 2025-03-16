
import SwiftUI

struct ARStartView: View {
    @EnvironmentObject var gameVM: ARGameVM
    
    @State private var didAnimate = false
    @State private var rotate: CGFloat = 0
    
    var body: some View {
        
        ZStack {
            Image(.bgSplash)
                .resizable()
                .scaledToFill()
                .clipped()
                .ignoresSafeArea(edges: .all)
                
            if gameVM.logo {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)
                    .transition(.scale.animation(.linear(duration: 0.3)))
                    
            }
            
            if didAnimate {
                ARHomeView()
                    .transition(.move(edge: .leading))
            } else {
                ARLaunchView()
                    .transition(.move(edge: .trailing))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ogixbzer()
        .task {
            try? await Task.sleep(for: .seconds(3))
            withAnimation(.linear(duration: 0.4)) {
                didAnimate = true
            }
        }
    }
}

#Preview {
    ARStartView()
        .environmentObject(ARGameVM())
        .environmentObject(ARSoundManager())
}
