
import SwiftUI

struct ARSilverFrame: View {
    var image: ImageResource
    var title: String
    var subtitle: ARTableType?
    var isCoinRight: Bool = false
    
    var body: some View {
        VStack {
            ZStack(alignment: (subtitle == nil && !isCoinRight) ? .leading : .trailing) {
                Image(.silverFrame)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 146, height: 50)
                
                HStack(spacing: 6) {
                    if subtitle == nil && !isCoinRight {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                    
                    VStack(spacing: 0) {
                        Text(title)
                            .fonts(.titleSize24)
                            .foregroundStyle(Color.black)
                            .contentTransition(.numericText())
                        
                        if  let subtitle  {
                            Text(subtitle.title)
                                .fonts(.titleSize24)
                                .foregroundStyle(Color.black.opacity(0.6))
                                .contentTransition(.numericText())
                                .offset(y: -4)
                        }
                    }
                    
                    if subtitle != nil || isCoinRight {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .offset(y: isCoinRight ? 0 : -14)
                    }
                }
                .padding(subtitle == nil && !isCoinRight ? .leading : .trailing, 20)
            }
        }
    }
}

