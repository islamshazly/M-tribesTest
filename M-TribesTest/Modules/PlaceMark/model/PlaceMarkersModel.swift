//
//  LocationsModel.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/12/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit
import ObjectMapper

final class PlaceMarkersModel: BaseModel {
    
    //MARK: - variables

    var placemarks: [MarkModel] = [MarkModel]()
    
    
    //MARK: - map object
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        placemarks <- map["placemarks"]
    }
    
    //MARK: - API Call
    
    func requestTopUsers(WithCallBack success : @escaping SuccessClosure, faliure : @escaping FailureClosure) {
        
    
        // RequestConfiguraton insert base url as defualt
        
        let request = RequestConfiguraton(WithRequestMethod: .get,Path: Constants.Locations, modelClass: self, parameters: nil , Headers : nil)
        
        //
        
        self.startApiRequest(withRequestConfiguration: request, successClouser: { (model) in
            success(model)
            self.delegate?.didReceiveDataSuccessfully(data: model!, identifier: request.path)
        }) { (error) in
            faliure(error)
            self.delegate?.didFailToReceiveData(error: error!, identifer: request.path)
        }
    }
}


extension PlaceMarkersModel {
    
    //MARK: - Helping Metthods
    
    func generateGoogleItems() -> [GooglePOIITem] {
        
        var items = [GooglePOIITem]()
        
        for mark in placemarks {
            let item = GooglePOIITem(lat: mark.lat, long: mark.long, name: mark.name, subtitle: mark.address)
            items.append(item)

        }
        
        return items
    }
    
    func generateAnnotations() -> [LocationAnnotation] {
        
        var items = [LocationAnnotation]()
        
        for mark in placemarks {
            let annotation = LocationAnnotation(lat: mark.lat, long: mark.long, title: mark.name, subTitle: mark.address)
            items.append(annotation)
        }
        
        return items
        
    }
    
}
