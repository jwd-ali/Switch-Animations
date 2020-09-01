//
//  YapBaseSwitch.swift
//  testi
//
//  Created by Jawad Ali on 13/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

//// `Design by`: Oleg Frolov
// https://dribbble.com/shots/2028065-Switcher-lll

import UIKit

@IBDesignable
open class YapBaseSwitch: BaseControl {

    // MARK: - Property
   
    @IBInspectable open var animateDuration: Double = 0.4
  

    internal var on: Bool = false
    internal var sizeScale: CGFloat {
        return min(self.bounds.width, self.bounds.height)/100.0
    }

    open override var frame: CGRect {
        didSet {
            guard frame.size != oldValue.size else { return }
            resetView()
        }
    }

    open override var bounds: CGRect {
        didSet {
            guard frame.size != oldValue.size else { return }
            resetView()
        }
    }

    // MARK: - Getter

    final public func setOn(_ on: Bool, animate: Bool = true) {
        guard on != isOn else { return }
        toggleValue()
    }

    // MARK: - Init
    convenience public init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    // MARK: - Internal

    internal func resetView() {
        gestureRecognizers?.forEach(self.removeGestureRecognizer)
        layer.sublayers?.forEach({ $0.removeFromSuperlayer()})
        setUpView()
    }

    internal func setUpView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(YapBaseSwitch.toggleValue))
        self.addGestureRecognizer(tap)

        for view in self.subviews {
            view.removeFromSuperview()
        }
    }

    @objc internal func toggleValue() {
         
        self.on.toggle()
        self.isOn.toggle()
       valueChange?(isOn)
        sendActions(for: .valueChanged)
        changeValueAnimate(isOn, duration: animateDuration)
    }
    
    internal func changeValueAnimate(_ value: Bool, duration: Double) {
    }

}
