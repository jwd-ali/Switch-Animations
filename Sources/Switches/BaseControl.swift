//
//  BaseControl.swift
//  testi
//
//  Created by Jawad Ali on 28/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

public typealias SDSwitchValueChange  = (_ value: Bool) -> Void
open  class BaseControl: UIControl {

    // MARK: - Property
     open var valueChange: SDSwitchValueChange?
   
     open var isOn: Bool = false
}
