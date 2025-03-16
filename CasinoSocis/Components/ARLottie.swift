
import SwiftUI
import Lottie

struct ARLottieView: UIViewRepresentable {
    var filename: String
    var color: UIColor

    class Coordinator: NSObject {
        var parent: ARLottieView

        init(_ parent: ARLottieView) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        applyColor(animationView: animationView, color: color)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        let animationView = uiView.subviews.first as! LottieAnimationView
        applyColor(animationView: animationView, color: color)
    }

    private func applyColor(animationView: LottieAnimationView, color: UIColor) {
        let keypath = AnimationKeypath(keypath: "**.Fill 1.Color") // Обновите keypath в соответствии со структурой вашего Lottie JSON файла
        let colorProvider = ColorValueProvider(color.lottieColorValue)
        animationView.setValueProvider(colorProvider, keypath: keypath)
    }
}

extension UIColor {
    var lottieColorValue: LottieColor {
        LottieColor(r: Double(self.cgColor.components?[0] ?? 0), g: Double(self.cgColor.components?[1] ?? 0), b: Double(self.cgColor.components?[2] ?? 0), a: Double(self.cgColor.components?[3] ?? 1))
    }
}
