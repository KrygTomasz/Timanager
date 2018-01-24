//
//  UIColor+Extensions.swift
//  Timanager
//
//  Created by Kryg Tomasz on 08.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit

extension UIColor
{
    
    convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public class var main: UIColor {
        return .black
//        return UIColor(hex: "#052D4F")
    }
    public class var tint: UIColor {
        return .brown
//        return UIColor(hex: "#286496")
    }
    public class var statistics: UIColor {
        return .yellow
//        return UIColor(hex: "#286496")
    }
    public class var activities: UIColor {
        return .red
//        return UIColor(hex: "#193F5E")
    }
    public class var settings: UIColor {
        return .blue
//        return UIColor(hex: "#052D4F")
    }
    public class var info: UIColor { // <- zostaw to, nieużywane nigdzie
        return UIColor(hex: "#55BF53")
    }
    public class var chooseActivities: UIColor {
        return .green
//        return UIColor(hex: "#337FBF")
    }
    public class var mainDarkGreen: UIColor {
        return UIColor(hex: "#096E16")
    }
    public class var mainDarkRed: UIColor {
        return UIColor(hex: "#9E1E16")
    }
    public class var mainPastelGreen: UIColor {
        return UIColor(hex: "8FCF7A")
    }
    public class var mainPastelRed: UIColor {
        return UIColor(hex: "C75957")
    }
    
}

//MARK: Gradient
extension UIColor {
    
    static func gradient(using colors: [CGColor]) -> CAGradientLayer {
        
        let gradient = CAGradientLayer()
        gradient.colors = colors
        for i in 0..<colors.count {
            let location: NSNumber = (NSNumber(value: (Float)(i)/(Float)(colors.count)))
            gradient.locations?.append(location)
        }
        return gradient
        
    }
    
    static func generateColorSet(ofSize size: Int, saturation: CGFloat = 1, brightness: CGFloat = 1, alpha: CGFloat = 1) -> [UIColor] {
        
        var colors: [UIColor] = []
        for i in 0...size {
            let hue = CGFloat(i)/CGFloat(size)
            let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
            colors.append(color)
        }
        return colors
        
    }
    
}
