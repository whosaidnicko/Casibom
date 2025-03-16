

import Foundation
import SwiftUI

extension View {
    
    func horAlig(_ alignment: Alignment, _ padding: CGFloat? = 0) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
            .padding(.horizontal, padding)
    }
    
    func verAlig(_ alignment: Alignment, _ padding: CGFloat? = 0) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
            .padding(.vertical, padding)
    }
    
}
