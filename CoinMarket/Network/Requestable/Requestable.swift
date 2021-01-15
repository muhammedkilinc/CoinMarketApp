//
//  Requestable.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 13.01.2021.
//

import Foundation
import Alamofire

protocol Requestable {

  var path: String { get }
  var headers: [String: String] { get }
  var method: HTTPMethod { get }
  var params: [String : Any]? { get }
}

extension Requestable {
  
  var baseURL: String {
    return Constants.API.BaseURL
  }
  
  var apiKey: String {
    return Constants.API.APIKey
  }
  
  var version: String {
    return Constants.API.APIVersion
  }
  
  var headers: [String : String] {
    return [Constants.API.HeaderAuth: apiKey]
  }
  
  var additionalParams: [String : Any] {
    return [:]
  }
  
  var urlComponents: URLComponents {
    guard var components = URLComponents(string: baseURL) else {
      fatalError("URLComponents cannot be created")
    }
    components.path = version + path
    
    var queryItems: [URLQueryItem] = []
    
    let params = additionalParams.map({ (key, value) -> URLQueryItem in
      return URLQueryItem(name: "\(key)", value: "\(value)")
    })
    
    queryItems.append(contentsOf: params)
    
    components.queryItems = queryItems
    return components
  }
  
  func encode<Parameters: Encodable>(_ parameters: Parameters?,
                                     into request: URLRequest,
                                     encoder: ParameterEncoder) throws -> URLRequest {
    return try encoder.encode(parameters, into: request)
  }
  
}

