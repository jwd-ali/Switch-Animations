//
//  UIImage+Extension.swift
//  testi
//
//  Created by Jawad Ali on 29/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
public extension UIImage {

    func maskWithColor(color: UIColor) -> UIImage? {
    
        let maskLayer = CALayer()
        maskLayer.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        maskLayer.backgroundColor = color.cgColor
        maskLayer.doMask(by: self)
        let maskImage = maskLayer.toImage()
        return maskImage
    }

}
