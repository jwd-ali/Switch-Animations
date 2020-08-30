//
//  SwiftyViewController.swift
//  testi
//
//  Created by Jawad Ali on 24/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import Switches
class SwiftyViewController: UIViewController {

    @IBOutlet weak var swiftyA: Switcher! {
        didSet {
            swiftyA.superview?.layer.shadowOffset = .zero
            swiftyA.superview?.layer.shadowOpacity =  0.3
            swiftyA.superview?.layer.shadowRadius = 5
              }
    }
    @IBOutlet weak var swiftyB: Switcher! {
        didSet {
            swiftyB.superview?.layer.shadowOffset = .zero
            swiftyB.superview?.layer.shadowOpacity =  0.3
            swiftyB.superview?.layer.shadowRadius = 5
        }
    }
    @IBOutlet weak var swiftyC: JDSwitch! {
        didSet {
            swiftyC.thumbRadiusPadding = 8
        }
    }
    override func viewDidLoad() {
        
       title = "Stretchy Switch"
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
            ( navigationController?.navigationBar as? JDNavigationBar)?.changeColor(#colorLiteral(red: 0.1861540377, green: 0.2199867666, blue: 0.2542595267, alpha: 1))
            ( navigationController?.navigationBar as? JDNavigationBar)?.shape = .wave
    }
   

}
