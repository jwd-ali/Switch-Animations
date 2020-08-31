//
//  Switch.swift
//  testi
//
//  Created by Jawad Ali on 13/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

//// `Design by`: Anupam
//https://dribbble.com/shots/4908263-Switch-UI

//// `Design by` : Maria Kovalevich
//https://dribbble.com/shots/4685786-Daily-UI-015-On-Off-Switch-clickable-prototype
import Foundation
import UIKit
public enum shapeType {
    case square
    case rounded
}

@IBDesignable public class YapSwitch: BaseControl {
    
    //MARK:- Properties
    
    //// corner radius of thumbnail in case of square
    //// It has no effect if shape is rounded
    
    public var thumbCornerRadius: CGFloat = 0 {
        didSet {
            layoutThumbLayer(for: layer.bounds)
        }
    }
    
    //// if stretch is enable .. on touch down thumbnail increase its width....
    public var isStretchEnable: Bool = true
    
    /// `shape` of your switch ... it can either be rounded or square .. you can set it accordingly
    
    public var shape: shapeType = .rounded {
        didSet{
            layoutSublayers(of: layer)
        }
    }
    
    /// Width of the border... it can have any `float` value
    public var borderWidth: CGFloat = 0 {
        didSet {
            trackLayer.borderWidth = borderWidth
            layoutSublayers(of: layer)
        }
    }
    
    
    public var borderColor: UIColor? = nil {
        didSet { setBorderColor() }
    }
    
    public var onBorderColor: UIColor = .white {
        didSet { setBorderColor() }
    }
    public var offBorderColor: UIColor = .white {
        didSet { setBorderColor() }
    }
    
    public var textColor: UIColor? = nil {
        didSet {
            (offContentLayer as? CATextLayer)?.foregroundColor = textColor?.cgColor
            (onContentLayer as? CATextLayer)?.foregroundColor = textColor?.cgColor
        }
    }
    
    public var onTextColor: UIColor = .white {
        didSet {
            
            (onContentLayer as? CATextLayer)?.foregroundColor = onTextColor.cgColor
        }
    }
    
    public var offTextColor: UIColor = .white {
        didSet {
            (offContentLayer as? CATextLayer)?.foregroundColor = offTextColor.cgColor
            
        }
    }
    
    public var trackTopBottomPadding: CGFloat = 0 {
        didSet {
            layoutSublayers(of: layer)
        }
    }
    
    public var contentLeadingTrailingPadding: CGFloat = 0 {
        didSet {
            layoutSublayers(of: layer)
        }
    }
    
    //// Distance of `thumb` from track layer
    public var thumbRadiusPadding: CGFloat = 3.5 {
        didSet {
            layoutThumbLayer(for: layer.bounds)
        }
    }
    
    public var onTintColor: UIColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1) {
        didSet {
            trackLayer.backgroundColor = getBackgroundColor()
            
            setNeedsLayout()
        }
    }
    
    public var offTintColor: UIColor = .white {
        didSet {
            trackLayer.backgroundColor = getBackgroundColor()
            setNeedsLayout()
        }
    }
    
    public var thumbTintColor: UIColor? = nil {
        didSet { setThumbColor() }
    }
    
    public var onThumbTintColor: UIColor = .white {
        didSet { setThumbColor() }
    }
    
    public var offThumbTintColor: UIColor = .white {
        didSet { setThumbColor() }
    }
    
    public var onText: String? {
        didSet {
            addOnTextLayerIfNeeded()
            (onContentLayer as? CATextLayer)?.string = onText
        }
    }
    
    public var offText: String? {
        didSet {
            addOffTextLayerIfNeeded()
            (offContentLayer as? CATextLayer)?.string = offText
            
        }
    }
    
    public var onThumbImage: UIImage? {
        didSet {
            thumbLayer.contents = onThumbImage?.cgImage
        }
    }
    
    public var offThumbImage: UIImage? {
        didSet {
            thumbLayer.contents = offThumbImage?.cgImage
        }
    }
    
    public var thumbImage: UIImage? {
        didSet {
            thumbLayer.contents = thumbImage?.cgImage
        }
    }
    
    
    public var onImage: UIImage? {
        didSet {
            addOnImageLayerIfNeeded()
            onContentLayer?.contents = onImage?.cgImage
            
        }
    }
    
    public var offImage: UIImage? {
        didSet {
            addOffImageLayerIfNeeded()
            offContentLayer?.contents = offImage?.cgImage
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 52, height: 31)
    }
    
    //MARK:- Layers
    //// `trackLayer`:-  is main track layer
    //// `innerLayer`:- over track layer
    ////`thumLayer` :- it is used for thumb
    
    fileprivate lazy var trackLayer = CALayer()
    fileprivate lazy var innerLayer = CALayer()
    fileprivate lazy var thumbLayer : CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0.75, height: 2)
        layer.contentsGravity = .resizeAspect
        return layer
    }()
    private lazy var contentsLayer = CALayer()
    
    private var onContentLayer: CALayer? {
        willSet {
            onContentLayer?.removeFromSuperlayer()
        }
        didSet {
            layoutOnContentLayer(for: layer.bounds)
        }
    }
    
    private var offContentLayer: CALayer? {
        willSet {
            offContentLayer?.removeFromSuperlayer()
        }
        didSet {
            layoutOffContentLayer(for: layer.bounds)
        }
    }
    
    fileprivate var isTouchDown: Bool = false
    
    //MARK:- initializers
    
    convenience init() {
        self.init(frame: .zero)
        frame.size = intrinsicContentSize
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
        layer.shadowOffset = .zero
        layer.shadowOpacity =  0.3
        layer.shadowRadius = 5
        
        backgroundColor = .clear
        
        layer.addSublayer(trackLayer)
        layer.addSublayer(innerLayer)
        layer.addSublayer(contentsLayer)
        layer.addSublayer(thumbLayer)
        
        trackLayer.backgroundColor = getBackgroundColor()
        setBorderColor()
        trackLayer.borderWidth = borderWidth
        
        innerLayer.backgroundColor = UIColor.white.cgColor
        
        contentsLayer.masksToBounds = true
        
        setThumbColor()
        
        addTouchHandlers()
        
        layoutSublayers(of: layer)
    }
    
    //MARK:- layoutSubviews
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        layoutTrackLayer(for: layer.bounds)
        layoutThumbLayer(for: layer.bounds)
        contentsLayer.frame = layer.bounds
        layoutOffContentLayer(for: layer.bounds)
        layoutOnContentLayer(for: layer.bounds)
        
    }
    
    public override func didMoveToSuperview() {
        layoutSublayers(of: layer)
    }
    
    fileprivate func layoutTrackLayer(for bounds: CGRect) {
        trackLayer.frame = bounds.insetBy(dx: trackTopBottomPadding, dy: trackTopBottomPadding)
        shape == .rounded ? (trackLayer.cornerRadius = trackLayer.bounds.height / 2) : (trackLayer.cornerRadius = bounds.height * 0.12)
    }
    
    fileprivate func layoutInnerLayer(for bounds: CGRect) {
        let inset = borderWidth + trackTopBottomPadding
        let isInnerHidden = isOn || (isTouchDown && isStretchEnable)
        
        innerLayer.frame = isInnerHidden
            ? CGRect(origin: trackLayer.position, size: .zero)
            : bounds.insetBy(dx: inset, dy: inset)
        
        shape == .rounded ?  (innerLayer.cornerRadius = isInnerHidden ? 0 : bounds.height / 2 - inset) : (innerLayer.cornerRadius = isInnerHidden ? 5 :   5)
    }
    
    fileprivate func layoutThumbLayer(for bounds: CGRect) {
        let size = getThumbSize()
        let origin = getThumbOrigin(for: size.width)
        thumbLayer.frame = CGRect(origin: origin, size: size)
        
        if let thumb = thumbImage {
            onThumbImage = thumb
            offThumbImage = thumb
        }
        
        thumbLayer.contents = isOn ? onThumbImage?.cgImage : offThumbImage?.cgImage
        
        shape == .rounded ? (thumbLayer.cornerRadius = size.height / 2) : (thumbLayer.cornerRadius = thumbCornerRadius)
    }
    
    private func layoutOffContentLayer(for bounds: CGRect) {
        
        let size = getContentLayerSize(for: offContentLayer)
        let y = bounds.midY - size.height / 2
        let leading = (bounds.maxX - (contentLeadingTrailingPadding + borderWidth + getThumbSize().width))/2 - size.width/2
        let x = !isOn ? bounds.width - size.width - leading : bounds.width
        let origin = CGPoint(x: x, y: y)
        offContentLayer?.frame = CGRect(origin: origin, size: size)
        bounds.height < 50 ? ((offContentLayer as? CATextLayer)?.fontSize = 12) : ((offContentLayer as? CATextLayer)?.fontSize = bounds.height * 0.2)
        
    }
    
    private func layoutOnContentLayer(for bounds: CGRect) {
        let size = getContentLayerSize(for: onContentLayer)
        let y = bounds.midY - size.height / 2
        let leading = (bounds.maxX - (contentLeadingTrailingPadding + borderWidth + getThumbSize().width))/2 - size.width/2
        let x = isOn ? leading : -bounds.width / 2
        let origin = CGPoint(x: x, y: y)
        onContentLayer?.frame = CGRect(origin: origin, size: size)
        onContentLayer?.contentsCenter =  CGRect(origin: origin, size: size)
        bounds.height < 50 ? ((onContentLayer as? CATextLayer)?.fontSize = 12) : ((onContentLayer as? CATextLayer)?.fontSize = bounds.height * 0.2)
    }
    
    fileprivate func stateDidChange() {
        trackLayer.backgroundColor = getBackgroundColor()
        trackLayer.borderWidth =  borderWidth
        thumbLayer.contents = isOn ? onThumbImage?.cgImage : offThumbImage?.cgImage
        setThumbColor()
        sendActions(for: .valueChanged)
        valueChange?(isOn)
    }
    
    public func setOn(_ on: Bool, animated: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(!animated)
        isOn = on
        layoutSublayers(of: layer)
        sendActions(for: .valueChanged)
        valueChange?(isOn)
        CATransaction.commit()
    }
    
    // MARK: - Touches
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
    private func swipeLeftRight(_ gesture: UISwipeGestureRecognizer) {
        let canLeftSwipe = isOn && gesture.direction == .left
        let canRightSwipe = !isOn && gesture.direction == .right
        guard canLeftSwipe || canRightSwipe else { return }
        touchUp()
    }
    
    @objc
    fileprivate func touchDown() {
        print("touch down")
        isTouchDown = true
        layoutSublayers(of: layer)
    }
    
    @objc
    fileprivate func touchUp() {
        isOn.toggle()
        stateDidChange()
        touchEnded()
    }
    
    @objc
    fileprivate func touchEnded() {
        isTouchDown = false
        layoutSublayers(of: layer)
    }
    
    // MARK: - Layout Helper
    fileprivate func setBorderColor(){
        if let borderClor = borderColor {
            trackLayer.borderColor = borderClor.cgColor
        } else {
            trackLayer.borderColor = (isOn ? onBorderColor : offBorderColor).cgColor
        }
    }
    
    private func setThumbColor(){
        if let thumbColor = thumbTintColor {
            thumbLayer.backgroundColor = thumbColor.cgColor
        } else {
            thumbLayer.backgroundColor = (isOn ? onThumbTintColor : offThumbTintColor).cgColor
        }
    }
    
    final func getBackgroundColor() -> CGColor {
        return (isOn ? onTintColor : offTintColor).cgColor
    }
    
    fileprivate func getThumbSize() -> CGSize {
        let height = bounds.height - 2 * (borderWidth + thumbRadiusPadding)
        let width = (isTouchDown && isStretchEnable) ? height * 1.2 : height
        return CGSize(width: width, height: height)
    }
    
    final func getThumbOrigin(for width: CGFloat) -> CGPoint {
        let inset = borderWidth + thumbRadiusPadding
        let x = isOn ? bounds.width - width - inset : inset
        return CGPoint(x: x, y: inset)
    }
    
    final func getContentLayerSize(for layer: CALayer?) -> CGSize {
        let inset = 2 * (borderWidth + trackTopBottomPadding)
        let diameter = bounds.height - inset - getThumbSize().height/2
        if let textLayer = layer as? CATextLayer {
            return textLayer.preferredFrameSize()
        }
        return CGSize(width: diameter, height: diameter)
    }
    
    // MARK: - Content Layers
    private func addOffTextLayerIfNeeded() {
        guard offText != nil else {
            offContentLayer = nil
            return
        }
        let textLayer = CATextLayer()
        textLayer.alignmentMode = .center
        textLayer.fontSize = bounds.height * 0.2
        textLayer.font =  UIFont.systemFont(ofSize: 10, weight: .bold)
        
        textLayer.foregroundColor = (textColor == nil) ? offTextColor.cgColor : textColor?.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        contentsLayer.addSublayer(textLayer)
        offContentLayer = textLayer
    }
    
    private func addOnTextLayerIfNeeded() {
        guard onText != nil else {
            onContentLayer = nil
            return
        }
        let textLayer = CATextLayer()
        textLayer.alignmentMode = .center
        textLayer.fontSize = bounds.height * 0.2
        textLayer.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        textLayer.foregroundColor = (textColor == nil) ? onTextColor.cgColor : textColor?.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        contentsLayer.addSublayer(textLayer)
        onContentLayer = textLayer
    }
    
    private func addOnImageLayerIfNeeded() {
        guard onImage != nil else {
            onContentLayer = nil
            return
        }
        let imageLayer = CALayer()
        imageLayer.contentsGravity = .center
        imageLayer.contentsScale = UIScreen.main.scale
        contentsLayer.addSublayer(imageLayer)
        onContentLayer = imageLayer
    }
    
    private func addOffImageLayerIfNeeded() {
        guard offImage != nil else {
            offContentLayer = nil
            return
        }
        let imageLayer = CALayer()
        imageLayer.contentsGravity = .resizeAspect
        imageLayer.contentsScale = UIScreen.main.scale
        contentsLayer.addSublayer(imageLayer)
        offContentLayer = imageLayer
    }
}
//https://dribbble.com/shots/2158763-simple-toggle
@IBDesignable public class YapSwitchSlim: YapSwitch {
    
    public var slimTrack: CGFloat = 0 {
        didSet {
            layoutSublayers(of: layer)
        }
    }
    
    override func layoutTrackLayer(for bounds: CGRect) {
        trackLayer.frame = bounds.insetBy(dx: trackTopBottomPadding, dy: trackTopBottomPadding + slimTrack)
        self.shape == .rounded ? (self.trackLayer.cornerRadius = self.trackLayer.bounds.height / 2) : (self.trackLayer.cornerRadius = bounds.height * 0.2)
    }
    
    override func layoutInnerLayer(for bounds: CGRect) {
        let inset = borderWidth + trackTopBottomPadding
        let isInnerHidden = isOn || (isTouchDown && isStretchEnable)
        
        innerLayer.frame = isInnerHidden
            ? CGRect(origin: trackLayer.position, size: .zero)
            : trackLayer.frame.insetBy(dx: inset, dy: inset)
        
        shape == .rounded ?  (innerLayer.cornerRadius = isInnerHidden ? 0 : innerLayer.bounds.height / 2 - inset) : (innerLayer.cornerRadius = isInnerHidden ? 5 :   5)
    }
    
    
}
////`Credit`: Robin
//https://dribbble.com/shots/2603107-toggle-switch-micro-interaction
//MARK:- YapGradientSwitch
public enum GradientPosition {
    case vertical
    case horizatal
}

@IBDesignable public class YapGradientSwitch: YapSwitch {
    
    private lazy var onGradientLayer = CAGradientLayer()
    private lazy var offGradientLayer = CAGradientLayer()
    
    public var gradientPosition: GradientPosition = .horizatal {
        didSet {
            setGradientPosition()
            layoutSublayers(of: layer)
        }
    }
    
    public var onColors : [UIColor] = [UIColor.red, UIColor.yellow] {
        didSet {
            onGradientLayer.colors = onColors.map{$0.cgColor}
        }
    }
    
    public var offColors : [UIColor] = [UIColor.red, UIColor.yellow] {
        didSet {
            offGradientLayer.colors = offColors.map{$0.cgColor}
        }
    }
    
    func createGradientLayer() {
        
        trackLayer.addSublayer(onGradientLayer)
        innerLayer.addSublayer(offGradientLayer)
        setGradientPosition()
        
    }
    
    private func setGradientPosition() {
        if gradientPosition == .horizatal {
            onGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            onGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
            offGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            offGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else {
            onGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            onGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
            offGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            offGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        }
    }
    
    override func controlDidLoad() {
        super.controlDidLoad()
        createGradientLayer()
    }
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        layoutInnerLayer(for: bounds)
        
        onGradientLayer.frame = trackLayer.bounds
        offGradientLayer.frame = trackLayer.bounds
        
        innerLayer.masksToBounds = true
        
        onGradientLayer.cornerRadius = trackLayer.cornerRadius
        offGradientLayer.cornerRadius = innerLayer.cornerRadius
    }
    
    
}

private protocol AnimationPath {
    func drawOnPath(_ group:CGRect) -> CGPath
    func drawOffPath(_ group:CGRect) -> CGPath
}

//// `Credit Design` : Andrei Mironov
//https://dribbble.com/shots/2309834-Yet-another-toggle-animation

//MARK:- YapAnimatedSwitch

@IBDesignable public class YapAnimatedSwitch: YapSwitch {
    
    public var animationColor: UIColor? = nil {
        didSet {  setShapeColor()  }
    }
    
    public var onAnimationColor: UIColor = .white {
        didSet {  setShapeColor()  }
    }
    
    public var offAnimationColor: UIColor = .white {
        didSet {  setShapeColor()  }
    }
    
    public var animationWidth: CGFloat = 3 {
        didSet { shapeLayer.lineWidth = animationWidth }
    }
    
    private lazy var shapeLayer : CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.clear.cgColor
        shape.lineCap = .round
        shape.lineWidth = animationWidth
        return shape
    }()
    
    public let duration:Double = 0.6
    
    override func controlDidLoad() {
        super.controlDidLoad()
        
        isStretchEnable = false
        thumbLayer.addSublayer(shapeLayer)
        setShapeColor()
        DispatchQueue.main.async {
            
            self.layoutThumbLayer(for: self.bounds)
            self.isOn ? (self.shapeLayer.path = self.drawOnPath(self.thumbLayer.bounds)) : (self.shapeLayer.path = self.drawOffPath(self.thumbLayer.bounds))
        }
        
    }
    
    private func setShapeColor() {
        shapeLayer.strokeColor =  (animationColor ??  (isOn ? onAnimationColor : offAnimationColor)).cgColor
    }
    
    public override func layoutSublayers(of layer: CALayer) {
        
        CATransaction.setAnimationDuration(duration)
        CATransaction.begin()
        super.layoutSublayers(of: layer)
        CATransaction.commit()
        
        shapeLayer.frame = thumbLayer.bounds
        
    }
    
    override func stateDidChange() {
        
        super.stateDidChange()
        isOn ? shapeLayer.animateShape(path: drawOnPath(thumbLayer.bounds), duration: (duration - duration/2)) : shapeLayer.animateShape(path: drawOffPath(thumbLayer.bounds), duration: (duration - duration/2))
        isOn ? shapeLayer.rotateAnimation(angal: 0, duration: duration) : shapeLayer.rotateAnimation(angal: .pi/2, duration: duration )
        setShapeColor()
    }
    
    
}

extension YapAnimatedSwitch: AnimationPath {
    
    fileprivate func drawOnPath(_ group:CGRect) -> CGPath {
        
        let bezierPath = UIBezierPath()
        
        let radius = group.maxX/5
        let center = CGPoint(x:group.midX,y:group.midY )
        
        let  x1 = center.x  + (radius ) *  cos(-45.degreesToRadians)
        let  y1 = center.y  + (radius  ) *  sin(-45.degreesToRadians)
        
        let  x2 = center.x  + (radius ) * cos(135.degreesToRadians)
        let  y2 = center.y  + (radius ) * sin(135.degreesToRadians)
        
        bezierPath.move(to: CGPoint(x: x1, y: y1))
        bezierPath.addLine(to: CGPoint(x: x2, y: y2))
        
        let  x3 = center.x  + (radius + radius * 0.5 ) *  cos(-175.degreesToRadians)
        let  y3 = center.y  + (radius  + radius * 0.5  ) *  sin(-175.degreesToRadians)
        
        bezierPath.move(to: CGPoint(x: x3, y: y3))
        bezierPath.addLine(to: CGPoint(x: x2, y: y2 ))
        
        return bezierPath.cgPath
        
    }
    
    fileprivate func drawOffPath(_ group:CGRect) -> CGPath {
        
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
        
        bezierPath.move(to: CGPoint(x: x4, y: y4))
        bezierPath.addLine(to: CGPoint(x: x3, y: y3))
        
        bezierPath.move(to: CGPoint(x: x1, y: y1))
        bezierPath.addLine(to: CGPoint(x: x2, y: y2))
        
        
        return bezierPath.cgPath
        
    }
}

/// `Design by` : tomatree
// https://dribbble.com/shots/2484722-Daily-Ui-Day-15-On-Off-Switch

//MARK:- YapModeSwitch

@IBDesignable public class YapModeSwitch: YapSwitch {
    
    private lazy var shapeLayer : CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.strokeColor = UIColor.clear.cgColor
        
        return shape
    }()
    
    private let duration:Double = 0.6
    
    
    public override func layoutSublayers(of layer: CALayer) {
        
        CATransaction.setAnimationDuration(duration)
        CATransaction.begin()
        super.layoutSublayers(of: layer)
        CATransaction.commit()
        
        shapeLayer.fillColor = thumbTintColor?.cgColor
        shapeLayer.frame = thumbLayer.bounds
        thumbLayer.backgroundColor = UIColor.clear.cgColor
    }
    
    override func controlDidLoad() {
        super.controlDidLoad()
        
        isStretchEnable = false
        thumbLayer.addSublayer(shapeLayer)
        
        DispatchQueue.main.async {
            self.isOn ? (self.shapeLayer.path = self.drawOffPath(self.thumbLayer.bounds)) : (self.shapeLayer.path = self.drawOnPath(self.thumbLayer.bounds))
        }
        
    }
    
    override func stateDidChange() {
        
        super.stateDidChange()
        isOn ? shapeLayer.animateShape(path:drawOffPath (thumbLayer.bounds), duration: duration - duration/1.5 ) : shapeLayer.animateShape(path: drawOnPath(thumbLayer.bounds), duration: duration - duration/1.5)
        
    }
}

extension YapModeSwitch: AnimationPath {
    fileprivate  func drawOnPath(_ group: CGRect) -> CGPath {
        let radius = group.maxX/2
        let center =  CGPoint(x: group.midX, y: group.midY)
        
        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: center, radius: radius, startAngle: 301.degreesToRadians, endAngle: 149.degreesToRadians, clockwise: true)
        bezierPath.addArc(withCenter: center, radius: radius, startAngle: 149.degreesToRadians, endAngle: 301.degreesToRadians, clockwise: true)
        bezierPath.close()
        
        return bezierPath.cgPath
    }
    
    fileprivate func drawOffPath(_ group: CGRect) -> CGPath {
        let radius: CGFloat = group.maxX/2
        
        let centerA =  CGPoint(x: group.midX, y: group.midY)
        let offset = radius * 1.0 / 3.0
        let centerB =  CGPoint(x: centerA.x - offset, y: centerA.y - offset)
        
        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: centerA, radius: radius, startAngle: 301.degreesToRadians, endAngle: 149.degreesToRadians, clockwise: true)
        bezierPath.addArc(withCenter: centerB, radius: radius, startAngle: 121.degreesToRadians, endAngle: 329.degreesToRadians, clockwise: false)
        bezierPath.close()
        
        return bezierPath.cgPath
    }
}


@IBDesignable public class YapDarkAndLightModeSwitch : YapSwitch {
    
    public let duration: Double = 0.6
    
    private lazy var shapeLayer : CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.strokeColor = UIColor.clear.cgColor
        return shape
    }()
    
    private lazy var maskLayer = CAShapeLayer()
    
    public override func layoutSublayers(of layer: CALayer) {
        
        CATransaction.setAnimationDuration(duration)
        CATransaction.begin()
        super.layoutSublayers(of: layer)
        CATransaction.commit()
        
        maskLayer.frame = thumbLayer.bounds
        
        shapeLayer.frame = thumbLayer.bounds
        shapeLayer.path = drawSunShape(thumbLayer.bounds)
        shapeLayer.mask = maskLayer
        thumbLayer.backgroundColor = thumbTintColor?.cgColor
        
    }
    
    override func controlDidLoad() {
        super.controlDidLoad()
        
        isStretchEnable = false
        thumbLayer.addSublayer(shapeLayer)
        
        DispatchQueue.main.async {
            self.isOn ? (self.maskLayer.path = self.drawOnPath(self.thumbLayer.bounds)) : (self.maskLayer.path = self.drawOffPath(self.thumbLayer.bounds))
        }
        thumbLayer.masksToBounds =  true
    }
    
    override func stateDidChange() {
        
        super.stateDidChange()
        isOn ? maskLayer.animateShape(path:drawOnPath(thumbLayer.bounds), duration: duration ) : maskLayer.animateShape(path: drawOffPath(thumbLayer.bounds), duration: duration )
        
        isOn ? thumbLayer.rotateAnimation(angal: 45.degreesToRadians, duration: duration) : thumbLayer.rotateAnimation(angal: 0, duration: duration)
        
        isOn ? animateFillColor(onTintColor) : animateFillColor(offTintColor)
        
    }
    
    private func animateFillColor(_ color: UIColor) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration / 2)
        self.shapeLayer.fillColor = color.cgColor
        CATransaction.commit()
    }
    
}
extension YapDarkAndLightModeSwitch: AnimationPath {
    
    private func drawSunShape(_ group:CGRect) -> CGPath {
        let bezierPath = UIBezierPath()
        let radius = group.maxX/2
        let center =  CGPoint(x: group.midX, y: group.midY)
        bezierPath.addArc(withCenter:center, radius: radius, startAngle: -.pi/2, endAngle: 3 * .pi * 0.5 , clockwise: true)
        return bezierPath.cgPath
    }
    
    func setMask(isFullSize:Bool)-> CGPath {
        
        var radius = thumbLayer.bounds.maxY/2
        let center = CGPoint(x:thumbLayer.bounds.midX,y:thumbLayer.bounds.midY )
        
        let  x1 = center.x  + radius  *  cos(180.degreesToRadians)
        let  y1 = center.y  + radius  *  sin(180.degreesToRadians)
        
        let bezierPath = UIBezierPath()
        
        isFullSize ? (radius = 0) : (radius += 0 )
        
        bezierPath.addArc(withCenter: CGPoint(x: x1, y: y1), radius: radius, startAngle: -90.degreesToRadians, endAngle: 90.degreesToRadians, clockwise: true)
        
        return bezierPath.cgPath
        
    }
    
    func drawOnPath(_ group: CGRect) -> CGPath {
        return setMask(isFullSize: false)
    }
    
    func drawOffPath(_ group: CGRect) -> CGPath {
        return setMask(isFullSize: true)
    }
}

@IBDesignable public class YapFullStretchSwitch : YapSwitch {
    override func getThumbSize() -> CGSize {
        let height = bounds.height - 2 * (borderWidth + thumbRadiusPadding)
        let width = (isTouchDown && isStretchEnable) ? bounds.width - 2 * (borderWidth + thumbRadiusPadding) : height
        return CGSize(width: width, height: height)
    }
}

@IBDesignable public class YapHalfStretchSwitch : YapSwitch {
    override func getThumbSize() -> CGSize {
        let height = bounds.height - 2 * (borderWidth + thumbRadiusPadding)
        let width = (isTouchDown && isStretchEnable) ? bounds.midX + bounds.midX/2 - 2 * (borderWidth + thumbRadiusPadding) : height
        return CGSize(width: width, height: height)
    }
    
    
    public override func layoutSublayers(of layer: CALayer) {
        
        super.layoutSublayers(of: layer)
        if shape == .square {
            thumbLayer.cornerRadius = bounds.height * 0.1
            thumbLayer.shadowOffset = .zero
        }
    }
}


