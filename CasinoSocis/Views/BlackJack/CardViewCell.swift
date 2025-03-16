
import SwiftUI

struct CardViewCell: View  {
    var card: Card
    
    var body: some View {
        MapView(rank: card.rank, suit: card.suit)
            .scaledToFill()
            .frame(width: 46, height: 70)
            .clipped()
    }
    @ViewBuilder
    func  MapView(rank: CardRank, suit: CardSuit) -> some View   {
        Group {
            switch (rank, suit) {
            case (.two, .spades): Image(.spades2).resizable()
            case (.three, .spades): Image(.spades3).resizable()
            case (.four, .spades): Image(.spades4).resizable()
            case (.five, .spades): Image(.spades5).resizable()
            case (.six, .spades): Image(.spades6).resizable()
            case (.seven, .spades): Image(.spades7).resizable()
            case (.eight, .spades): Image(.spades8).resizable()
            case (.nine, .spades): Image(.spades9).resizable()
            case (.ten, .spades): Image(.spades10).resizable()
            case (.jack, .spades): Image(.spadesJack).resizable()
            case (.queen, .spades): Image(.spadesQueen).resizable()
            case (.king, .spades): Image(.spadesKing).resizable()
            case (.ace, .spades): Image(.spadesAce).resizable()
                
            case (.two, .hearts): Image(.hearts2).resizable()
            case (.three, .hearts): Image(.hearts3).resizable()
            case (.four, .hearts): Image(.hearts4).resizable()
            case (.five, .hearts): Image(.hearts5).resizable()
            case (.six, .hearts): Image(.hearts6).resizable()
            case (.seven, .hearts): Image(.hearts7).resizable()
            case (.eight, .hearts): Image(.hearts8).resizable()
            case (.nine, .hearts): Image(.hearts9).resizable()
            case (.ten, .hearts): Image(.hearts10).resizable()
            case (.jack, .hearts): Image(.heartsJack).resizable()
            case (.queen, .hearts): Image(.heartsQueen).resizable()
            case (.king, .hearts): Image(.heartsKing).resizable()
            case (.ace, .hearts): Image(.heartsAce).resizable()
                
            case (.two, .diamonds): Image(.diamonds2).resizable()
            case (.three, .diamonds): Image(.diamonds3).resizable()
            case (.four, .diamonds): Image(.diamonds4).resizable()
            case (.five, .diamonds): Image(.diamonds5).resizable()
            case (.six, .diamonds): Image(.diamonds6).resizable()
            case (.seven, .diamonds): Image(.diamonds7).resizable()
            case (.eight, .diamonds): Image(.diamonds8).resizable()
            case (.nine, .diamonds): Image(.diamonds9).resizable()
            case (.ten, .diamonds): Image(.diamonds10).resizable()
            case (.jack, .diamonds): Image(.diamondsJack).resizable()
            case (.queen, .diamonds): Image(.diamondsQueen).resizable()
            case (.king, .diamonds): Image(.diamondsKing).resizable()
            case (.ace, .diamonds): Image(.diamondsAce).resizable()
                
            case (.two, .clubs): Image(.clubs2).resizable()
            case (.three, .clubs): Image(.clubs3).resizable()
            case (.four, .clubs): Image(.clubs4).resizable()
            case (.five, .clubs): Image(.clubs5).resizable()
            case (.six, .clubs): Image(.clubs6).resizable()
            case (.seven, .clubs): Image(.clubs7).resizable()
            case (.eight, .clubs): Image(.clubs8).resizable()
            case (.nine, .clubs): Image(.clubs9).resizable()
            case (.ten, .clubs): Image(.clubs10).resizable()
            case (.jack, .clubs): Image(.clubsJack).resizable()
            case (.queen, .clubs): Image(.clubsQueen).resizable()
            case (.king, .clubs): Image(.clubsKing).resizable()
            case (.ace, .clubs): Image(.clubsAce).resizable()
            }
        }
        .transitionEffect()
    }
}
