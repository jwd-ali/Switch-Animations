//
//  JellySwitchesViewController.swift
//  testi
//
//  Created by Jawad Ali on 24/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import Switches
class JellySwitchesViewController: UIViewController {
    
    @IBOutlet weak var fullStretchSwitch: YapFullStretchSwitch! {
        didSet {
            fullStretchSwitch.onThumbImage = UIImage(named: "check")
            fullStretchSwitch.thumbRadiusPadding = 0
            fullStretchSwitch.borderColor = #colorLiteral(red: 0.7999292612, green: 0.8000453115, blue: 0.7999040484, alpha: 1)
            fullStretchSwitch.borderWidth = 3
            fullStretchSwitch.onTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            fullStretchSwitch.offTintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
    }
    @IBOutlet weak var halfStretchSwitch: YapHalfStretchSwitch! {
        didSet {
            
            halfStretchSwitch.shape = .square
            halfStretchSwitch.thumbRadiusPadding = 4
            halfStretchSwitch.borderColor = #colorLiteral(red: 0.7999292612, green: 0.8000453115, blue: 0.7999040484, alpha: 1)
            halfStretchSwitch.borderWidth = 2
            halfStretchSwitch.onTintColor = #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1)
            halfStretchSwitch.offTintColor = #colorLiteral(red: 0.345902741, green: 0.7542000413, blue: 0.4488890171, alpha: 1)
            
        }
    }
    @IBOutlet weak var jellySwitch: YapLiquidSwitch!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        ( navigationController?.navigationBar as? JDNavigationBar)?.changeColor(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1))
               ( navigationController?.navigationBar as? JDNavigationBar)?.shape = .zigzag
               ( navigationController?.navigationBar as? JDNavigationBar)?.heightShape = 30
               ( navigationController?.navigationBar as? JDNavigationBar)?.cycles = 5
        
        title = "Jelly Switch"
    }
}
