//
//  TKLiquidSwitch.swift
//  testi
//
//  Created by Jawad Ali on 13/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

// Dedign by Oleg Frolov
// https://dribbble.com/shots/2028065-Switcher-lll

@IBDesignable
open class YapLiquidSwitch: YapBaseSwitch {
  private var bubbleLayer = CAShapeLayer()
  private var lineLayer = CAShapeLayer()
  @IBInspectable open var onColor = UIColor(red: 0.373, green: 0.843, blue: 0.596, alpha: 1) {
    didSet {
      resetView()
    }
  }

  @IBInspectable open var offColor = UIColor(red: 0.871, green: 0.871, blue: 0.871, alpha: 1) {
    didSet {
      resetView()
    }
  }

  override internal func setUpView() {
    super.setUpView()

    clipsToBounds = true

    lineLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: (bounds.height - 20 * sizeScale)/2, width: bounds.width, height: 20 * sizeScale), cornerRadius: 10 * sizeScale).cgPath
    lineLayer.fillColor = switchColor(isOn).cgColor
    layer.addSublayer(lineLayer)

    bubbleLayer.frame = bounds
    bubbleLayer.position = bubblePosition(isOn)
    bubbleLayer.path = CGRect(origin: .zero, size: bubbleSize).bubbleShapePath
    bubbleLayer.fillColor = switchColor(isOn).cgColor
    layer.addSublayer(bubbleLayer)
  }

  override func changeValueAnimate(_ value: Bool, duration: Double) {
    let bubbleTransformAnim = CAKeyframeAnimation(keyPath: "transform")
    bubbleTransformAnim.values = [NSValue(caTransform3D: CATransform3DIdentity),
                                  NSValue(caTransform3D: CATransform3DMakeScale(1, 0.8, 1)),
                                  NSValue(caTransform3D: CATransform3DMakeScale(0.8, 1, 1)),
                                  NSValue(caTransform3D: CATransform3DIdentity)]
    bubbleTransformAnim.keyTimes = [NSNumber(value: 0), NSNumber(value: 1.0/3.0), NSNumber(value: 2.0/3.0), NSNumber(value: 1)]
    bubbleTransformAnim.duration = duration

    let bubblePositionAnim = CABasicAnimation(keyPath: "position")
    bubblePositionAnim.fromValue = NSValue(cgPoint: bubblePosition(!isOn))
    bubblePositionAnim.toValue = NSValue(cgPoint: bubblePosition(isOn))
    bubblePositionAnim.duration = duration

    let bubbleGroupAnim = CAAnimationGroup()
    bubbleGroupAnim.animations = [bubbleTransformAnim, bubblePositionAnim]
    bubbleGroupAnim.isRemovedOnCompletion = false
    bubbleGroupAnim.fillMode = CAMediaTimingFillMode.forwards
    bubbleGroupAnim.duration = duration

    bubbleLayer.add(bubbleGroupAnim, forKey: "Bubble")

    let color = switchColor(value).cgColor
    UIView.animate(withDuration: duration, animations: { () -> Void in
      self.lineLayer.fillColor = color
      self.bubbleLayer.fillColor = color
    })
  }
}

// Getter
extension YapLiquidSwitch {
  var bubbleSize: CGSize {
    let lineH = 20 * sizeScale
    let w = lineH * 2 + bounds.height
    let h = bounds.height
    return CGSize(width: w, height: h)
  }

  func switchColor(_ isOn: Bool) -> UIColor {
    if isOn {
      return onColor
    } else {
      return offColor
    }
  }

  func bubblePosition(_ isOn: Bool) -> CGPoint {
    let h = bounds.height
    let w = bounds.width
    let bW = bubbleSize.width

    if isOn {
      return CGPoint(x: bW * 0.8, y: h/2)
    } else {
      return CGPoint(x: w - bW * 0.2, y: h/2)
    }
  }
}
