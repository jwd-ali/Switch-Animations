//
//  SmileyViewController.swift
//  testi
//
//  Created by Jawad Ali on 25/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import Switches
class SmileyViewController: UIViewController {

    @IBOutlet weak var randomA: YapSwitch! {
        didSet {
            randomA.thumbImage = UIImage(named: "thumb12")
                   randomA.onTintColor = #colorLiteral(red: 0.8426451087, green: 0.3289524913, blue: 0.2659203112, alpha: 1)
                   randomA.offTintColor = #colorLiteral(red: 0.7276904583, green: 0.7375378013, blue: 0.7416281104, alpha: 1)
                   randomA.thumbTintColor = .clear
                   randomA.onImage = #imageLiteral(resourceName: "check").maskWithColor(color: .white)
                   randomA.offImage = UIImage(named: "cross7")
                   randomA.shape = .square
                   randomA.frame = CGRect(x: 200, y: 650, width: 65, height: 36)
                   randomA.borderWidth = 2
        }
    }
    @IBOutlet weak var randomB: YapSwitch! {
        didSet {
            randomB.thumbImage = UIImage(named: "thumb1")
                   randomB.onTintColor = #colorLiteral(red: 0.5955576897, green: 0.7103857398, blue: 0.2235306501, alpha: 1)
                   randomB.layer.shadowOpacity = 0.6
                   randomB.layer.shadowOffset = .zero
                   randomB.layer.shadowRadius = 5
                   randomB.layer.shadowColor = UIColor.black.cgColor
            randomB.onImage =  #imageLiteral(resourceName: "check").maskWithColor(color: .white)
                   randomB.offImage = UIImage(named: "off2")
                   randomB.offTintColor = #colorLiteral(red: 0.7764018178, green: 0.7765145898, blue: 0.7763771415, alpha: 1)
                   randomB.borderWidth = 1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Smiley Switch"
        // Do any additional setup after loading the view.
    }
    



}
