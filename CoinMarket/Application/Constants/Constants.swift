//
//  Constants.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 13.01.2021.
//

import Foundation

struct Constants {
  
  struct API {
    static let BaseURL = "https://pro-api.coinmarketcap.com"
    static let APIKey = "b31c7513-d12a-4005-82a6-c5c5d0fdb9d5"
    static let APIVersion = "/v1"
    static let HeaderAuth = "X-CMC_PRO_API_KEY"
    static let imageURL = "https://s2.coinmarketcap.com/static/img/coins/64x64/"
  }
  
  struct Screen {
    static let CryptocurrencyListTitle = "Cryptocurrency"
  }
  
  struct Messages {
    static let DataNotFound = "No Results"
  }

  
}
