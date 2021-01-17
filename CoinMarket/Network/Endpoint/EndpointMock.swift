//
//  EndpointMock.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 17.01.2021.
//

import Foundation
import RxSwift

class EndpointMock: Endpoint {
  
  private let mockServer = MockServer()

  func cryptocurrencyLatest(request: CryptocurrencyListRequest) -> Observable<Response<[Cryptocurrency]>> {
    let mockServerRef = self.mockServer

    return Observable.create { emitter in
      
      if let response = mockServerRef.loadJson(filename: "cryptocurrency_latest_mock", type: Response<[Cryptocurrency]>.self) {
        emitter.onNext(response)
        emitter.onCompleted()
      }
      
      return Disposables.create()
    }
  }
  
  func cryptocurrencyInfo(request: CryptocurrencyInfoRequest) -> Observable<Response<[String : CryptocurrencyDetail]>> {
    let mockServerRef = self.mockServer

    return Observable.create { emitter in
     
      if let response = mockServerRef.loadJson(filename: "crypto_currency_info_mock", type: Response<[String : CryptocurrencyDetail]>.self) {
        emitter.onNext(response)
        emitter.onCompleted()
      }
      
      return Disposables.create()
    }
  }
  
}

