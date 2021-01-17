//
//  Quote.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import Foundation

struct Quote: Codable {
  let price: Double?
  let volume24h: Double?
  let percentChange1h: Double?
  let percentChange24h: Double?
  let percentChange7d: Double?
  let marketCap: Double?
  let lastUpdated: String?
  
  private enum CodingKeys: String, CodingKey {
    case price
    case volume24h = "volume_24h"
    case percentChange1h = "percent_change_1h"
    case percentChange24h = "percent_change_24h"
    case percentChange7d = "percent_change_7d"
    case marketCap = "market_cap"
    case lastUpdated = "last_updated"
  }
}
