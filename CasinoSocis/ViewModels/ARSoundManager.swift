

import SwiftUI
import AVFoundation


@MainActor
class ARSoundManager: ObservableObject {
    static var shared: ARSoundManager = ARSoundManager()
    @AppStorage("isMusicOn") var isMusicOn: Bool = true
    @AppStorage("isSoundOn") var isSoundOn: Bool = true
    
    public var backgroundMusicPlayer: AVAudioPlayer?
    private var rouletteSpinPlayer: AVAudioPlayer?
    private var rouletteStopPlayer: AVAudioPlayer?
    private var chipPlayer: AVAudioPlayer?
    private var buttonClickPlayer: AVAudioPlayer?
    private var coinDrop: AVAudioPlayer?
    private var razdacha: AVAudioPlayer?
    private var cardHide: AVAudioPlayer?
    
    init() {
        loadMusicSounds()
    }
    
    func urlPlayer(url: URL) -> AVAudioPlayer? {
        return try? AVAudioPlayer(contentsOf: url)
       
    }
    
    private func loadMusicSounds() {
        
        for typeSounds in ARSoundsType.allCases {
            guard  let url = Bundle.main.url(forResource: typeSounds.sounds.0, withExtension: typeSounds.sounds.1) else {return}
            
            switch typeSounds {
            case .wheelPlay: rouletteSpinPlayer = urlPlayer(url: url)

            case .wheelStop: rouletteStopPlayer = urlPlayer(url: url)
                
            case .chipsSound: chipPlayer = urlPlayer(url: url)
                
            case .coinDrop: coinDrop = urlPlayer(url: url)
                
            case .casinoMusic:
                backgroundMusicPlayer = urlPlayer(url: url)
                backgroundMusicPlayer?.numberOfLoops = -1 // Безкінечне повторення
                backgroundMusicPlayer?.volume = 0.1
                
            case .buttonClick:
                buttonClickPlayer = try? AVAudioPlayer(contentsOf: url)
                buttonClickPlayer?.volume = 0.08
                
            case .razdacha: razdacha = urlPlayer(url: url)
            case .cardHide: cardHide = urlPlayer(url: url)
            }
        }
    }
    
//MARK: Change toggle-
    func toggleMusic() {
        isMusicOn.toggle()
    }
    
    func toggleSound() {
        isSoundOn.toggle()
    }
    
 //MARK: Music Settings
    func playMusic() {
        if isMusicOn {
            backgroundMusicPlayer?.play()
        } else {
            backgroundMusicPlayer?.pause()
        }
    }
    
    func stopMusic() {
        backgroundMusicPlayer?.stop()
    }
    
//MARK: Sounds Settings
    func playRouletteSpin() {
        if isSoundOn {
            rouletteSpinPlayer?.play()
        }
    }
    
    func stopRouletteSpin() {
        if isSoundOn {
            rouletteSpinPlayer?.stop()
            rouletteStopPlayer?.play()
        }
    }
    
    func playChip() {
        if isSoundOn {
            chipPlayer?.play()
        }
    }
    
    func playButtonClick() {
        if isSoundOn {
            buttonClickPlayer?.play()
        }
    }
    
    func playCoinDrop() {
        if isSoundOn {
            coinDrop?.play()
        }
    }
    func playRazdacha() {
        if isSoundOn {
            razdacha?.play()
        }
    }
    
    func playCardHide() {
        if isSoundOn {
            cardHide?.play()
        }
    }
}
extension View {
    func ogixbzer() -> some View {
        self.modifier(Peradpbiza())
    }
    
}
