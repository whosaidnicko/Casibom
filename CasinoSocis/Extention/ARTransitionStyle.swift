import SwiftUI

struct ARTransitionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .transition(
                .asymmetric(
                    insertion: .push(from: .trailing),
                    removal: .push(from: .leading)
                )
                .combined(with: .scale)
                .animation(.spring(response: 0.6, dampingFraction: 0.6))
            )
    }
}

extension View {
    func transitionEffect() -> some View {
        self.modifier(ARTransitionStyle())
    }
}
