//
//  ViewTool.swift
//  Timanager
//
//  Created by Kryg Tomasz on 08.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit

class ViewTool {
    
    static func addShadow(to view: UIView) {
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 2)
        view.layer.shadowRadius = 3
        view.layer.shouldRasterize = false
        view.layer.shadowOpacity = 0.8
        view.layer.masksToBounds = false
        
    }
    
    static func addShadow(to view: UIView, offset: CGSize) {
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = 3
        view.layer.shouldRasterize = false
        view.layer.shadowOpacity = 0.8
        view.layer.masksToBounds = false
        
    }
    
    static func removeShadow(from view: UIView) {
        
        view.layer.shadowColor = UIColor.clear.cgColor
        
    }
    
    static func addGradientBackground(to view: UIView, using colors: [CGColor]) {
        
        let backgroundLayer = UIColor.gradient(using: colors)
        view.backgroundColor = UIColor.clear
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
        
    }
    
}
