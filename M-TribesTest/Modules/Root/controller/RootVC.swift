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
    var placeMarksObj : PlaceMarkersModel = PlaceMarkersModel()
    
    
    
    // MARK: - lifeCyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setDataToChildVC()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        
        tabBarData()
    }
    
    
    // MARK: - helping methods
    
    func tabBarData() {
        
        tabBar.items![0].title = "Place Marks"
        tabBar.items![0].image = #imageLiteral(resourceName: "data")
        tabBar.items![0].badgeValue = "\(placeMarksObj.placemarks.count)"
        
        tabBar.items![1].title = "MapKit"
        tabBar.items![1].image = #imageLiteral(resourceName: "location")
        
        tabBar.items![2].title = "GoogleMaps"
        tabBar.items![2].image = #imageLiteral(resourceName: "location-1")
        
        
    }
    
    func setDataToChildVC() {
        
        if let placeMarksVC = self.viewControllers?.first as? PlaceMarksTableView {
            placeMarksVC.placeMarksObj = placeMarksObj
        }
        
        if let locationVC = self.viewControllers![1] as? MapKitVC {
            
            locationVC.placeMarksObj = placeMarksObj
        }
        
        if let googleVC = self.viewControllers![2] as? GoogleMapVC {
            
            googleVC.locationObj = placeMarksObj
        }
        
    }
    
    
}
