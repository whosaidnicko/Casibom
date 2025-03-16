
import SwiftUI

@main
struct CasinoSocis: App {
    
    @StateObject var gameVM = ARGameVM()
    @StateObject var soundVM = ARSoundManager.shared
    @StateObject var blackJackVM = ARBlackJackVM()
    
    var body: some Scene {
        WindowGroup {
            ARStartView()
                .environmentObject(gameVM)
                .environmentObject(soundVM)
                .environmentObject(blackJackVM)
                .task {
                    gameVM.logo = true
                    soundVM.playMusic()
                    
                 
                      
                    
                }
            
        }
    }
}

import AVFoundation

func feedBackGeneration() {
    let generator = UIImpactFeedbackGenerator(style: .medium)
    generator.impactOccurred()
}
class AppDelegate: NSObject, UIApplicationDelegate {
    static var asiuqzoptqxbt = UIInterfaceOrientationMask.landscape {
        didSet {
            if #available(iOS 16.0, *) {
                UIApplication.shared.connectedScenes.forEach { scene in
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: asiuqzoptqxbt))
                    }
                }
                UIViewController.attemptRotationToDeviceOrientation()
            } else {
                if asiuqzoptqxbt == .landscape {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                } else {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                }
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.asiuqzoptqxbt
    }
}


