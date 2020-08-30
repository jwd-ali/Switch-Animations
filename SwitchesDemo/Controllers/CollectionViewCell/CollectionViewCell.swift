//
//  CollectionViewCell.swift
//  testi
//
//  Created by Jawad Ali on 27/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import Switches
class CollectionViewCell: UICollectionViewCell {
    
    private var switchv : BaseControl! {
        didSet{
            switchv.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    //MARK: binding with controller to perform segue
    
    var performSgue : ((_ segue:String)-> Void)?
    
    @IBOutlet weak var displaySwitch: UIView! {
        didSet {
            displaySwitch.layer.shadowOffset = .zero
            displaySwitch.layer.shadowOpacity = 0.15
            displaySwitch.layer.shadowRadius = 7
            displaySwitch.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var holdingView: UIView! {
        didSet {
            holdingView.layer.shadowOffset = .zero
            holdingView.layer.shadowOpacity = 0.15
            holdingView.layer.shadowRadius = 7
            holdingView.layer.cornerRadius = 10
        }
    }
    
    private var type : SwitchType!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewAllButton.layer.cornerRadius = viewAllButton.bounds.midY
    }
    
    @IBAction func viewAllTapped(_ sender: UIButton) {
        
        performSgue?(type.rawValue)
        
    }
    
    
    func config(type: SwitchType) {
        self.type = type
        collectionName.text = type.rawValue
        
        switchv = type.coverSwitch
        displaySwitch.addSubview(switchv)
        
        if type == SwitchType.loading {
            (self.switchv as? SDSwitch)?.loadingStarted = {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    
                    (self.switchv as? SDSwitch)?.loadingCompleted(isSuccessFull: true)
                }
            }
            
        }
        
        switchv.topAnchor.constraint(equalTo: displaySwitch.topAnchor).isActive = true
        switchv.bottomAnchor.constraint(equalTo: displaySwitch.bottomAnchor).isActive = true
        switchv.leadingAnchor.constraint(equalTo: displaySwitch.leadingAnchor).isActive = true
        switchv.trailingAnchor.constraint(equalTo: displaySwitch.trailingAnchor).isActive = true
        
        switchv.addTarget(self, action: #selector(changedSwitchVal), for: .valueChanged)
        
    }
    
    @objc func changedSwitchVal(_ sender: BaseControl) {
        print(sender.isOn)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        switchv.removeFromSuperview()
    }
}
