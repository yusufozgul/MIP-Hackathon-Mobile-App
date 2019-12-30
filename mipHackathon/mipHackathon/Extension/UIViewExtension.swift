//
//  UIViewExtension.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func shake()
    {
        self.backgroundColor = .systemRed
        self.alpha = 0.3
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.backgroundColor = .clear
        }
    }
}

extension UIFont
{
    static func TTNorms_Bold(size: CGFloat) -> UIFont
    {
        return UIFont(name: "TTNorms-Bold", size: size) ?? UIFont()
    }
    
    static func TTNorms_Medium(size: CGFloat) -> UIFont
    {
        return (UIFont(name: "TTNorms-Medium", size: size) ?? UIFont())
    }
    
    static func TTNorms_Regular(size: CGFloat) -> UIFont
    {
        return UIFont(name: "TTNorms-Regular", size: size) ?? UIFont()
    }
    
    static func CeraPro_Bold(size: CGFloat) -> UIFont
    {
        return UIFont(name: "CeraPro-Bold", size: size) ?? UIFont()
    }
    static func CeraPro_Medium(size: CGFloat) -> UIFont
    {
        return UIFont(name: "CeraPro-Medium", size: size) ?? UIFont()
    }
}
