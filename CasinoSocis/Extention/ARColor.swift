

import Foundation
import SwiftUI

typealias ARColor = Color

extension ARColor {
    
    static let whiteColor = Color(red: 255/255, green: 255/255, blue: 255/255)
    static let blackColor = Color(red: 0/255, green: 0/255, blue: 0/255)
    static let goldColor = Color(red: 245/255, green: 171/255, blue: 8/255)
    static let orangeColor = Color(red: 203/255, green: 114/255, blue: 19/255)
    static let yellowColor = Color(red: 253/255, green: 239/255, blue: 39/255)
    
  }

  struct ButtonLineGradient: ViewModifier {
      let firstColor = Color(red: 203/255, green: 114/255, blue: 19/255)
      let secondColor = Color(red: 253/255, green: 239/255, blue: 39/255)
      
      func body(content: Content) -> some View {
          content
              .foregroundStyle(LinearGradient(colors: [firstColor, secondColor, firstColor], startPoint: .leading, endPoint: .trailing))
      }
  }

  extension View {
      func colorGradient() -> some View {
          self.modifier(ButtonLineGradient())
      }
  }

