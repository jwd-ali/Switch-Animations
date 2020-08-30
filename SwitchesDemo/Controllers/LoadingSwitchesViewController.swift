//
//  LoadingSwitchesViewController.swift
//  testi
//
//  Created by Jawad Ali on 23/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import Switches
class LoadingSwitchesViewController: UIViewController {
    @IBOutlet weak var loadingSwitch: SDSwitch! {
        didSet{
            loadingSwitch.isLoadingEnabled = true
            loadingSwitch.thumbRadiusPadding = 10
        }
    }
    var count = 0
    @IBOutlet weak var followedMiddleSwitch: SDSwitch! {
        didSet {
            followedMiddleSwitch.offBorderColor = #colorLiteral(red: 0.3974077106, green: 0.6517546177, blue: 0.9074617624, alpha: 1)
            followedMiddleSwitch.offThumbTintColor = #colorLiteral(red: 0.3974077106, green: 0.6517546177, blue: 0.9074617624, alpha: 1)
            followedMiddleSwitch.borderWidth = 4
            followedMiddleSwitch.thumbRadiusPadding = 8
            followedMiddleSwitch.onThumbTintColor = #colorLiteral(red: 0.6347479224, green: 0.50891155, blue: 0.9531157613, alpha: 1)
             followedMiddleSwitch.onBorderColor = #colorLiteral(red: 0.6347479224, green: 0.50891155, blue: 0.9531157613, alpha: 1)
            followedMiddleSwitch.onTintColor = .white
             followedMiddleSwitch.offTintColor = .white
        }
    }
    @IBOutlet weak var followedLastSwitch: YapFullTextSwitch! {
        didSet{
            followedLastSwitch.onTextColor = #colorLiteral(red: 0.2766842842, green: 0.8682026267, blue: 0.9832950234, alpha: 1)
            followedLastSwitch.offTextColor = #colorLiteral(red: 0.7480503321, green: 0.7532240748, blue: 0.7486134171, alpha: 1)
             followedLastSwitch.onText = "ON"
             followedLastSwitch.offText = "OFF"
             followedLastSwitch.onBorderColor = #colorLiteral(red: 0.2766842842, green: 0.8682026267, blue: 0.9832950234, alpha: 1)
             followedLastSwitch.offBorderColor = #colorLiteral(red: 0.9433093667, green: 0.9533157945, blue: 0.9529805779, alpha: 1)
            followedLastSwitch.onTintColor = #colorLiteral(red: 0.3614792228, green: 0.9322348237, blue: 0.9953452945, alpha: 1)
            followedLastSwitch.offTintColor = #colorLiteral(red: 0.948936522, green: 0.9490728974, blue: 0.9489069581, alpha: 1)
            followedLastSwitch.borderWidth = 5
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Loading Switches"
        
        loadingSwitch.loadingStarted = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                (self.count % 2 == 0) ? self.loadingSwitch.loadingCompleted(isSuccessFull: true) : self.loadingSwitch.loadingCompleted(isSuccessFull: false)
                self.count += 1
            }
        }
        
        
     
            
             ( navigationController?.navigationBar as? JDNavigationBar)?.cycles = 7
    }
    


}
