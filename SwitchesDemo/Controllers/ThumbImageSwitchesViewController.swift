//
//  ThumbImageSwitchesViewController.swift
//  testi
//
//  Created by Jawad Ali on 24/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import Switches
class ThumbImageSwitchesViewController: UIViewController {

    @IBOutlet weak var thumbImageSwitchD: YapSwitch! {
        didSet {
            thumbImageSwitchD.onThumbImage = UIImage(named: "go1")
            thumbImageSwitchD.offThumbImage = UIImage(named: "go2")
            thumbImageSwitchD.onTintColor = #colorLiteral(red: 0.6870710254, green: 0.2686487734, blue: 0.2165684998, alpha: 1)
            thumbImageSwitchD.offTintColor = #colorLiteral(red: 0.3156668544, green: 0.4091051519, blue: 0.481534183, alpha: 1)
            thumbImageSwitchD.thumbRadiusPadding = 8
            thumbImageSwitchD.isStretchEnable = false
        }
    }
    @IBOutlet weak var thumbImageSwitchC: YapSwitch! {
        didSet {
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
        }
    }
    @IBOutlet weak var thumbImageSwitchB: YapSwitch! {
        didSet {
            thumbImageSwitchB.onTextColor = #colorLiteral(red: 0.3056051731, green: 0.4627509713, blue: 0.01093915664, alpha: 1)
            thumbImageSwitchB.offTextColor = #colorLiteral(red: 0.5544068813, green: 0.08276418597, blue: 0.07942076772, alpha: 1)
            thumbImageSwitchB.thumbImage = UIImage(named: "thumb7")
            thumbImageSwitchB.thumbTintColor = .red
            thumbImageSwitchB.onText =  "ON"
            thumbImageSwitchB.offText = "OFF"
            thumbImageSwitchB.thumbRadiusPadding = 1
            thumbImageSwitchB.thumbTintColor = .clear
            thumbImageSwitchB.borderWidth = 3
            thumbImageSwitchB.borderColor = #colorLiteral(red: 0.729346931, green: 0.7294533849, blue: 0.729323566, alpha: 1)
            thumbImageSwitchB.onTintColor = #colorLiteral(red: 0.6511958838, green: 0.8345313668, blue: 0.2781367004, alpha: 1)
            thumbImageSwitchB.offTintColor = #colorLiteral(red: 0.9100278616, green: 0.2768563628, blue: 0.2796021998, alpha: 1)
        }
    }
    @IBOutlet weak var thumbImageSwitchA: YapSwitchSlim! {
        didSet {
            thumbImageSwitchA.thumbImage = UIImage(named: "thumb4")
            thumbImageSwitchA.onText =  "NO"
            thumbImageSwitchA.offText = "YES"
            thumbImageSwitchA.shape = .square
            thumbImageSwitchA.thumbRadiusPadding = 6
            thumbImageSwitchA.slimTrack = 5
            thumbImageSwitchA.thumbTintColor = .clear
            thumbImageSwitchA.borderWidth = 3
            thumbImageSwitchA.borderColor = #colorLiteral(red: 0.752874434, green: 0.7529839873, blue: 0.7528504729, alpha: 1)
            thumbImageSwitchA.onTintColor = #colorLiteral(red: 0.8561109304, green: 0.2607076168, blue: 0.5694340467, alpha: 1)
            thumbImageSwitchA.offTintColor = #colorLiteral(red: 0.09238574654, green: 0.4540643692, blue: 0.61872226, alpha: 1)
            thumbImageSwitchA.superview?.layer.shadowOffset = .zero
            thumbImageSwitchA.superview?.layer.shadowOpacity =  0.3
            thumbImageSwitchA.superview?.layer.shadowRadius = 5
        }
    }
    override func viewDidLoad() {
        
//        thumbImageSwitchA.valueChange = { [unowned self] isSuccess in
//            isSuccess ? (self.thumbImageSwitchA.superview?.superview?.backgroundColor = self.thumbImageSwitchA.onTintColor.withAlphaComponent(0.5)) : (self.thumbImageSwitchA.superview?.superview?.backgroundColor = self.thumbImageSwitchA.offTintColor.withAlphaComponent(0.5))
//        }
        title = "Thumb Image Switch"
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
