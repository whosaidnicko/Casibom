
import SwiftUI

struct ARSettingCell: View {
    
    var imageOne: ImageResource
    var imageTwo: ImageResource
    var title: String
    @Binding var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
 
            HapticButton {
                action()
            } label: {
                VStack {
                    IconView
                    Text(title)
                        .fonts(.titleSize35)
                        .foregroundStyle(isSelected ? Color.whiteColor : Color.gray)
            }
        }
    }
    
    @ViewBuilder
    var IconView: some View {
        Group {
            switch isSelected {
            case true:
                Image(imageOne)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 115, height: 115)
            case false:
                Image(imageTwo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 115, height: 115)
            }
        }
        .transitionEffect()
    }
}
