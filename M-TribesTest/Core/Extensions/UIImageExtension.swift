


import UIKit
import ImageIO



extension UIImage {
    
    
    
    var widthPixel : Int {
        get {
            return Int(self.scale * self.size.width)
        }
    }
    
    var hieghtPixel : Int {
        get {
            return Int(self.scale * self.size.height)
        }
    }
    
    
    var fileSize :Double  {
        get {
            var imgData =  UIImagePNGRepresentation(self)
            // var imgData: NSData = UIImagePNGRepresentation(image)
            // you can also replace UIImageJPEGRepresentation with UIImagePNGRepresentation.
            let imageSize: Int = imgData!.count
            return Double(imageSize) / 1024.0
        }
    }
}

extension UIImageView {
    
    
    var widthPixel : Int {
        get {
            return Int(self.image!.scale * self.image!.size.width)
        }
    }
    
    var hieghtPixel : Int {
        get {
            return Int(self.image!.scale * self.image!.size.height)
        }
    }
    
    
    
    @IBInspectable var imageTint: UIColor {
        get {
            return tintColor
        }
        set {
            self.image = self.image!.withRenderingMode(.alwaysTemplate)
            self.tintColor = newValue
            
        }
    }
    
    func disable() {
        self.alpha = 0.5
    }
    func enable() {
        self.alpha = 1
    }
    
    
    func changeImageColorTint(_ color : UIColor) {
        
        self.image = self.image!.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
        
    }
}
