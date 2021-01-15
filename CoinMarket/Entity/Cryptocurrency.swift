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

