
import SwiftUI

@MainActor
class ARRulesVM: ObservableObject {
    
    var arrayRules:[ARRulesModel] = [
        .init(
            title: ARRuleTypes.roulette.title,
            subTitle: ARRuleTypes.roulette.subTitle,
            image: ARRuleTypes.roulette.icon
        ),
        .init(
            title: ARRuleTypes.blackjack.title,
            subTitle: ARRuleTypes.blackjack.subTitle,
            image: ARRuleTypes.blackjack.icon
        )
    ]
    
}
