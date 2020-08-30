//
//  Switcher.swift
//  testi
//
//  Created by Jawad Ali on 24/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
/// `Design by` : Oleg Frolov
// https://dribbble.com/shots/3844909-On-Off
//https://dribbble.com/shots/4148855-Switcher-XXXIII


@IBDesignable public  class Switcher: BaseControl {
    
    //MARK:- Properties
    @IBInspectable  public var onTintColor: UIColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet {
            onThumbLayerColorChange()
        }
    }
    
    @IBInspectable public var offTintColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)  {
        didSet {
            offThumbLayerColorChange()
        }
    }
    
    //MARK:- Views
    fileprivate lazy var thumbOnLayer : CALayer = {
        let layer = CALayer()
        layer.contentsGravity = .resizeAspect
        layer.backgroundColor = onTintColor.cgColor
        return layer
    }()
    
    fileprivate lazy var thumbOffLayer : CALayer = {
        let layer = CALayer()
        
        layer.contentsGravity = .resizeAspect
        layer.backgroundColor = offTintColor.cgColor
        return layer
    }()
    
    private lazy var trackLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.backgroundColor = UIColor.white.cgColor
        return shape
    }()
    
    fileprivate var thumbRadiusPadding: CGFloat = 10
    fileprivate var duration: Double = 1
    fileprivate var isTouchDown: Bool = false {
        didSet {
            layoutSublayers(of: layer)
        }
    }
    
    //MARK:- initializers
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        controlDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        controlDidLoad()
    }
    
    fileprivate func controlDidLoad() {
        layer.addSublayer(trackLayer)
        layer.addSublayer(thumbOffLayer)
        layer.addSublayer(thumbOnLayer)
        
        layer.shadowOffset = .zero
        layer.shadowOpacity =  0.3
        layer.shadowRadius = 5
        layer.masksToBounds = true
        
        self.isOn ? (self.trackLayer.backgroundColor = self.offTintColor.cgColor) : (self.trackLayer.backgroundColor = self.onTintColor.cgColor)
        addTouchHandlers()
        backgroundColor = .clear
    }
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        layer.cornerRadius = bounds.midY
        CATransaction.setAnimationDuration(duration)
        CATransaction.begin()
        
        layoutLayers()
        
        CATransaction.commit()
    }
    
    fileprivate func layoutLayers() {
        layoutTrackLayer(for: layer.bounds)
        layoutOnThumbLayer(for: layer.bounds)
        layoutOffThumbLayer(for: layer.bounds)
    }
    
    fileprivate func onThumbLayerColorChange() {
        thumbOnLayer.backgroundColor = onTintColor.cgColor
        self.isOn ? (self.trackLayer.backgroundColor = self.offTintColor.cgColor) : (self.trackLayer.backgroundColor = self.onTintColor.cgColor)
    }
    fileprivate func offThumbLayerColorChange(){
        thumbOffLayer.backgroundColor = offTintColor.cgColor
        self.isOn ? (self.trackLayer.backgroundColor = self.offTintColor.cgColor) : (self.trackLayer.backgroundColor = self.onTintColor.cgColor)
    }
}
//MARK:- layout Layers
fileprivate extension Switcher {
    
    func layoutTrackLayer(for bounds: CGRect) {
        
        trackLayer.frame = bounds
        trackLayer.cornerRadius = trackLayer.bounds.midY
    }
    
   @objc func layoutOnThumbLayer(for bounds: CGRect) {
        let size = getOnThumbSize()
        let origin = getOnThumbOrigin(for: size.width)
        thumbOnLayer.frame = CGRect(origin: origin, size: size)
        thumbOnLayer.cornerRadius = size.height/2
    }
   @objc func layoutOffThumbLayer(for bounds: CGRect) {
        let size = getOffThumbSize()
        let origin = getOffThumbOrigin(for: size.width)
        thumbOffLayer.frame = CGRect(origin: origin, size: size)
        thumbOffLayer.cornerRadius = size.height/2
    }
    
    final func getOnThumbSize() -> CGSize {
        let height = bounds.height - 2 * ( thumbRadiusPadding)
        return  ( isTouchDown && !isOn ) ? CGSize(width: bounds.maxX * 1.5, height: bounds.maxY * 2) : CGSize(width: height, height: height)
        
    }
    final func getOffThumbSize() -> CGSize {
        let height = bounds.height - 2 * ( thumbRadiusPadding)
        return  ( isTouchDown && isOn ) ?  CGSize(width: bounds.maxX * 1.5, height: bounds.maxY * 2) : CGSize(width: height, height: height)
        
    }
    
    final func getOnThumbOrigin(for width: CGFloat) -> CGPoint {
        
        let inset =  thumbRadiusPadding
        return  (isTouchDown && !isOn) ? CGPoint(x: -bounds.maxX/3, y: -bounds.midY * 0.8) : CGPoint( x: (bounds.width - width - inset),y: inset)
        
    }
    final func getOffThumbOrigin(for width: CGFloat) -> CGPoint {
        
        let inset =  thumbRadiusPadding
        return  (isTouchDown && isOn) ? CGPoint(x: -bounds.maxX/3, y: -bounds.midY * 0.8)  : CGPoint( x: inset,y: inset)
        
    }
}
fileprivate extension Switcher {
    
    private func addTouchHandlers() {
        addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside])
        addTarget(self, action: #selector(touchEnded), for: [.touchDragExit, .touchCancel])
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftRight(_:)))
        leftSwipeGesture.direction = [.left]
        addGestureRecognizer(leftSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftRight(_:)))
        rightSwipeGesture.direction = [.right]
        addGestureRecognizer(rightSwipeGesture)
    }
    
    @objc
    func swipeLeftRight(_ gesture: UISwipeGestureRecognizer) {
        let canLeftSwipe = isOn && gesture.direction == .left
        let canRightSwipe = !isOn && gesture.direction == .right
        guard canLeftSwipe || canRightSwipe else { return }
        touchUp()
    }
    
    @objc
    func touchDown() {
        
        isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.2,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
    
    @objc
    func touchUp() {
        isOn.toggle()
        touchEnded()
    }
    
    @objc
    func touchEnded() {
        isTouchDown = true
        
        UIView.animate(withDuration: duration/3,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        },
                       completion: { _ in
                        UIView.animate(withDuration: self.duration/3) {
                            self.transform = CGAffineTransform.identity
                        }
        })
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (duration)) {
            self.isOn ? (self.trackLayer.backgroundColor = self.offTintColor.cgColor) : (self.trackLayer.backgroundColor = self.onTintColor.cgColor)
            
            self.isOn ? (self.thumbOffLayer.areAnimationsEnabled = false) : (self.thumbOnLayer.areAnimationsEnabled = false)
            self.sendActions(for: .valueChanged)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                
                self.isUserInteractionEnabled = true
                
                self.isTouchDown = false
                self.isOn ? self.thumbOffLayer.bringToFront() : self.thumbOnLayer.bringToFront()
                self.isOn ? (self.thumbOffLayer.areAnimationsEnabled = true) : (self.thumbOnLayer.areAnimationsEnabled = true)
                
            }
        }
    }
    
}
@IBDesignable public class SwitcherFullStrtech : Switcher {
    
  @IBInspectable public var thumbTintColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)  {
         didSet {
             ThumbLayerColorChange()
         }
     }
    
    private lazy var interactionLayer : CALayer = {
         let shape = CALayer()
        shape.backgroundColor = thumbTintColor.cgColor
        return shape
        
    }()
    
    override func controlDidLoad() {
        super.controlDidLoad()
        layer.addSublayer(interactionLayer)
        
        thumbOnLayer.bringToFront()
        thumbOffLayer.bringToFront()
        duration = 0.5
        thumbRadiusPadding = 0

        layer.masksToBounds = false
    }
    
    override func layoutLayers() {
      super.layoutLayers()
        layoutInteractionLayerLayer(for: bounds)
      }
    
     override func layoutOnThumbLayer(for bounds: CGRect) {
        
        let percent: CGFloat = bounds.maxY * 0.2
        
        thumbOnLayer.frame = CGRect(x: bounds.midY - percent/2, y: bounds.midY - percent/2, width: percent, height: percent)
        thumbOnLayer.cornerRadius = thumbOnLayer.bounds.midY
    }
   override func layoutOffThumbLayer(for bounds: CGRect) {
    
         let heightPercent: CGFloat = bounds.maxY * 0.4
          let widthPercent: CGFloat = bounds.maxY * 0.12
        
        thumbOffLayer.frame = CGRect(x: bounds.maxX - bounds.midY - widthPercent/2 , y: bounds.midY - heightPercent/2, width: widthPercent, height: heightPercent)
        thumbOffLayer.cornerRadius = thumbOffLayer.bounds.midX
    }
    
    fileprivate override func onThumbLayerColorChange() {
           thumbOnLayer.backgroundColor = onTintColor.cgColor
           
       }
    
    fileprivate override func offThumbLayerColorChange(){
           thumbOffLayer.backgroundColor = offTintColor.cgColor
           
       }
    
    override func touchEnded() {
          isTouchDown = true
         DispatchQueue.main.asyncAfter(deadline: .now() + (duration)) {
            self.isTouchDown = false
            self.isUserInteractionEnabled = true
            
            let onTint = self.onTintColor
            self.onTintColor = self.offTintColor
            self.offTintColor = onTint
            
        }
    }
    
    func ThumbLayerColorChange(){
        interactionLayer.backgroundColor = thumbTintColor.cgColor
    }
}

extension SwitcherFullStrtech {
    func layoutInteractionLayerLayer(for bounds: CGRect) {
        interactionLayer.cornerRadius = bounds.midY
    
        isTouchDown ? ( interactionLayer.frame = bounds ) : (isOn ? (interactionLayer.frame = CGRect(x: bounds.maxX - bounds.maxY, y: 0, width: bounds.maxY, height: bounds.maxY)) : (interactionLayer.frame = CGRect(x: 0, y: 0, width: bounds.maxY, height: bounds.maxY)))
        
    }
    
    
   
}

