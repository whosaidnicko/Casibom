
import SwiftUI

struct ARSectorView: View {
    let number: String
    let index: Int
    let total: Int
    let size: CGFloat
    var resultNumber: String
    var isSpinning: Bool
    
    var angle: Double { Double(index) * 360 / Double(total) }
    var sectorAngle: Double { 360 / Double(total) }
    
    var body: some View {
        let textAngle = angle + sectorAngle / 2
        
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: size/2, y: size/2))
                path.addArc(
                    center: CGPoint(x: size/2, y: size/2),
                    radius: size/2,
                    startAngle: .degrees(angle),
                    endAngle: .degrees(angle + sectorAngle),
                    clockwise: false
                )
            }
            .fill(.clear)
            
            Text(number)
                .rotationEffect(.degrees(textAngle))
                .offset(x: size/3, y: 0)
                .rotationEffect(.degrees(textAngle))
                .foregroundColor(.clear)
                .font(.system(size: 14, weight: .bold))
                .overlay {
                    if !isSpinning {
                        if resultNumber == number {
                            if !resultNumber.isEmpty {
                                Image(.ball)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12, height: 12)
                                    .rotationEffect(.degrees(textAngle))
                                    .offset(x: size/3, y: 0)
                                    .rotationEffect(.degrees(textAngle))
                            }
                        }
                    }
                }
        }
    }
}
