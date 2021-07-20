//
//  GradientSwitchesViewController.swift
//  testi
//
//  Created by Jawad Ali on 23/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import Switches
class GradientSwitchesViewController: UIViewController {

    private lazy var gradientLayerVertical = CAGradientLayer()
    private lazy var gradientLayerHorizantal = CAGradientLayer()
    
    @IBOutlet weak var gradientSwitchHorizantal: YapGradientSwitch! {
        didSet {
            gradientSwitchHorizantal.gradientPosition = .horizatal
            gradientSwitchHorizantal.onColors = [#colorLiteral(red: 0.2394029498, green: 0.8576775193, blue: 0.6665194631, alpha: 1),#colorLiteral(red: 0.04418379813, green: 0.5335158706, blue: 0.5292400718, alpha: 1)]
            gradientSwitchHorizantal.offColors = [#colorLiteral(red: 0.1861540377, green: 0.2199867666, blue: 0.2542595267, alpha: 1),#colorLiteral(red: 0.1861540377, green: 0.2199867666, blue: 0.2542595267, alpha: 1)]
            
            gradientSwitchHorizantal.onText = "ON"
            gradientSwitchHorizantal.offText = "OFF"
        }
    }
    @IBOutlet weak var gradientSwitchVertical: YapGradientSwitch!{
        didSet {
            gradientSwitchVertical.borderWidth = 2
            gradientSwitchVertical.gradientPosition = .vertical
            gradientSwitchVertical.onColors = [#colorLiteral(red: 0.722638309, green: 0.1586903036, blue: 0.2223222256, alpha: 1),#colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)]
            gradientSwitchVertical.offColors = [#colorLiteral(red: 0.1042157337, green: 0.4639918208, blue: 0.2866171598, alpha: 1),#colorLiteral(red: 0.1294117719, green: 0.1414276541, blue: 0.06666667014, alpha: 1)]
            
            gradientSwitchVertical.onText = "START"
            gradientSwitchVertical.offText = "STOP"
        }
    }
    override func viewDidLoad() {
         super.viewDidLoad()
        
        gradientSwitchVertical.superview?.layer.insertSublayer(gradientLayerVertical, at: 0)
        gradientLayerVertical.colors = gradientSwitchVertical.offColors.map{$0.withAlphaComponent(0.7).cgColor}
        
        gradientSwitchHorizantal.superview?.layer.insertSublayer(gradientLayerHorizantal, at: 0)
        gradientLayerHorizantal.colors = gradientSwitchHorizantal.offColors.map{$0.withAlphaComponent(0.3).cgColor}
        
        gradientSwitchVertical.addTarget(self, action: #selector(switchVerticalToggle(_:)), for: .valueChanged)
        gradientSwitchHorizantal.addTarget(self, action: #selector(switchHorizantalToggle(_:)), for: .valueChanged)
       
            title = "Gradient Switches"
        
        
        // Do any additional setup after loading the view.
    }
    
   
    
    override func viewDidLayoutSubviews() {
        gradientLayerVertical.frame = gradientSwitchVertical.superview?.bounds ?? .zero
        gradientLayerHorizantal.frame = gradientSwitchHorizantal.superview?.bounds ?? .zero
    }
    
    @objc func switchVerticalToggle(_ sender: YapDarkAndLightModeSwitch) {
        
        sender.isOn ? gradientLayerVertical.animateGradientColors(from: gradientSwitchVertical.offColors.map{$0.withAlphaComponent(0.7).cgColor}, to: gradientSwitchVertical.onColors.map{$0.withAlphaComponent(0.7).cgColor}, duration: 0.5) : gradientLayerVertical.animateGradientColors(from: gradientSwitchVertical.onColors.map{$0.withAlphaComponent(0.7).cgColor}, to: gradientSwitchVertical.offColors.map{$0.withAlphaComponent(0.7).cgColor}, duration: 0.5)
        
        
        
    }
    @objc func switchHorizantalToggle(_ sender: YapDarkAndLightModeSwitch) {
           
           sender.isOn ? gradientLayerHorizantal.animateGradientColors(from: gradientSwitchHorizantal.offColors.map{$0.withAlphaComponent(0.3).cgColor}, to: gradientSwitchHorizantal.onColors.map{$0.withAlphaComponent(0.3).cgColor}, duration: 0.5) : gradientLayerHorizantal.animateGradientColors(from: gradientSwitchHorizantal.onColors.map{$0.withAlphaComponent(0.3).cgColor}, to: gradientSwitchHorizantal.offColors.map{$0.withAlphaComponent(0.3).cgColor}, duration: 0.5)
           
           
           
       }

  

}
