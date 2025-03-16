
import SwiftUI

struct ARRouletteView: View {

    @EnvironmentObject var gameVM: ARGameVM
    @EnvironmentObject var soundVM: ARSoundManager
    
    var body: some View {
        ZStack {
            HStack(spacing: 30) {
                ARSilverFrame(image: .coinIcon, title: "\(gameVM.betAmount)", subtitle: .bet)
                ARSilverFrame(image: .coinIcon, title: "\(gameVM.myCost)", subtitle: .gain)
            }
            .verAlig(.top, 35)
            .blur(radius: gameVM.isStart || gameVM.isClaim ? 20 : 0)
            
            FieldView()
            .blur(radius: gameVM.isStart || gameVM.isClaim ? 20 : 0)
            .verAlig(.bottom, 20)
                        
            HapticButton { withAnimation { gameVM.startGame() }
            } label: {
                Image(.startButton)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 72, height: 90)
            }
            .disabled(!gameVM.canStart || gameVM.isSpinning)
            .verAlig(.bottom, 10)
            .horAlig(.trailing, 20)
            .blur(radius: gameVM.isStart || gameVM.isClaim ? 20 : 0)
            
            if gameVM.isStart {
                ZStack {
                    HStack(spacing: 30) {
                        ARSilverFrame(image: .coinIcon, title: "\(gameVM.betAmount)", subtitle: .bet)
                        ARSilverFrame(image: .coinIcon, title: "\(gameVM.myCost)", subtitle: .gain)
                    }
                    .verAlig(.top, 35)
                    
                    WheelView()
                    .verAlig(.bottom, 20)
                    
                    if gameVM.isSpinning {
                        Text("SPIN...")
                            .fonts(.titleSize50)
                            .foregroundStyle(Color.whiteColor)
                            .horAlig(.trailing, 60)
                            .verAlig(.bottom, 150)
                            .transitionEffect()
                    } else {
                      ClaimView()
                    }
                }
                .frame(width: screenSize().width, height: screenSize().height)
                .background(.ultraThinMaterial.blendMode(.darken))
                .transition(.asymmetric(insertion: .push(from: .trailing),removal: .push(from: .leading)).combined(with: .scale).animation(.linear(duration: 0.2)))
            }
            
            if gameVM.isClaim {
                if let result = gameVM.lastResult {
                    ARResultViewCell(
                        cost: "\(result.amount > 0 ? "+" : "")\(result.amount)",
                        isWin: result.amount > 0 ? true : false,
                        action: { gameVM.actionClaimed() }
                    )
                    .transitionEffect()
                }
            }
        }
        .onChange(of: gameVM.isStart) { newValue in
            if gameVM.isStart == true {
                Task{
                    soundVM.playRouletteSpin()
                    try await Task.sleep(for: .seconds(3))
                    if gameVM.isStart == true && gameVM.isSpinning == false {
                        soundVM.stopRouletteSpin()
                    }
                }
            }
        }
    }
  
//MARK: -Field View
    
    @ViewBuilder
    private func FieldView() -> some View {
        ZStack {
            Image(.number)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 150, height: UIScreen.main.bounds.height - 135)
                .verAlig(.bottom)
            
            VStack {
                VStack {
                    HStack(spacing: 6) {
                        ForEach(gameVM.numbersZeroArray, id: \.self) { number in
                            ARNumberButton(
                                number: number,
                                bet: gameVM.bets.first { $0.number == number},
                                color: gameVM.colorForNumber(number),
                                width: 80,
                                height: 35,
                                action: { gameVM.toggleNumber(number) }
                            )
                        }
                    }

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: -5), count: 3),spacing: 9) {
                        ForEach(gameVM.numbersArray, id: \.self) { number in
                                ARNumberButton(
                                    number: number,
                                    bet: gameVM.bets.first { $0.number == number },
                                    color: gameVM.colorForNumber(number),
                                    action: { gameVM.toggleNumber(number) }
                                )
                            
                        }
                    }
                }
                .padding(.trailing, 18)
                .padding(.bottom, 16)
                .frame(width: 200,height: 180)
                .rotationEffect(.degrees(-90))
                
                VStack(spacing: 6) {
                    HStack(spacing: 6) {
                        ForEach(gameVM.groupBets, id: \.self) { group in
                            ARGroupBetButton(
                                title: group,
                                bet: gameVM.bets.first { $0.number == group }, // Передаем ставку
                                width: 150,
                                action: { gameVM.toggleNumber(group) }
                            )
                        }
                    }
                    .padding(.leading, 24)
                    
                    HStack(spacing: 6) {
                        ForEach(gameVM.groupBetsSorted, id: \.self) {group in
                            ARGroupBetButton(
                                title: group,
                                bet: gameVM.bets.first { $0.number == group },
                                width: 72,
                                action: { gameVM.toggleNumber(group) }
                            )
                        }
                    }
                    .padding(.leading, 26)
                }
                .padding(.top, 4)
            }
            .verAlig(.bottom, 6)
        }
    }
    
//MARK: -Wheel View
    @ViewBuilder
    private func WheelView() -> some View {
        ZStack {
            Image(.baze)
                .resizable()
                .scaledToFit()
                .frame(width: 280, height: 280)
            
            ARWheelView(numbers: ARWheelNumberType.allCases, sectorAngle: gameVM.sectorAngle, resultNumber: gameVM.resultNumber, isSpinning: gameVM.isSpinning)
                .rotationEffect(.degrees(gameVM.angle))
                .animation(gameVM.isSpinning ? .easeOut(duration: 3) : .linear, value: gameVM.angle)
            
            Image(.spineCentre)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
        }
    }
    
 //MARK: -Claim view
    @ViewBuilder
    private func ClaimView() -> some View {
        ForEach(ARWheelNumberType.allCases, id: \.self){number in
            if gameVM.resultNumber == number.value.0 {
                VStack {
                    HStack {
                        Text(number.value.0)
                            .fonts(.titleSize50)
                            .foregroundStyle(Color.blackColor)
                        
                        Image(number.value.1)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 75)
                            .rotationEffect(.degrees(number.value.1.contains("RED") ? 0 : 90))
                    }
                    
                    Text("It came out".uppercased())
                        .fonts(.titleSizeStandart)
                        .foregroundStyle(Color.whiteColor)
                    
                    ARGoldFrame(text: .claim) {
                        withAnimation(.linear(duration: 0.2)){
                            gameVM.isStart = false
                            gameVM.isClaim = true
                            gameVM.isSelectedChip = false
                        }
                    }
                }
                .horAlig(.trailing, 50)
                .verAlig(.bottom, 20)
                .transitionEffect()
            }
        }
    }
}

#Preview {
    ARRouletteView()
        .environmentObject(ARGameVM())
        .environmentObject(ARSoundManager())
}
