//
//  Platform.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import Foundation

struct Platform: Codable {
  let id: Int
  let name: String
  let symbol: String
  let slug: String
  let token_address: String
}
