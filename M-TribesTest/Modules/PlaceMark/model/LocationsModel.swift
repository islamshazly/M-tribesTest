//
//  LocationsModel.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/12/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit
import ObjectMapper

final class LocationsModel: BaseModel {
    
    //MARK: - variables

    var placemarks: [LocationModel] = [LocationModel]()
    
    
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
