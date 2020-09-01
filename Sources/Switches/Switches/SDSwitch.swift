//
//  SDSwitch.swift
//  testi
//
//  Created by Jawad Ali on 22/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

//Crdit design by
///Mauricio Bucardo
//https://dribbble.com/shots/9841408-Loading-switch-interaction

 ///Alexis Doreau
//https://dribbble.com/shots/3545882-Switch-with-server-calls

//// George Assan
//https://dribbble.com/shots/5192899-Simple-toggle

import UIKit
enum LoadingResult {
    case success
    case failled
}

public typealias SDSwitchLoadingStarted  = () -> Void

@IBDesignable public class SDSwitch: BaseControl {
    
    open var loadingStarted: SDSwitchLoadingStarted?
    
    //MARK:- Views
    fileprivate lazy var thumbLayer : CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0.75, height: 2)
        layer.contentsGravity = .resizeAspect
        layer.backgroundColor = UIColor.white.cgColor
        return layer
    }()
    
    fileprivate lazy var trackLayer: CALayer = {
        let shape = CALayer()
        shape.borderWidth = borderWidth
        shape.borderColor = UIColor.blue.cgColor
        
        return shape
    }()
    private lazy var thumbLoadingCompleteLayer : CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.lineWidth = thumbRadiusPadding
        shape.strokeColor = loadingColor.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.backgroundColor = UIColor.clear.cgColor
        shape.lineCap = .round
        return shape
    }()
    
    private lazy var loadingLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.lineWidth = thumbRadiusPadding
        shape.strokeColor = loadingColor.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.backgroundColor = UIColor.clear.cgColor
        shape.lineCap = .round
        return shape
    }()
    
    var changeThumbColor: Bool = false {
        didSet {
            
            setThumbColor()
        }
    }
    
    private var isLoadingCompleted = false
    
    private var loadingResult: LoadingResult = .success
    
    fileprivate var isTouchDown: Bool = false {
        didSet {
            layoutSublayers(of: layer)
            changeThumbColor = true
            stateDidChange()
        }
    }
    //MARK:- Public Properties
    
    public var borderColor: UIColor? = nil {
        didSet { setBorderColor() }
    }
    
    public var onBorderColor: UIColor = .white {
        didSet { setBorderColor() }
    }
    public var offBorderColor: UIColor = .white {
        didSet { setBorderColor() }
    }
    
    public  var isLoadingEnabled: Bool = false
    
    public var shape: shapeType = .rounded {
        didSet{
            layoutSublayers(of: layer)
        }
    }
    public var borderWidth: CGFloat = 2 {
        didSet {
            trackLayer.borderWidth = borderWidth
            layoutSublayers(of: layer)
        }
    }
    public var thumbRadiusPadding: CGFloat = 4 {
        didSet {
            layoutSublayers(of: layer)
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
    
    public var onThumbTintColor: UIColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1) {
        didSet { setThumbColor() }
    }
    
    public var offThumbTintColor: UIColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1) {
        didSet { setThumbColor() }
    }
    
    public var loadingColor: UIColor = #colorLiteral(red: 0.2855720818, green: 0.8943144679, blue: 0.6083024144, alpha: 1) {
        didSet { loadingLayer.strokeColor = loadingColor.cgColor }
    }
    public var onTintColor: UIColor =  #colorLiteral(red: 0.2855720818, green: 0.8943144679, blue: 0.6083024144, alpha: 1) {
        didSet {
            trackLayer.backgroundColor = getBackgroundColor()
            
            setNeedsLayout()
        }
    }
    
    public var offTintColor: UIColor = #colorLiteral(red: 0.823615551, green: 0.8911703229, blue: 0.9554550052, alpha: 1) {
        didSet {
            trackLayer.backgroundColor = getBackgroundColor()
            setNeedsLayout()
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
    
    //MARK:- Common Init
    
    fileprivate func controlDidLoad() {
        layer.addSublayer(trackLayer)
        layer.addSublayer(thumbLayer)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity =  0.3
        layer.shadowRadius = 10
        backgroundColor = .clear
        
        trackLayer.backgroundColor = getBackgroundColor()
        setThumbColor()
        layoutSublayers(of: layer)
        addTouchHandlers()
    }
    
    fileprivate func getThumbSize() -> CGSize {
        let height = bounds.height - 2 * (borderWidth + thumbRadiusPadding)
        return CGSize(width: height, height: height)
    }
    
    final func getThumbOrigin(for width: CGFloat) -> CGPoint {
        
        let inset = borderWidth + thumbRadiusPadding
        if isTouchDown {
            
            return CGPoint(x: bounds.midX - width/2, y: inset)
        } else {
            
            
            let x =  (isOn) ? bounds.width - width - inset : inset
            return CGPoint(x: x, y: inset)
        }
    }
    
    fileprivate func getTackSize() -> CGSize {
        isTouchDown ? CGSize(width: bounds.height, height: bounds.height) : bounds.size
    }
    
    final func getTrackOrigin(for width: CGFloat) -> CGPoint {
        
        if isTouchDown {
            
            return CGPoint(x: bounds.midX - width/2, y: 0)
        }
        
        let inset: CGFloat = 0.0
        let x = (!isOn) ? bounds.width - width  : inset
        return CGPoint(x: x, y: inset)
    }
    
    private func stateDidChange() {
        
        trackLayer.backgroundColor = getBackgroundColor()
    }
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        layoutTrackLayer(for: layer.bounds)
        layoutThumbLayer(for: layer.bounds)
        layoutLoadingLayer(for: layer.bounds)
        
        setBorderColor()
    }
    
    
    @objc final public func loadingCompleted(isSuccessFull: Bool) {
        isLoadingCompleted = true
        isSuccessFull ? (loadingResult = .success) : (loadingResult = .failled)
        if !isSuccessFull {
            isOn.toggle()
        }
        
        loadingLayer.removeRotationAnimation()
        loadingLayer.removeFromSuperlayer()
        
        
        thumbLoadingCompleteLayer.path =  (loadingResult == LoadingResult.success )  ? drawOnPath(thumbLayer.bounds) : drawOffPath(thumbLayer.bounds)
        thumbLoadingCompleteLayer.lineWidth = thumbRadiusPadding/3
        thumbLoadingCompleteLayer.strokeColor = (isSuccessFull ? loadingColor : UIColor.red).cgColor
        thumbLoadingCompleteLayer.strokeEnd = 0
        thumbLayer.addSublayer(thumbLoadingCompleteLayer)
        
        
        CATransaction.setCompletionBlock {
            print("completed")
            self.isTouchDown = false
            self.sendActions(for: .valueChanged)
            self.valueChange?(self.isOn)
            self.isUserInteractionEnabled = true
        }
        
        CATransaction.begin()
        thumbLoadingCompleteLayer.strokeAnimation(duration: 1)
        CATransaction.commit()
    }
    
}

//MARK:- layout Layers
private extension SDSwitch {
    
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
    
    func layoutLoadingLayer(for bounds: CGRect) {
        loadingLayer.lineWidth = thumbRadiusPadding
        
        let loadingBounds = bounds.insetBy(dx: 0, dy:  borderWidth  + loadingLayer.lineWidth/2)
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let bezierPath = UIBezierPath(arcCenter: center, radius:bounds.midY , startAngle: -110.degreesToRadians, endAngle: -60.degreesToRadians, clockwise: true)
        loadingLayer.frame = loadingBounds
        loadingLayer.path = bezierPath.cgPath
    }
    
}
// MARK: - Touches
private extension SDSwitch {
    
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
        isLoadingCompleted = false
        if thumbLayer.sublayers?.contains(thumbLoadingCompleteLayer) ?? false {
            thumbLoadingCompleteLayer.removeFromSuperlayer()
        }

        isTouchDown = true
        
    }
    
    @objc
    func touchUp() {
        isOn.toggle()
        touchEnded()
    }
    
    @objc
    func touchEnded() {
        if self.isLoadingEnabled && isOn {
            performLoading()
            
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isTouchDown = false
                self.valueChange?(self.isOn)
            }
        }
        
    }
    
}

//MARK:- color setting
private extension SDSwitch {
    func setThumbColor(){
        if let thumbColor = thumbTintColor {
            thumbLayer.backgroundColor = thumbColor.cgColor
        } else {
            thumbLayer.backgroundColor = (isOn ? onThumbTintColor : offThumbTintColor).cgColor
        }
    }
    func getBackgroundColor() -> CGColor {
        return ((isOn && !isTouchDown) ? onTintColor : offTintColor).cgColor
    }
    func setBorderColor(){
        if let borderClor = borderColor {
            trackLayer.borderColor = borderClor.cgColor
        } else {
            trackLayer.borderColor = (isOn ? onBorderColor : offBorderColor).cgColor
        }
    }
    
}

//MARK:- Loading Animation
private extension SDSwitch {
    func performLoading() {
        loadingStarted?()
        layer.addSublayer(loadingLayer)
        isUserInteractionEnabled = false
        loadingLayer.rotateAnimation(angal: 360.degreesToRadians, duration: 1, repeatAnimation: true)
    }
}

private extension SDSwitch {
    func drawOnPath(_ group:CGRect) -> CGPath {
        
        let bezierPath = UIBezierPath()
        
        let radius = group.maxX/5
        let center = CGPoint(x:group.midX,y:group.midY )
        
        let  x1 = center.x  + (radius ) *  cos(-45.degreesToRadians)
        let  y1 = center.y  + (radius  ) *  sin(-45.degreesToRadians)
        
        let  x2 = center.x  + (radius ) * cos(135.degreesToRadians)
        let  y2 = center.y  + (radius ) * sin(135.degreesToRadians)
        
        let  x3 = center.x  + (radius + radius * 0.5 ) *  cos(-175.degreesToRadians)
        let  y3 = center.y  + (radius  + radius * 0.5  ) *  sin(-175.degreesToRadians)
        
        bezierPath.move(to: CGPoint(x: x3, y: y3))
        bezierPath.addLine(to: CGPoint(x: x2, y: y2 ))

        bezierPath.addLine(to: CGPoint(x: x1, y: y1))

        return bezierPath.cgPath
        
    }
    private func drawOffPath(_ group:CGRect) -> CGPath {
        
        let bezierPath = UIBezierPath()
        
        let radius = group.maxX/5
        let center = CGPoint(x:group.midX,y:group.midY )
        
        let  x1 = center.x  + (radius ) *  cos(-45.degreesToRadians)
        let  y1 = center.y  + (radius  ) *  sin(-45.degreesToRadians)
        
        
        let  x2 = center.x  + (radius ) * cos(135.degreesToRadians)
        let  y2 = center.y  + (radius ) * sin(135.degreesToRadians)
        
        
        let  x3 = center.x  + (radius ) * cos(-135.degreesToRadians)
        let  y3 = center.y  + (radius ) * sin(-135.degreesToRadians)
        
        let  x4 = center.x  + (radius ) * cos(45.degreesToRadians)
        let  y4 = center.y  + (radius ) * sin(45.degreesToRadians)
        
        bezierPath.move(to: CGPoint(x: x3, y: y3))
        bezierPath.addLine(to: CGPoint(x: x4, y: y4))
        
        bezierPath.move(to: CGPoint(x: x1, y: y1))
        bezierPath.addLine(to: CGPoint(x: x2, y: y2))
        
        return bezierPath.cgPath
        
    }
}

////`Crdit` :-Morph Switch
// https://dribbble.com/shots/2330566-Morph-Switch
@IBDesignable public class YapFullTextSwitch : SDSwitch {
    
    private lazy var contentsLayer: CATextLayer = CATextLayer()
    
    public var onText: String? {
        didSet {
            layoutTextLayerIfNeeded()
        }
    }
    
    public var offText: String? {
        didSet {
            layoutTextLayerIfNeeded()
        }
    }
    public var onTextColor: UIColor = .white
    
    
    public var offTextColor: UIColor = .white
    
    override func controlDidLoad() {
        super.controlDidLoad()
        
        thumbLayer.addSublayer(contentsLayer)
        thumbRadiusPadding = 0
    }
    
    override func getThumbSize() -> CGSize {
        let height = bounds.height - 2 * (borderWidth )
        let width = (isTouchDown) ? bounds.width - 2 * (borderWidth ) : height
        return CGSize(width: width, height: height)
    }
    
    override func getTackSize() -> CGSize {
        bounds.size
    }
    
    override func touchEnded() {
        if isOn {
            contentsLayer.string = onText
            contentsLayer.foregroundColor = onTextColor.cgColor
            
        } else {
            contentsLayer.string = offText
            contentsLayer.foregroundColor = offTextColor.cgColor
        }
        
        setBorderColor()
        trackLayer.backgroundColor = getBackgroundColor()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.contentsLayer.string = nil
            self.isTouchDown = false
            self.valueChange?(self.isOn)
        }
    }
    
  public  override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        layoutContentLayer(for: bounds)
    }
    
    
    private func layoutContentLayer(for bounds: CGRect) {
        let inset = 2 * (borderWidth )
        let y = bounds.maxY - inset
        let leading = (borderWidth )/2
        let x = bounds.maxX - inset
        let origin = CGPoint(x: leading, y: leading + bounds.midY/4)
        
        contentsLayer.frame = CGRect(origin: origin, size: CGSize(width: x, height: y))
        contentsLayer.contentsGravity = .center
        contentsLayer.fontSize = bounds.height * 0.4
        
    }
    
    // MARK: - Content Layers
    private func layoutTextLayerIfNeeded() {
        contentsLayer.alignmentMode = .center
        contentsLayer.fontSize = bounds.height * 0.4
        contentsLayer.font =  UIFont.systemFont(ofSize: 10, weight: .bold)
        contentsLayer.contentsScale = UIScreen.main.scale
    }
    
}

