//
//  SwitchType.swift
//  testi
//
//  Created by Jawad Ali on 29/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import Switches
enum SwitchType:String, CaseIterable  {
    
    case transition = "Transition Switches"
    case loading = "Loading Switches"
    case jelly = "Jelly Switches"
    case animated = "Animated Switches"
    case modeA = "Mode Switches"
    case modeB = "Cool Switches"
    case gradient = "Gradient Switches"
    case thumbImage = "Cover Switches"
    case smiley = "Smiley Switches"
    case ranndom = "Random Switches"
}
extension SwitchType {
    
    var coverSwitch: BaseControl {
        switch self {
        case .transition:
            let display = Switcher()
            display.superview?.layer.shadowOffset = .zero
            display.superview?.layer.shadowOpacity =  0.3
            display.superview?.layer.shadowRadius = 5
            return display
        case .loading:
            let display = SDSwitch()
            display.isLoadingEnabled = true
            display.thumbRadiusPadding = 5
            return display
        case .jelly:
            return TKLiquidSwitch()
        case .animated:
            let animatedStyleA = YapAnimatedSwitch()
            animatedStyleA.thumbRadiusPadding = 6
            animatedStyleA.offThumbTintColor = #colorLiteral(red: 0.9540559649, green: 0.8972979188, blue: 0.8275271654, alpha: 1)
            animatedStyleA.onThumbTintColor = #colorLiteral(red: 0.4935741425, green: 0.5258994699, blue: 0.9827957749, alpha: 1)
            animatedStyleA.onTintColor = .white
            animatedStyleA.offTintColor = .white
            animatedStyleA.tintColor = .white
            return animatedStyleA
        case .modeA:
            let modeSwitchStyleA = YapDarkAndLightModeSwitch()
            modeSwitchStyleA.thumbRadiusPadding = 8
            modeSwitchStyleA.thumbTintColor = #colorLiteral(red: 0.9683158994, green: 0.501380682, blue: 0.4961987734, alpha: 1)
            modeSwitchStyleA.offTintColor = .white
            modeSwitchStyleA.onTintColor = #colorLiteral(red: 0.6057969332, green: 0.6360527277, blue: 0.9815277457, alpha: 1)
            return modeSwitchStyleA
        case .modeB:
            let modeSwitchStyleA = YapModeSwitch()
            modeSwitchStyleA.thumbRadiusPadding = 8
            modeSwitchStyleA.thumbTintColor = #colorLiteral(red: 0.9683158994, green: 0.501380682, blue: 0.4961987734, alpha: 1)
            modeSwitchStyleA.offTintColor = .white
            modeSwitchStyleA.onTintColor = #colorLiteral(red: 0.6057969332, green: 0.6360527277, blue: 0.9815277457, alpha: 1)
            return modeSwitchStyleA
        case .gradient:
            let gradientSwitchVertical = YapGradientSwitch()
                gradientSwitchVertical.borderWidth = 2
                gradientSwitchVertical.gradientPosition = .vertical
                gradientSwitchVertical.onColors = [#colorLiteral(red: 0.722638309, green: 0.1586903036, blue: 0.2223222256, alpha: 1),#colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)]
                gradientSwitchVertical.offColors = [#colorLiteral(red: 0.1042157337, green: 0.4639918208, blue: 0.2866171598, alpha: 1),#colorLiteral(red: 0.1294117719, green: 0.1414276541, blue: 0.06666667014, alpha: 1)]
                gradientSwitchVertical.onText = "START"
                gradientSwitchVertical.offText = "STOP"
            return gradientSwitchVertical
            
        case .smiley:
            return TKSmileSwitch()
        case .thumbImage:
            let  thumbImageSwitchC = YapSwitch()
            thumbImageSwitchC.onThumbImage = #imageLiteral(resourceName: "right")
            thumbImageSwitchC.offThumbImage = #imageLiteral(resourceName: "left")
            thumbImageSwitchC.onTintColor = #colorLiteral(red: 0.6210919023, green: 0.3142792583, blue: 0.6986252666, alpha: 1)
            thumbImageSwitchC.onText = "OFF"
            thumbImageSwitchC.offText = "ON"
            thumbImageSwitchC.offTextColor = #colorLiteral(red: 0.6210919023, green: 0.3142792583, blue: 0.6986252666, alpha: 1)
            thumbImageSwitchC.offBorderColor = #colorLiteral(red: 0.8901180029, green: 0.8902462125, blue: 0.8900898695, alpha: 1)
            thumbImageSwitchC.onBorderColor = #colorLiteral(red: 0.6210919023, green: 0.3142792583, blue: 0.6986252666, alpha: 1)
            thumbImageSwitchC.thumbRadiusPadding = 8
            thumbImageSwitchC.borderWidth = 3
            thumbImageSwitchC.offTintColor =  #colorLiteral(red: 0.9568627451, green: 0.9587000478, blue: 0.9568627451, alpha: 1)
            return thumbImageSwitchC
        case .ranndom:
            let randomB = YapSwitchSlim()
            
            randomB.onThumbTintColor = #colorLiteral(red: 0.0864540413, green: 0.5291488171, blue: 0.5380262733, alpha: 1)
            randomB.onTintColor = #colorLiteral(red: 0.4112847149, green: 0.7173692584, blue: 0.7089804411, alpha: 1)
            randomB.offTintColor = #colorLiteral(red: 0.5372059941, green: 0.5372863412, blue: 0.5371884108, alpha: 1)
            randomB.slimTrack = 10
            randomB.thumbRadiusPadding = 0
            return randomB
            
        }
    }
}
