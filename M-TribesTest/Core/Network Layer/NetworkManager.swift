//
//  NetworkManager.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/12/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper


typealias NetworkSuccessClosure = (BaseModel?) -> Void
typealias NetworkFailureClosure = (TError?) -> Void


final class NetworkManager: NSObject {
  
  class func startRequest<T: BaseModel>(withRequestConfiguration requestConfiguration : RequestConfiguraton , withMappingObject objectClass : T? , successClouser success : NetworkSuccessClosure? , andFailure failure : @escaping NetworkFailureClosure ) {
    
    if !serverReachable(forUrl: Constants.baseURL) {
        failure(TError.TNetworkFaild(reason: .NoInternet))
        requestConfiguration.failureClouser = failure
        requestConfiguration.successClouser = success

        if !LastRequest.request.lastRequests.contains(requestConfiguration){
            LastRequest.request.lastRequests.append(requestConfiguration)
        }
        return
    }

    #if DEBUG
    print("Request URL: \(String(describing: requestConfiguration.path))")
    print("Request Paramters: \(String(describing: requestConfiguration.parameters))")
    print("Request Header: \(String(describing: requestConfiguration.headers))")

    #endif

    var encode : ParameterEncoding = JSONEncoding.default
    encode = requestConfiguration.requestMethod == .get ? URLEncoding.default : JSONEncoding.default
    
    Alamofire.request(requestConfiguration.path, method: requestConfiguration.requestMethod, parameters: requestConfiguration.parameters, encoding: encode, headers: requestConfiguration.headers).responseJSON { (response :DataResponse<Any>) in
      
        
      switch response.result {
      case .success(_):
        if let data = response.result.value {
          let model : BaseModel = Mapper<T>().map(JSONObject: data, toObject: objectClass!)
          success!(model)
            if LastRequest.request.lastRequests.count > 0 {
                if let requestIndex = LastRequest.request.lastRequests.index(of: requestConfiguration) {

                    LastRequest.request.lastRequests.remove(at: requestIndex)
                }
            }
        }
        break
        
      case .failure(_):
        failure(response.result.error as? TError)
        break
      }
    }
  }
    
    class func restartRequest () {
        
        for request in LastRequest.request.lastRequests {
            print("Restart Request URL: \(String(describing: request.path))")
            self.startRequest(withRequestConfiguration: request, withMappingObject: request.modelClass, successClouser: request.successClouser, andFailure: request.failureClouser!)
        }
    }
    
    class func serverReachable(forUrl url: String) -> Bool {
        return  NetworkReachabilityManager(host:url)!.isReachable
    }
    
    
}
