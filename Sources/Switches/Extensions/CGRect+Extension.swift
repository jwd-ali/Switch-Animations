//
//  CGRect+Extension.swift
//  Switches
//
//  Created by Jawad Ali on 05/12/2021.
//  Copyright © 2021 Jawad Ali. All rights reserved.
//

import UIKit
extension CGRect {
  var drawOnPath: CGPath {
    let bezierPath = UIBezierPath()

    let radius = self.maxX/5
    let center = CGPoint(x: self.midX, y: self.midY)

    let x1 = center.x + radius * cos(-45.degreesToRadians)
    let y1 = center.y + radius * sin(-45.degreesToRadians)

    let x2 = center.x + radius * cos(135.degreesToRadians)
    let y2 = center.y + radius * sin(135.degreesToRadians)

    let x3 = center.x + (radius + radius * 0.5) * cos(-175.degreesToRadians)
    let y3 = center.y + (radius + radius * 0.5) * sin(-175.degreesToRadians)

    bezierPath.move(to: CGPoint(x: x3, y: y3))
    bezierPath.addLine(to: CGPoint(x: x2, y: y2))

    bezierPath.addLine(to: CGPoint(x: x1, y: y1))

    return bezierPath.cgPath
  }

  var drawOffPath: CGPath {
    let bezierPath = UIBezierPath()

    let radius = self.maxX/5
    let center = CGPoint(x: self.midX, y: self.midY)

    let x1 = center.x + radius * cos(-45.degreesToRadians)
    let y1 = center.y + radius * sin(-45.degreesToRadians)

    let x2 = center.x + radius * cos(135.degreesToRadians)
    let y2 = center.y + radius * sin(135.degreesToRadians)

    let x3 = center.x + radius * cos(-135.degreesToRadians)
    let y3 = center.y + radius * sin(-135.degreesToRadians)

    let x4 = center.x + radius * cos(45.degreesToRadians)
    let y4 = center.y + radius * sin(45.degreesToRadians)

    bezierPath.move(to: CGPoint(x: x3, y: y3))
    bezierPath.addLine(to: CGPoint(x: x4, y: y4))

    bezierPath.move(to: CGPoint(x: x1, y: y1))
    bezierPath.addLine(to: CGPoint(x: x2, y: y2))

    return bezierPath.cgPath
  }

  var bubbleShapePath: CGPath {
    let bubblePath = UIBezierPath()
    let sR = (size.width - size.height)/4
    let lR = size.height/2

    let l1 = CGPoint(x: sR, y: lR - sR)
    let l2 = CGPoint(x: sR, y: lR + sR)

    let c1 = CGPoint(x: sR * 2 + lR, y: 0)
    let c2 = CGPoint(x: sR * 2 + lR, y: lR * 2)

    let r1 = CGPoint(x: sR * 3 + lR * 2, y: lR - sR)
    let r2 = CGPoint(x: sR * 3 + lR * 2, y: lR + sR)

    let o1 = CGPoint(x: (lR + sR * 2)/4, y: lR - sR)
    let o2 = CGPoint(x: (lR + sR * 2)/4, y: lR + sR)
    let o3 = CGPoint(x: (lR * 2 + sR * 4) - (lR + sR * 2)/4, y: lR - sR)
    let o4 = CGPoint(x: (lR * 2 + sR * 4) - (lR + sR * 2)/4, y: lR + sR)

    //        let cL = CGPoint(x: sR, y: lR)
    let cC = CGPoint(x: sR * 2 + lR, y: lR)
    //        let cR = CGPoint(x: sR * 3 + lR * 2, y: lR)

    bubblePath.move(to: l1)
    bubblePath.addQuadCurve(to: c1, controlPoint: o1)
    bubblePath.addArc(withCenter: cC, radius: lR, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi * 3/2, clockwise: true)
    bubblePath.addQuadCurve(to: r1, controlPoint: o3)
    bubblePath.addLine(to: r2)

    bubblePath.addQuadCurve(to: c2, controlPoint: o4)
    bubblePath.addQuadCurve(to: l2, controlPoint: o2)
    bubblePath.addLine(to: l1)
    bubblePath.close()

    return bubblePath.cgPath
  }

  var drawModeOnPath: CGPath {
    let radius = self.maxX/2
    let center = CGPoint(x: self.midX, y: self.midY)

    let bezierPath = UIBezierPath()
    bezierPath.addArc(withCenter: center, radius: radius, startAngle: 301.degreesToRadians, endAngle: 149.degreesToRadians, clockwise: true)
    bezierPath.addArc(withCenter: center, radius: radius, startAngle: 149.degreesToRadians, endAngle: 301.degreesToRadians, clockwise: true)
    bezierPath.close()

    return bezierPath.cgPath
  }

  var drawModeOffPath: CGPath {
    let radius: CGFloat = self.maxX/2

    let centerA = CGPoint(x: self.midX, y: self.midY)
    let offset = radius * 1.0/3.0
    let centerB = CGPoint(x: centerA.x - offset, y: centerA.y - offset)

    let bezierPath = UIBezierPath()
    bezierPath.addArc(withCenter: centerA, radius: radius, startAngle: 301.degreesToRadians, endAngle: 149.degreesToRadians, clockwise: true)
    bezierPath.addArc(withCenter: centerB, radius: radius, startAngle: 121.degreesToRadians, endAngle: 329.degreesToRadians, clockwise: false)
    bezierPath.close()

    return bezierPath.cgPath
  }
}
