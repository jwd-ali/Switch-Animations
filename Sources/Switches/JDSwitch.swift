//
//  JDSwitch.swift
//  testi
//
//  Created by Jawad Ali on 22/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

/// `Design by` : Oleg Frolov
// https://dribbble.com/shots/2346044-Switch-on-off


import UIKit
@IBDesignable public class JDSwitch: BaseControl {
    
    //MARK:- Views
   private lazy var thumbLayer : CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0.75, height: 2)
        layer.contentsGravity = .resizeAspect
        layer.backgroundColor = UIColor.white.cgColor
        return layer
    }()
   
    private lazy var trackLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
       
        shape.borderWidth = borderWidth
        shape.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return shape
    }()
    
    var changeThumbColor: Bool = false {
        didSet {
            setThumbColor()
        }
    }
    
   private var isTouchDown: Bool = false {
        didSet {
             layoutSublayers(of: layer)
             changeThumbColor = true
        }
    }
    //MARK:- Public Properties

    public var shape: shapeType = .rounded {
          didSet{
              layoutSublayers(of: layer)
          }
      }
    public var borderWidth: CGFloat = 0 {
          didSet {
              layoutSublayers(of: layer)
          }
      }
    public var thumbRadiusPadding: CGFloat = 0 {
        didSet {
            layoutThumbLayer(for: layer.bounds)
        }
    }
    public var thumbCornerRadius: CGFloat = 0 {
           didSet {
               layoutThumbLayer(for: layer.bounds)
           }
       }
    public var thumbTintColor: UIColor? = nil {
         didSet { setThumbColor() }
    }
    
    public var onThumbTintColor: UIColor = #colorLiteral(red: 0.5438016653, green: 0.7640405893, blue: 0.291983664, alpha: 1) {
               didSet { setThumbColor() }
       }
    
    public var offThumbTintColor: UIColor = #colorLiteral(red: 0.864574194, green: 0.8753482103, blue: 0.848641932, alpha: 1) {
           didSet { setThumbColor() }
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
    
    //MARK:- Common Init
    
    private func controlDidLoad() {
        layer.addSublayer(trackLayer)
        layer.addSublayer(thumbLayer)
        
        layer.shadowOffset = .zero
               layer.shadowOpacity =  0.3
               layer.shadowRadius = 5
        backgroundColor = .clear
        
         setThumbColor()
         layoutSublayers(of: layer)
        addTouchHandlers()
    }

    final func getThumbSize() -> CGSize {
        let height = bounds.height - 2 * (borderWidth + thumbRadiusPadding)
        return CGSize(width: height, height: height)
    }
    
    final func getThumbOrigin(for width: CGFloat) -> CGPoint {
        
        let inset = borderWidth + thumbRadiusPadding
        if isTouchDown {
            let x =  (!isOn) ? bounds.width - width - inset : inset
            return CGPoint(x: x, y: inset)
        } else {
            
            let x =  (isOn) ? bounds.width - width - inset : inset
            return CGPoint(x: x, y: inset)
        }
    }
    
    private func getTackSize() -> CGSize {
        isTouchDown ? CGSize(width: bounds.height, height: bounds.height) : bounds.size
    }
    
    final func getTrackOrigin(for width: CGFloat) -> CGPoint {
        let inset: CGFloat = 0.0
        let x = (!isOn) ? bounds.width - width  : inset
        return CGPoint(x: x, y: inset)
    }
    
    public override func layoutSublayers(of layer: CALayer) {
           super.layoutSublayers(of: layer)
         
           layoutTrackLayer(for: layer.bounds)
           layoutThumbLayer(for: layer.bounds)
       }
}

//MARK:- layout Layers
private extension JDSwitch {
   
    
    func layoutTrackLayer(for bounds: CGRect) {
        
        let size = getTackSize()
        let origin = getTrackOrigin(for: size.width)
        trackLayer.frame = CGRect(origin: origin, size: size)
        
        shape == .rounded ? (trackLayer.cornerRadius = trackLayer.bounds.height / 2) : (trackLayer.cornerRadius = 5)
    }
    
     func layoutThumbLayer(for bounds: CGRect) {
        let size = getThumbSize()
        let origin = getThumbOrigin(for: size.width)
        thumbLayer.frame = CGRect(origin: origin, size: size)
        
        shape == .rounded ? (thumbLayer.cornerRadius = size.height / 2) : (thumbLayer.cornerRadius = thumbCornerRadius)
    }
}
  // MARK: - Touches
private extension JDSwitch {
    
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
        isTouchDown = true
    }
    
    @objc
    func touchUp() {
        isOn.toggle()
        touchEnded()
    }
    
    @objc
    func touchEnded() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.isTouchDown = false
        }
        
    }
}

//MARK:- color setting
extension JDSwitch {
    private func setThumbColor(){
        if let thumbColor = thumbTintColor {
            thumbLayer.backgroundColor = thumbColor.cgColor
        } else {
            thumbLayer.backgroundColor = (isOn ? onThumbTintColor : offThumbTintColor).cgColor
        }
    }
    
}
