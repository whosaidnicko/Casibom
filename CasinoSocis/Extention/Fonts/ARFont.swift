
import Foundation
import SwiftUI


extension View {
    func fonts(_ size: ARSizesType) -> some View {
        self.font(.custom("PoetsenOne-Regular", size: size.sizes))
    }
}
