//
//  GooglePOIITem.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/16/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit
import GoogleMaps



@objc final class GooglePOIITem: GMSMarker , GMUClusterItem  {
    
    
    
    init(lat : Double , long: Double , name: String , subtitle: String) {
        
        super.init()
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.position = coordinate
        self.title = name
        self.snippet = subtitle
    }
    

}
