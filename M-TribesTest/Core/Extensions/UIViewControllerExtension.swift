//
//  UIViewControllerExtension.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/12/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit

extension UIViewController {
  
   static func viewController(withStoryBoardname storyBoardName : String) -> UIViewController? {
    
    let storyboard = UIStoryboard(name: storyBoardName, bundle: .main)
    let controller = storyboard.instantiateInitialViewController()
    return controller
  }
  
   static func viewController(withStoryBoardname storyBoardName : String , contollerID : String) -> UIViewController? {
    
    let storyboard = UIStoryboard(name: storyBoardName, bundle: .main)
    let controller = storyboard.instantiateViewController(withIdentifier: contollerID)
    return controller
  }
    
    
    
    class var topMostViewController: UIViewController {
        let root = UIApplication.shared.keyWindow?.rootViewController
        return self.topMostViewControllerWithRootViewController(root: root!)
    }
    
    class func topMostViewControllerWithRootViewController(root: UIViewController) -> UIViewController {
        if let tab = root as? UITabBarController {
            return self.topMostViewControllerWithRootViewController(root: tab.selectedViewController!)
        }
        
        if let nav = root as? UINavigationController {
            return self.topMostViewControllerWithRootViewController(root: nav.visibleViewController!)
        }
        
        if let presented = root.presentedViewController {
            return self.topMostViewControllerWithRootViewController(root: presented)
        }
        
        // We are at the root
        return root
    }
  
}
