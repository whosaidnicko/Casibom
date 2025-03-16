
import Foundation
import SwiftUI

extension Image {
    func resizableImage(_ size: CGSize) -> some View {
        self.resizable()
            .frame(width: size.width, height: size.height)
    }
    
    func resizableIcon(_ size: CGFloat) -> some View {
        self.resizable()
            .frame(width: size, height: size)
    }
    
    func detailedImageSize() -> some View {
        self.resizable()
            .frame(maxHeight: 200)
    }
}
