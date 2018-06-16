//
//  ColorExtension.swift

//

import UIKit

extension UIColor {
    
        
    open class var oDark: UIColor { return UIColor(red: 21 / 255.0, green: 38 / 255.0, blue: 42 / 255.0, alpha: 1) }
    


    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    
}
