//
//  NavigationController.swift
//  JDNavigationBar
//
//  Created by Jawad Ali on 26/08/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.

import UIKit

// Availables Shapes
public enum ShapeMode: Int {
    case zigzag = 0
    case wave
    case folded
    case square
}

public class JDNavigationBar: UINavigationBar {
    private  var statusBar =  UIView()
    private var color: UIColor = #colorLiteral(red: 0.287330091, green: 0.7017020583, blue: 0.9429889321, alpha: 1)
    public var cycles: Int = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var shape: ShapeMode = .wave {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var heightShape: CGFloat = 40 {
        didSet {
            self.heightShape = self.heightShape >= 0 ? self.heightShape : 0
        }
    }
    
    private lazy var customHeight = self.bounds.height + self.heightShape
    
    let shadowLayer = CAShapeLayer()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    func commonInit() {
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black
        shadow.shadowBlurRadius = 8
        shadow.shadowOffset = CGSize(width: 0, height: 3)
        
        self.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name:"AvenirNext-bold", size: 20)!, .shadow: shadow]

        barStyle = .black
        isTranslucent = true
        tintColor = .white
        backgroundColor = .clear
        changeColor(color)
        shadowLayer.backgroundColor = UIColor.green.cgColor
        DispatchQueue.main.async {
            
            if #available(iOS 13.0, *) {
                
                self.statusBar = UIView(frame: (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame) ?? CGRect.zero)
                self.statusBar.backgroundColor = self.color
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(self.statusBar)
                
            } else {
                // Apply color on status bar
                if let getStatusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
                    self.statusBar = getStatusBar
                    if self.statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
                        self.statusBar.backgroundColor = self.color
                    }
                }
            }
        }
    }
    
    
    public func changeColor(_ color : UIColor){
        self.color = color
        shadowLayer.fillColor = self.color.cgColor
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.statusBar.backgroundColor = self.color
        }
    }
    
    override public func draw(_ rect: CGRect) {
        
        
        switch shape {
        case .folded:
            shadowLayer.path = self.drawFolded()
        case .wave:
            shadowLayer.path = self.drawWave()
        case .zigzag:
            shadowLayer.path = self.drawZigzag()
        case .square:
            shadowLayer.path = self.drawSquare()
        }
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.23
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shouldRasterize = true
 
        
        layer.insertSublayer(shadowLayer, below: self.topItem?.titleView?.layer)
    }
    
}

//MARK:- Paths
extension JDNavigationBar {
    
    /*
     Add a Zigzag shape to the navigation bar
     */
    func drawZigzag()-> CGPath {
        
        let width = self.layer.frame.width
        let height = self.layer.frame.height
        
        let bezierPath: UIBezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: height))
        
        let cycleSizeHalf: CGFloat = (width / CGFloat(self.cycles)) / 2
        var x: CGFloat = 0
        for _ in 1...(self.cycles * 2) {
            x = x + cycleSizeHalf
            bezierPath.addLine(to: CGPoint(x: x, y: height + CGFloat(self.heightShape)))
            x = x + cycleSizeHalf
            bezierPath.addLine(to: CGPoint(x: x, y: height))
        }
        bezierPath.addLine(to: CGPoint(x: width, y: 0))
        bezierPath.close()
        return bezierPath.cgPath
    }
    
    
    
    func drawFolded()-> CGPath {
        let bezierPath: UIBezierPath = UIBezierPath()
        let frame = CGRect(x: 0, y: 0, width: bounds.maxX, height: bounds.maxY + heightShape/2)
      
        bezierPath.append(UIBezierPath(roundedRect: frame, byRoundingCorners: [.bottomLeft  ,.bottomRight], cornerRadii: CGSize(width: heightShape, height: heightShape)))
          heightShape /= 2
        return bezierPath.cgPath
    }
    
    /*
     Add a Wave shape to the navigation bar
     */
    
    func drawWave()-> CGPath {
        let width = self.layer.frame.width
        let height = self.layer.frame.height
        let bezierPath: UIBezierPath = UIBezierPath()
        // Mandatory Odd number
        if self.cycles % 2 == 0 {
            self.cycles += 1
        }
        
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: height))
        
        let cycleSize = width / CGFloat(self.cycles)
        var x: CGFloat = 0
        let arcHeight = CGFloat(self.heightShape) / 2
        let y: CGFloat = height + arcHeight
        
        for i in 0..<self.cycles {
            if (i % 2) == 0 {
                if (i + 1) == self.cycles {
                    bezierPath.addQuadCurve(to: CGPoint(x: x + cycleSize, y: height), controlPoint: CGPoint(x: x + cycleSize / 2, y: y + arcHeight))
                } else {
                    bezierPath.addQuadCurve(to: CGPoint(x: x + cycleSize, y: y), controlPoint: CGPoint(x: x + cycleSize / 2, y: y + arcHeight))
                }
            } else {
                bezierPath.addQuadCurve(to: CGPoint(x: x + cycleSize, y: y), controlPoint: CGPoint(x: x + cycleSize / 2, y: y - arcHeight))
            }
            x += cycleSize
        }
        bezierPath.addLine(to: CGPoint(x: width, y: 0))
        bezierPath.close()
        return bezierPath.cgPath
    }
    
    /*
     Add a Square shape to the navigation bar
     */
    func drawSquare() -> CGPath {
        let width = self.layer.frame.width
        let height = self.layer.frame.height
        let bezierPath: UIBezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: height))
        
        let cycleSize: CGFloat = width / CGFloat(self.cycles * 2)
        let xOffset = cycleSize / 2
        var x = xOffset
        
        bezierPath.addLine(to: CGPoint(x: xOffset, y: height))
        
        for i in 0..<self.cycles {
            bezierPath.addLine(to: CGPoint(x: x, y: height + CGFloat(self.heightShape)))
            x = x + cycleSize
            bezierPath.addLine(to: CGPoint(x: x, y: height + CGFloat(self.heightShape)))
            bezierPath.addLine(to: CGPoint(x: x, y: height))
            
            if (i + 1) != self.cycles {
                x = x + cycleSize
                bezierPath.addLine(to: CGPoint(x: x, y: height))
            }
        }
        x = x + xOffset
        bezierPath.addLine(to: CGPoint(x: x, y: height))
        bezierPath.addLine(to: CGPoint(x: width, y: 0))
        bezierPath.close()
        return bezierPath.cgPath
    }
}


