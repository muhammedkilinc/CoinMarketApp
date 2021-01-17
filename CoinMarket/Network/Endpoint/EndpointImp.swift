//
//  EndpointImp.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import Foundation
import RxSwift

class EndpointImp: Endpoint {
//
//  private let interceptor: Interceptor
//
//  init(interceptor: Interceptor) {
//    self.interceptor = interceptor
//  }
  
  func cryptocurrencyLatest(request: CryptocurrencyListRequest) -> Observable<Response<[Cryptocurrency]>> {
    let method = EndpointRequestable.cryptocurrencyLatest(request)
    return method.urlRequest.perform()
//      .perform(interceptor: interceptor)
  }
  
  func cryptocurrencyInfo(request: CryptocurrencyInfoRequest) -> Observable<Response<[String: CryptocurrencyDetail]>> {
    let method = EndpointRequestable.cryptocurrencyInfo(request)
    return method.urlRequest.perform()
  }

}
