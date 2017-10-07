//
//  UIView+Extensions.swift
//  Timanager
//
//  Created by Kryg Tomasz on 09.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit

extension UIButton {
    
    func scaleImage(height: CGFloat, width: CGFloat) {
        self.imageEdgeInsets = UIEdgeInsetsMake(self.frame.size.height/2 - height/2, self.frame.size.width/2 - width/2, self.frame.size.height/2 - height/2, self.frame.size.width/2 - width/2)
    }
    
}

extension UIView {
    
    func addShadow() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 2)
        self.layer.shadowRadius = 3
        self.layer.shouldRasterize = false
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
        
    }
    
    func removeShadow() {
        
        self.layer.shadowColor = UIColor.clear.cgColor
        
    }
    
    func addGradientBackground(using colors: [CGColor]) {
        
        let backgroundLayer = UIColor.gradient(using: colors)
        self.backgroundColor = UIColor.clear
        backgroundLayer.frame = self.frame
        self.layer.insertSublayer(backgroundLayer, at: 0)
        
    }
    
    func roundCornersWithLayerMask(cornerRadii: CGFloat, corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
    static func addParallaxToView(vw: UIView) {
        let amount = 40
        
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        vw.addMotionEffect(group)
    }
    
}
