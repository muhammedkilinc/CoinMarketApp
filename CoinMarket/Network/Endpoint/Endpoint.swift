//
//  Endpoint.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import Foundation
import RxSwift

protocol Endpoint{
  
  func cryptocurrencyLatest(request: CryptocurrencyListRequest) -> Observable<Response<[Cryptocurrency]>>
  func cryptocurrencyInfo(request: CryptocurrencyInfoRequest) -> Observable<Response<[String: CryptocurrencyDetail]>>

}
