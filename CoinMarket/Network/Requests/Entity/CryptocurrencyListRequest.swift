//
//  CryptocurrencyListRequest.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 14.01.2021.
//

import Foundation

struct CryptocurrencyListRequest: Encodable {
  let start: Int
  let limit: Int
  let cryptocurrencyType: CryptocurrencyType
  
  private enum CodingKeys: String, CodingKey {
    case start
    case limit
    case cryptocurrencyType = "cryptocurrency_type"
  }
}
