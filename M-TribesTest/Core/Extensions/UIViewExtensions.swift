import UIKit

extension UIView {
    

    
  @IBInspectable var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
      layer.masksToBounds = newValue > 0
    }
  }
  @IBInspectable var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  @IBInspectable var borderColor: UIColor? {
    get {
      return self.borderColor
    }
    set {
      layer.borderColor = newValue?.cgColor
    }
  }
  
  @IBInspectable var shadowColor: UIColor? {
    get {
      return self.shadowColor
    }
    set {
      layer.shadowColor = newValue?.cgColor
    }
  }
  
  @IBInspectable var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }
  
  @IBInspectable var shadowOpacity: Float {
    get {
      return layer.shadowOpacity
    }
    set {
      layer.shadowOpacity = newValue
    }
  }
  
  @IBInspectable var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }
  
  public func circulerContent() {
    layer.masksToBounds = true
    self.clipsToBounds = true
    self.cornerRadius = self.bounds.height / 2
  }
    
    func fadeIn(withDuration duration : Double) {
        
        UIView.animate(withDuration: duration) {
            self.alpha = 1
        }
    }
    
    func fadeOut(withDuration duration : Double) {
        
        UIView.animate(withDuration: duration) {
            self.alpha = 0
        }
    }
    
    
  
  enum Shape {
    case rectangle
    case rounded(CGFloat)
    case circular
  }
  
  func setShadow(color: UIColor = .black, radius: CGFloat = 2, opacity: Float = 0.15, offset: CGSize = CGSize(width: 0, height: 1)) {
    shadowColor = color
    shadowRadius = radius
    shadowOpacity = opacity
    shadowOffset = offset
  }
  
  func shadowView(color: UIColor, radius: CGFloat, opacity: Float, offset: CGSize = CGSize(width: 0 , height: 0), shape: Shape) -> UIView {
    switch shape {
    case .circular:
      self.circulerContent()
    case .rounded(let cornerRadius):
      self.cornerRadius = cornerRadius
    default:
      self.cornerRadius = 0
    }
    let shadowView = UIView()
    shadowView.frame = self.frame
    shadowView.layer.shadowColor = color.cgColor
    shadowView.layer.shadowOffset = offset
    shadowView.layer.shadowRadius = radius
    shadowView.layer.shadowOpacity = opacity
    switch shape {
    case .rectangle:
      shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
    case .circular:
      shadowView.layer.shadowPath = UIBezierPath(ovalIn: shadowView.bounds).cgPath
    case .rounded(let cornerRadius):
      shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: cornerRadius).cgPath
    }
    shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
    return shadowView
  }
    
    func ostaziShadow() {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0 , height: 0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
//        self.layer.masksToBounds = true
        self.clipsToBounds = false
    }
    
    func shadowAndRoundedCorner (withImage contentView : UIImageView) {
        contentView.layer.cornerRadius = 2.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    func cellShadow() {
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor.white
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2
        self.clipsToBounds = false

    }
    func sectionShadow(_ backgroundColor : UIColor) {
        
        self.layer.cornerRadius = 5
        self.backgroundColor = backgroundColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.25).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2
        self.clipsToBounds = false
        
//        self.layer.borderColor = UIColor.lightGray.cgColor
//        self.layer.borderWidth = 0.5
        
    }
    
    func tagLabelShadow() {
        

        self.alpha = 0.10
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor(red:0.87, green:0.71, blue:0.71, alpha:1)
        self.layer.shadowOffset = CGSize(width: 0, height: 14)
        self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.2).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.clipsToBounds = false
        
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
