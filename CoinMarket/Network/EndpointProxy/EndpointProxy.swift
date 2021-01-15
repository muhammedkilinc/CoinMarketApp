//
//  EndpointProxy.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import Foundation
import RxSwift

protocol EndpointProxy {
  
  func cryptocurrencyLatest(request: CryptocurrencyListRequest) -> Observable<Resource<[Cryptocurrency]>>
  func cryptocurrencyInfo(request: CryptocurrencyInfoRequest) -> Observable<Resource<[String: CryptocurrencyDetail]>>

}
