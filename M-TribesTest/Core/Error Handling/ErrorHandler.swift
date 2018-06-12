//
//  LastRequest.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/12/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit

enum ErrorType {
  case ErrorTypeBlocking
  case ErrorTypePopup
  case ErrorTypeNotHandled
  case ErrorTypeServer
    case ErrorUnauthorized
  
}

enum TError: Error {
  
  case TNetworkFaild(reason : NetworkFaildReasons)
  case TBackendFaild(error : BaseModel)
  
  public enum NetworkFaildReasons: Int {
    case Unknown = 404
    case NoInternet = 1009
    case DefaultError = 9999
    case TimeOutError = 2102
    case ServerError = 0
    case Unauthorized = 401
  }
  
  
  var errorCode: Int {
    switch self {
    case .TNetworkFaild(let reason):
      return reason.rawValue
    case .TBackendFaild(let error):
      return error.code
    }
    
  }
  var type : ErrorType {
    switch self {
    case .TNetworkFaild(let reason):
      switch reason {
      case .Unknown :
        return ErrorType.ErrorTypeBlocking
      case .ServerError :
        return ErrorType.ErrorTypeServer
      default :
        return ErrorType.ErrorTypeBlocking
      }
    case .TBackendFaild(_):
      return ErrorType.ErrorTypeServer
    }
  }
}

extension TError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .TBackendFaild(let error):
      return error.message
    case .TNetworkFaild(let reason):
      return reason.localizedDescription
    }
  }
}

extension TError.NetworkFaildReasons {
  var localizedDescription: String {
    switch self {
    case .Unknown:
      return "Unknown error occurred"
    case .NoInternet:
      return "No Internet access"
    case .TimeOutError:
      return "slow internet connection"
    case .DefaultError:
      return "error error_general"
    case .ServerError:
      return "error_general"
    case .Unauthorized:
        return "Unauthorized"
    }
  }
}
