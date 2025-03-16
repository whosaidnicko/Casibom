import SwiftUI

struct HapticButton<Label: View>: View {
    
    @EnvironmentObject var soundManager: ARSoundManager
    
    var role: ButtonRole? = .none
    let action: () -> Void
    let label: () -> Label

    var body: some View {
        Button(role: role, action: {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            soundManager.playButtonClick()
            action()
        }, label: {
            label()
        })
    }
}

extension HapticButton where Label == Text {
    init(_ role: ButtonRole, _ titleKey: LocalizedStringKey, action: @escaping () -> Void) {
        self.action = action
        self.label = { Text(titleKey) }
        self.role = role
    }
    
    init<S>(_ role: ButtonRole ,_ title: S, action: @escaping () -> Void) where S : StringProtocol {
        self.action = action
        self.label = { Text(title) }
        self.role = role
    }
}
