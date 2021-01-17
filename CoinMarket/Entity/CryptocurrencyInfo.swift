//
//  CryptocurrencyInfo.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import Foundation

struct CryptocurrencyInfo: Codable {
  var id: String
  var detail: CryptocurrencyDetail
}

enum CryptocurrencyCategory: String, Codable {
  case coin, token
}

struct CryptocurrencyDetail: Codable {
  let id: Int
  let name: String?
  let symbol: String?
  let category: CryptocurrencyCategory?
  let description: String?
  let slug: String?
  let logo: String?
  let tags: [String]?
  let urls: [String: [String]]?
  
  private enum CodingKeys: String, CodingKey {
    case id, name, symbol, slug, description, logo, tags, urls, category
  }
}
