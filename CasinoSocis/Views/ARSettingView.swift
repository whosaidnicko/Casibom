
import SwiftUI

struct ARSettingView: View {
    
    @EnvironmentObject var vm: ARGameVM
    @EnvironmentObject var soundVM: ARSoundManager
    
    @Binding var isCancel: Bool
    
    var body: some View {
        
        ZStack {
            HapticButton {
                withAnimation(.linear(duration: 0.3)) {
                    isCancel.toggle()
                }
            } label: {
                Image(.houseIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 68, height: 68)
            }
            .verAlig(.top, 40)
            .horAlig(.leading)
   
            VStack(spacing: 60){
                Text(ARSettingType.settings.title)
                    .font(.custom("PoetsenOne-Regular", size: 64))
                    .colorGradient()
                    
                HStack(spacing: 75) {
                    ARSettingCell(
                        imageOne: .musicEnable,
                        imageTwo: .musicDisable,
                        title: ARSettingType.music.title,
                        isSelected: $soundVM.isMusicOn
                    ) {
                        withAnimation {
                            soundVM.toggleMusic()
                        }
                    }
                    
                    ARSettingCell(
                        imageOne: .trebleEnable,
                        imageTwo: .trebleDissable,
                        title: ARSettingType.sound.title,
                        isSelected: $soundVM.isSoundOn
                    ) {
                        withAnimation {
                            soundVM.toggleSound()
                        }
                    }
                }
            }
            .verAlig(.top, 30)
        }
        .onChange(of: soundVM.isMusicOn) { newValue in
            soundVM.playMusic()
        }
        .onChange(of: soundVM.isSoundOn) { newValue in
//            soundVM.playMusic()
        }
    }
}

#Preview {
    ARSettingView(isCancel: .constant(true))
        .environmentObject(ARGameVM())
}

