//
//  CryptocurrencyCellViewModel.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import Foundation

enum PercentChangeType {
  case up, down, equal
}

class CryptocurrencyItemViewModel {
  let item: Cryptocurrency
  
  let name: String
  let price: String
  let number: String
  let symbol: String
  let percentChange: PercentChangeType
  let imageURL: URL?

  init (with item: Cryptocurrency, imageProvider: CryptocurencyImageProvider) {
    self.item = item
    
    self.name = item.name ?? String.empty
    self.number = "\(item.id)"
    self.price = item.formattedPrice
    self.symbol = item.symbol ?? String.empty
  
    if item.percentChange24h > 0  {
      percentChange = .up
    } else if item.percentChange24h < 0  {
      percentChange = .down
    } else {
      percentChange = .equal
    }
    
    imageURL = imageProvider.imageURL(from: item.id)    
  }
}
