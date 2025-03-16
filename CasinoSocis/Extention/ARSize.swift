
import Foundation
import SwiftUI

enum ARSizesType {
    
    case titleSize50
    
    case titleSize45
    
    case titleSize40
    
    case titleSize35
    
    case titleSize30
    
    case titleSize28
    
    case titleSize26
    
    case titleSize24
    
    case titleSize22
    
    case titleSizeStandart
    
    case titleSize19
    
    case titleSize18
    
    case titleSize17
    
    case titleSizeRegular
    
    case titleSize15
    
    case titleSize14
    
    case titleSize13
    
    case titleSize12
    
    case titleSize11
    
    case titleSize10
    
    
    case subTitleSizeStandart
    
    case subTitleSize19
    
    case subTitleSize18
    
    case subTitleSize17
    
    case subTitleSizeRegular
    
    case subTitleSize15
    
    case subTitleSize14
    
    case subTitleSize13
    
    case subTitleSize12
    
    case subTitleSize11
    
    case subTitleSize10
    
    case subTitleSize9
    
    case subTitleSize8
    
    case subTitleSize7
    
    case subTitleSize6
    
    case subTitleSize5
    
    case subTitleSize4
    
        
    case iconSize48
    
    case iconSize24
    
    case iconSize22
    
    case iconSize20
    
                                
    case paddingTop
    
    case paddingBotton
    
    case paddingHoriz16
    
    case paddingHoriz20
    
    case paddingHVert16
    
    case paddingVert20
    
    
    case padding80
    
    case padding70
    
    case padding60
    
    case padding50
    
    case padding45
    
    case padding40
    
    case padding35
    
    case padding30
    
    case padding25
    
    case paddingStandart
    
    case padding19
    
    case padding18
    
    case padding17
    
    case paddingRegular
    
    case padding15
    
    case padding14
    
    case padding13
    
    case padding12
    
    case padding11
    
    case padding10
    
    case padding9
    
    case padding8
    
    case padding7
    
    case padding6
    
    case padding5
    
    case padding4
    
    
    case cornerRadius50
    
    case cornerRadius45
    
    case cornerRadius40
    
    case cornerRadius35
    
    case cornerRadius30
    
    case cornerRadius25
    
    case cornerRadius20
    
    case buttonHeight
    
    case segmentHeight
    
    case logoSize
            
    var sizes: CGFloat {
        switch self {
        case .titleSize50: 50
        
        case .titleSize45: 45
        
        case .titleSize40: 40
        
        case .titleSize35: 35
            
        case .titleSize30: 30
        
        case .titleSize28: 28
        
        case .titleSize26: 26
        
        case .titleSize24: 24
            
        case .titleSize22: 22
        
        case .titleSizeStandart: 20
        
        case .titleSize19: 29
        
        case .titleSize18: 18
        
        case .titleSize17: 17
        
        case .titleSizeRegular: 16
                
        case .titleSize15: 15
        
        case .titleSize14: 14
        
        case .titleSize13: 13
        
        case .titleSize12: 12
        
        case .titleSize11: 11
        
        case .titleSize10: 10
        
        
        case .subTitleSizeStandart: 20
        
        case .subTitleSize19: 19
        
        case .subTitleSize18: 18
        
        case .subTitleSize17: 17
        
        case .subTitleSizeRegular: 16
        
        case .subTitleSize15: 15
        
        case .subTitleSize14: 14
        
        case .subTitleSize13: 13
        
        case .subTitleSize12: 12
        
        case .subTitleSize11: 11
        
        case .subTitleSize10: 10
        
        case .subTitleSize9: 9
        
        case .subTitleSize8: 8
        
        case .subTitleSize7: 7
        
        case .subTitleSize6: 6
        
        case .subTitleSize5: 5
        
        case .subTitleSize4: 4
        
            
        case .iconSize48: 48
        
        case .iconSize24: 24
        
        case .iconSize22: 22
        
        case .iconSize20: 20
        
                                    
        case .paddingTop: 40
        
        case .paddingBotton: 20
        
        case .paddingHoriz16: 16
        
        case .paddingHoriz20: 20
        
        case .paddingHVert16: 16
        
        case .paddingVert20: 20
        
        
        case .padding80: 80
        
        case .padding70: 70
        
        case .padding60: 60
        
        case .padding50: 50
        
        case .padding45: 45
        
        case .padding40: 40
        
        case .padding35: 35
        
        case .padding30: 30
        
        case .padding25: 25
        
        case .paddingStandart: 20
        
        case .padding19: 19
        
        case .padding18: 18
        
        case .padding17: 17
        
        case .paddingRegular: 16
        
        case .padding15: 15
        
        case .padding14: 14
        
        case .padding13: 13
        
        case .padding12: 12
        
        case .padding11: 11
        
        case .padding10: 10
        
        case .padding9: 9
        
        case .padding8: 8
        
        case .padding7: 7
        
        case .padding6: 6
        
        case .padding5: 5
        
        case .padding4: 4
        
        
        case .cornerRadius50: 50
        
        case .cornerRadius45: 45
        
        case .cornerRadius40: 40
        
        case .cornerRadius35: 35
        
        case .cornerRadius30: 30
        
        case .cornerRadius25: 25
        
        case .cornerRadius20: 20
        
        case .buttonHeight: 50
            
        case .segmentHeight: 20
        
        case .logoSize: 44
       
        }
    }
}
