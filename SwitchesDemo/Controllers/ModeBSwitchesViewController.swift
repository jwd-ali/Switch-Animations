//
//  ModeBSwitchesViewController.swift
//  testi
//
//  Created by Jawad Ali on 22/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import Switches
class ModeBSwitchesViewController: UIViewController {

  @IBOutlet weak var modeSwitchStyleA: YapModeSwitch! {
        didSet {
            modeSwitchStyleA.thumbRadiusPadding = 8
            modeSwitchStyleA.thumbTintColor = #colorLiteral(red: 0.9683158994, green: 0.501380682, blue: 0.4961987734, alpha: 1)
            modeSwitchStyleA.offTintColor = .white
            modeSwitchStyleA.onTintColor = #colorLiteral(red: 0.6057969332, green: 0.6360527277, blue: 0.9815277457, alpha: 1)
        }
    }
    @IBOutlet weak var modeSwitchStyleB: YapModeSwitch! {
        didSet {
            modeSwitchStyleB.thumbRadiusPadding = 8
            modeSwitchStyleB.thumbTintColor = .white
            modeSwitchStyleB.offTintColor = #colorLiteral(red: 0.2786044478, green: 0.5705410242, blue: 0.9243882298, alpha: 1)
            modeSwitchStyleB.onTintColor = #colorLiteral(red: 0.3037858903, green: 0.1899323463, blue: 0.6803773642, alpha: 1)
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        modeSwitchStyleB.addTarget(self, action: #selector(switchBToggle(_:)), for: .valueChanged)
        
        ( navigationController?.navigationBar as? JDNavigationBar)?.changeColor(#colorLiteral(red: 0.9683158994, green: 0.501380682, blue: 0.4961987734, alpha: 1))
             
         ( navigationController?.navigationBar as? JDNavigationBar)?.heightShape = 90
        ( navigationController?.navigationBar as? JDNavigationBar)?.shape = .folded
        title  = "Dark Light A Mode"
    }
    
    
    @objc func switchBToggle(_ sender: YapDarkAndLightModeSwitch) {
        
        let color = sender.isOn ? #colorLiteral(red: 0.5881829262, green: 0.4660730958, blue: 0.9921956658, alpha: 1) : .white
        
        UIView.animate(withDuration: sender.duration) {
            self.modeSwitchStyleB.superview?.backgroundColor = color
        }
        
    }

}
