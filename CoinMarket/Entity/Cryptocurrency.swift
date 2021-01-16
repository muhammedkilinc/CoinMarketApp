//
//  Cryptocurrency.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import Foundation

struct Cryptocurrency: Codable {
  let id: Int
  let name: String?
  let symbol: String?
  let slug: String?
  let cmcRank: Int?
  let lastUpdated: String?
  let dateAdded: String?
  let tags: [String]?
  let platform: Platform?
  let quote: [String: Quote]?
  let circulatingSupply: Double?
  let totalSupply: Double?
  let maxSupply: Double?
  
  private enum CodingKeys: String, CodingKey {
    case id, name, symbol, slug, tags, platform, quote
    case cmcRank = "cmc_rank"
    case lastUpdated = "last_updated"
    case dateAdded = "date_added"
    case circulatingSupply = "circulating_supply"
    case totalSupply = "total_supply"
    case maxSupply = "max_supply"
  }
}

extension Cryptocurrency {
  var formattedPrice: String {
    guard let quote = quote, let item = quote.first else {
      return String.empty
    }
    let formatter = NumberFormatter.currencyFormatter
    formatter.currencyCode = item.key
    let price = formatter.string(from: NSNumber(value: item.value.price ?? 0.0))
    return price ?? .empty
  }
  
  var percentChange24h: Double {
    guard let quote = quote, let item = quote.first else {
      return 0
    }
    return item.value.percentChange24h ?? 0.0
  }
}

