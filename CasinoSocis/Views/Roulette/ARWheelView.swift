//
//  ARWheelView.swift

import SwiftUI

struct ARWheelView: View {
    let numbers: [ARWheelNumberType]
    let sectorAngle: Double
    var resultNumber: String
    var isSpinning: Bool
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image(.spin)
                    .resizable()
                    .scaledToFit()
                
                ForEach(0..<numbers.count, id: \.self) { index in
                    ARSectorView(
                        number: numbers[index].value.0,
                        index: index,
                        total: numbers.count,
                        size: min(proxy.size.width, proxy.size.height),
                resultNumber: self.resultNumber,
                        isSpinning: isSpinning
                                 
                    )
                }
            }
        }
        .frame(width: 210, height: 210)
    }
}
