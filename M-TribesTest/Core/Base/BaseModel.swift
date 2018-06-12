//
//  BaseModel.swift
////  M-TribesTest
//
//  Created by Islam Elshazly on 6/12/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit
import ObjectMapper

typealias SuccessClosure = (Any?) -> Void
typealias FailureClosure = (TError?) -> Void

protocol ServiceDelegate : class {
    func didReceiveDataSuccessfully(data: Any, identifier: String)
    func didFailToReceiveData(error: TError, identifer: String)
}

class BaseModel: Mappable {

    weak var delegate : ServiceDelegate?
    
    
    // if back end send code and message
    
    var code : Int = 0
    var message : String = ""
    
    //MARK: - Initializers
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    convenience init(delegate : ServiceDelegate) {
        
        self.init()
        self.delegate = delegate
        
    }
    
     func mapping(map: Map) {
        
        
        code <- map["code"]
        message <- map["message"]
    }
    
    //Mark: - Base Methods
    func startApiRequest(withRequestConfiguration request: RequestConfiguraton , successClouser : @escaping SuccessClosure , failureClouser : @escaping FailureClosure) {
        
        NetworkManager.startRequest(withRequestConfiguration: request, withMappingObject: request.modelClass, successClouser: { (model) in
            successClouser(model)
        }) { (error) in
            failureClouser(error)
        }
    }

}


