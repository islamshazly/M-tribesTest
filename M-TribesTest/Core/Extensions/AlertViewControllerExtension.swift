//
//  AlertViewController.swift

//

import UIKit

extension UIAlertController {
    
    typealias SetErrorAction = ((UIAlertAction) -> ())

    class func ShowAlert(VC : UIViewController , error : TError , action : SetErrorAction?)
    {
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: action))
        VC.present(alert, animated: true, completion: nil)
    }
    
    class func ShowAlert(VC : UIViewController , message : String , action : SetErrorAction?)
    {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: action))
        VC.present(alert, animated: true, completion: nil)
    }
    
    class func ShowWarrning(VC : UIViewController , message : String , action : SetErrorAction?)
    {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "yes", style: UIAlertActionStyle.default, handler: action))
        alert.addAction(UIAlertAction(title: "no", style: .cancel, handler: nil))
        VC.present(alert, animated: true, completion: nil)
    }
    
    
    class func ShowWarrning(VC : UIViewController , message : String , action : SetErrorAction? , cancelAction : SetErrorAction?)
    {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "yes", style: UIAlertActionStyle.default, handler: action))
        alert.addAction(UIAlertAction(title: "no", style: .cancel, handler: cancelAction))
        VC.present(alert, animated: true, completion: nil)
    }
    
    
    class func ShowWarrningDelete(VC : UIViewController, action : SetErrorAction?)
    {
        let alert = UIAlertController(title: "", message: "warning_delete_item", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "yes", style: UIAlertActionStyle.default, handler: action))
        alert.addAction(UIAlertAction(title: "no", style: .cancel, handler: nil))
        VC.present(alert, animated: true, completion: nil)
    }
    
}
