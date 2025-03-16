
import SwiftUI

struct ARFlipTransition: ViewModifier, Animatable {
    var progress: CGFloat = 0
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(progress < 0 ? (-progress < 0.5 ? 1 : 0) : (progress < 0.5 ? 1 : 0))
            .rotation3DEffect(.degrees(progress * 180), axis: (x: 0, y: 1, z: 0))
    }
}

extension AnyTransition {
    static let flip: AnyTransition = .modifier(active: ARFlipTransition(progress: -1), identity: ARFlipTransition())
    
    static let flipBack: AnyTransition = .modifier(active: ARFlipTransition(progress: 1), identity: ARFlipTransition())
}
