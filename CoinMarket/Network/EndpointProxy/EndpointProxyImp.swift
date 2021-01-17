//
//  EndpointProxyImp.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import Foundation
import RxSwift

class EndpointProxyImp: EndpointProxy {
  
  private let endpoint: Endpoint
  
  init(endpoint: Endpoint) {
    let cache = URLCache.shared
    cache.removeAllCachedResponses()
    self.endpoint = endpoint
  }
  
  func cryptocurrencyLatest(request: CryptocurrencyListRequest) -> Observable<Resource<[Cryptocurrency]>> {
    return endpoint.cryptocurrencyLatest(request: request)
      .applyResource()
  }
  
  func cryptocurrencyInfo(request: CryptocurrencyInfoRequest) -> Observable<Resource<[String: CryptocurrencyDetail]>> {
    return endpoint.cryptocurrencyInfo(request: request)
      .applyResource()
  }

  
}
