//
//  RootVC.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/13/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit

final class RootVC: UITabBarController {
    
    // MARK: - variables
    var locationObj : LocationsModel = LocationsModel()

    
    
    // MARK: - lifeCyle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setDataToChildVC()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarData()
    }
    

    // MARK: - helping methods
    
    func tabBarData() {
        
        tabBar.items![0].title = "Locations"
        tabBar.items![0].image = #imageLiteral(resourceName: "data")
        tabBar.items![0].badgeValue = "\(locationObj.placemarks.count)"
        
        
    }
    
    func setDataToChildVC() {
        
        if let locationNC = self.viewControllers?.first as? UINavigationController {
            if let locationVC = locationNC.viewControllers.first as? LocationsTableView {
                locationVC.locationObj = locationObj
            }
        }
        
        
    }


}
