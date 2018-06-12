//
//  LocationModel.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/12/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit
import ObjectMapper


final class LocationModel: BaseModel {
    
    // Base Model is case we have common retuns form back end

    var address: String = ""
    var engineType: String = ""
    var exterior: String = ""
    var fuel :Int = 0
    var interior: String = ""
    var name: String = ""
    var vin: String = ""
    var coordinates = [Double]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        address <- map["address"]
        engineType <- map["engineType"]
        exterior <- map["exterior"]
        fuel <- map["fuel"]
        interior <- map["interior"]
        coordinates <- map["coordinates"]
        name <- map["name"]
        vin <- map["vin"]
        
    }

}
