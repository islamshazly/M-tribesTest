//
//  UIButtonExtension.swift
//  Baheeg
//
//  Created by Islam Elshazly on 5/24/18.
//  Copyright © 2018 krashless.com. All rights reserved.
//

import UIKit


extension UIButton {
    func disable() {
        self.isEnabled = false
        self.alpha = 0.5
    }
    
    func enable() {
        self.isEnabled = true
        self.alpha = 1.0
    }
    
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}

