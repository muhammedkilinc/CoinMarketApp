//
//  CryptocurrencyImage.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 16.01.2021.
//

import Foundation

class CryptocurencyImageProvider {
  
  private let baseUrl: String
  
  init(baseUrl: String) {
    self.baseUrl = baseUrl
  }
  
  func imageURL(from currencyId: Int) -> URL? {
    return URL(string: "\(baseUrl)\(currencyId).png")
  }
}
