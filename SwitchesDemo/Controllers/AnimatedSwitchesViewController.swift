//
//  AimatedSwitchedViewController.swift
//  testi
//
//  Created by Jawad Ali on 21/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import Switches
class AnimatedSwitchesViewController: UIViewController {

    @IBOutlet weak var animatedStyleA: YapAnimatedSwitch! {
        didSet {
            animatedStyleA.thumbRadiusPadding = 6
            animatedStyleA.offThumbTintColor = #colorLiteral(red: 0.9540559649, green: 0.8972979188, blue: 0.8275271654, alpha: 1)
            animatedStyleA.onThumbTintColor = #colorLiteral(red: 0.4935741425, green: 0.5258994699, blue: 0.9827957749, alpha: 1)
            animatedStyleA.onTintColor = .white
            animatedStyleA.offTintColor = .white
            animatedStyleA.tintColor = .white
        }
    }
    @IBOutlet weak var animatedStyleB: YapAnimatedSwitch! {
        didSet {
            animatedStyleB.thumbRadiusPadding = 6
            animatedStyleB.thumbTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            animatedStyleB.animationWidth = 5
            animatedStyleB.onTintColor = #colorLiteral(red: 0.2841374278, green: 0.651584208, blue: 0.2687274218, alpha: 1)
            animatedStyleB.isOn = true
            animatedStyleB.offTintColor = #colorLiteral(red: 0.1686089635, green: 0.1686392426, blue: 0.1686022878, alpha: 1)
            animatedStyleB.onAnimationColor = #colorLiteral(red: 0.2841374278, green: 0.651584208, blue: 0.2687274218, alpha: 1)
            animatedStyleB.offAnimationColor = #colorLiteral(red: 0.1686089635, green: 0.1686392426, blue: 0.1686022878, alpha: 1)
        }
    }
    override func viewDidLoad() {
        
         ( navigationController?.navigationBar as? JDNavigationBar)?.changeColor(#colorLiteral(red: 0.4935741425, green: 0.5258994699, blue: 0.9827957749, alpha: 1))
         ( navigationController?.navigationBar as? JDNavigationBar)?.cycles = 15
        title = "Animated Switches"
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
