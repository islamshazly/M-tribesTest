//
//  LocationAnnotation.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/13/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit
import MapKit
import Cluster

final class LocationAnnotation: Annotation {


    
    init(lat : Double , long : Double , title: String , subTitle: String) {
        
        super.init()
        let  coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.coordinate = coordinate
        self.style =  .color(.red, radius: 25)
        self.title = title
        self.subtitle = subTitle
    }

}
