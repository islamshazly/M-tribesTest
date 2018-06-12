//
//  ColorExtension.swift
//  Twigano
//
//  Created by mac on 8/2/17.
//  Copyright © 2017 islam elshazly All rights reserved.
//

import UIKit

extension UIColor {
    
    open class var oshadow: UIColor { return UIColor(red: 117 / 255.0, green: 115 / 255.0, blue: 121 / 255.0, alpha: 1) }
    
    
    open class var oDark: UIColor { return UIColor(red: 21 / 255.0, green: 38 / 255.0, blue: 42 / 255.0, alpha: 1) }
    
    open class var oOrange: UIColor { return UIColor(red: 255 / 255.0, green: 112 / 255.0, blue: 0 / 255.0, alpha: 1) }
    
    open class var tGray: UIColor { return UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1) }
    
    open class var selectedColor : UIColor { return UIColor(red: 238 / 255.0, green: 110 / 255.0, blue: 115 / 255.0, alpha: 1)}
    open class var unselectedColor :UIColor { return UIColor(red: 37 / 255.0, green: 37 / 255.0, blue: 37 / 255.0, alpha: 1)}
    
    open class var ONativeColore: UIColor { return UIColor(red: 237 / 255.0, green: 237 / 255.0, blue: 243 / 255.0, alpha: 1) }
    
    open class var activeIcon: UIColor { return UIColor(red: 146 / 255.0, green: 42 / 255.0, blue: 142 / 255.0, alpha: 1)}
    
    open class var inActiveIcon: UIColor { return .black }
    
    open class var bPurpel: UIColor { return UIColor(red: 146 / 255.0, green: 42 / 255.0, blue: 142 / 255.0, alpha: 1) }

    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    
}
