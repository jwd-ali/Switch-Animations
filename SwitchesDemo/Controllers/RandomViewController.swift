//
//  RandomViewController.swift
//  testi
//
//  Created by Jawad Ali on 25/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import Switches
 class RandomViewController: UIViewController {
    @IBOutlet weak var randomA: YapSwitch! {
        didSet {
            randomA.onText = "ON"
            randomA.offText = "OFF"
            randomA.onTextColor = .white
            randomA.offTextColor = #colorLiteral(red: 0.2125092149, green: 0.2516930103, blue: 0.2772026062, alpha: 1)
            randomA.borderColor = #colorLiteral(red: 0.2125092149, green: 0.2516930103, blue: 0.2772026062, alpha: 1)
            randomA.onTintColor = #colorLiteral(red: 0.2125092149, green: 0.2516930103, blue: 0.2772026062, alpha: 1)
            
            randomA.offTextColor = #colorLiteral(red: 0.2125092149, green: 0.2516930103, blue: 0.2772026062, alpha: 1)
            randomA.offTintColor = .white
            randomA.offThumbTintColor = #colorLiteral(red: 0.2125092149, green: 0.2516930103, blue: 0.2772026062, alpha: 1)
            randomA.borderWidth = 2
        }
    }
    @IBOutlet weak var randomB: YapSwitchSlim! {
        didSet {
            randomB.onThumbTintColor = #colorLiteral(red: 0.0864540413, green: 0.5291488171, blue: 0.5380262733, alpha: 1)
            randomB.onTintColor = #colorLiteral(red: 0.4112847149, green: 0.7173692584, blue: 0.7089804411, alpha: 1)
            randomB.offTintColor = #colorLiteral(red: 0.5372059941, green: 0.5372863412, blue: 0.5371884108, alpha: 1)
            randomB.slimTrack = 10
            randomB.thumbRadiusPadding = 0
        }
    }
    @IBOutlet weak var randomC: YapSwitch! {
        didSet {
            randomC.onThumbImage = UIImage(named: "check")
            randomC.onTintColor = .purple
            randomC.offTintColor = #colorLiteral(red: 0.8552142978, green: 0.8781172037, blue: 0.9388162494, alpha: 1)
        }
    }
    
    @IBOutlet weak var randomD: YapSwitch! {
        didSet {
            randomD.onThumbTintColor = #colorLiteral(red: 0.1970949173, green: 0.799264133, blue: 0.8020008206, alpha: 1)
            randomD.onThumbImage = #imageLiteral(resourceName: "check").maskWithColor(color: .white)
            randomD.offThumbImage = #imageLiteral(resourceName: "close").maskWithColor(color: #colorLiteral(red: 0.170032382, green: 0.2437844872, blue: 0.3120466471, alpha: 1))
            randomD.offThumbTintColor = #colorLiteral(red: 0.8940391541, green: 0.8941679597, blue: 0.8940110803, alpha: 1)
            randomD.onTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            randomD.offTintColor = #colorLiteral(red: 0.170032382, green: 0.2437844872, blue: 0.3120466471, alpha: 1)
        }
    }
    @IBOutlet weak var randomE: YapSwitch! {
        didSet {
            randomE.onTextColor = #colorLiteral(red: 0.2311643958, green: 0.8008779883, blue: 0.6899323463, alpha: 1)
            randomE.offTextColor = #colorLiteral(red: 0.9092465753, green: 0.8114833048, blue: 0.810734161, alpha: 1)
            randomE.onThumbTintColor = #colorLiteral(red: 0.127592504, green: 0.7816838622, blue: 0.6617996693, alpha: 1)
            randomE.offThumbTintColor = #colorLiteral(red: 0.9092465753, green: 0.8114833048, blue: 0.810734161, alpha: 1)
            randomE.onText =  "ON"
            randomE.offText = "OFF"
            randomE.onTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            randomE.offTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
   
    @IBOutlet weak var randomG: YapSwitch! {
        didSet {
            randomG.thumbTintColor = .yellow
                 randomG.onText = "OFF"
                 randomG.offText = "ON"
            
                 randomG.onTintColor = .black
                 randomG.borderWidth = 4
                 randomG.textColor = .cyan
                 randomG.offTintColor = .black
                randomG.onTextColor = .white
        }
    }
    @IBOutlet weak var randomH: YapSwitch! {
        didSet {
            randomH.onImage = UIImage(named: "icon_check_primary_dark")?.maskWithColor(color: .black)
            randomH.offImage = UIImage(named: "icon_close_dark_purple")?.maskWithColor(color: .red)
            randomH.shape = .square
            randomH.onTintColor = .yellow
            randomH.borderWidth = 5
            randomH.thumbCornerRadius = 0
            randomH.offTintColor = .green
        }
    }
    @IBOutlet weak var randomI: YapSwitch! {
        didSet {
        randomI.onThumbImage = UIImage(named: "check")
               randomI.offThumbImage = UIImage(named: "close")
               randomI.shape = .square
               randomI.onTintColor = .purple
               randomI.borderWidth = 2
               randomI.thumbCornerRadius = 0
               randomI.offTintColor = .red
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Random Switches"
        // Do any additional setup after loading the view.
    }
    


}
