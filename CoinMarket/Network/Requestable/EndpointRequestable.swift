//
//  EndpointRequestable.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 13.01.2021.
//

import Foundation
import Alamofire

enum EndpointRequestable {
  
  case cryptocurrencyLatest(CryptocurrencyListRequest)
  case cryptocurrencyInfo(CryptocurrencyInfoRequest)

}

extension EndpointRequestable: Requestable {
 
  var method: HTTPMethod {
    switch self {
    default:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .cryptocurrencyLatest: return "/cryptocurrency/listings/latest"
    case .cryptocurrencyInfo: return "/cryptocurrency/info"
    }
  }
  
  var params: [String : Any]?  {
    switch self {
    default:
      return nil
    }
  }
  
  var urlRequest: URLRequest {
    var request = URLRequest(url: urlComponents.url!)
    
    for (key, value) in headers {
      request.setValue(value, forHTTPHeaderField: key)
    }
    
    switch self {
    case let .cryptocurrencyLatest(parameters):
      request = try! self.encode(parameters, into: request, encoder: URLEncodedFormParameterEncoder())
    case let .cryptocurrencyInfo(parameters):
      request = try! self.encode(parameters, into: request, encoder: URLEncodedFormParameterEncoder())
    //    default:
    //      break
    }

    return request
  }
  
}
