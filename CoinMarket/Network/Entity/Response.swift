//
//  Response.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 14.01.2021.
//

import Foundation

struct Response<T>: Codable where T: Codable {

  let data: T?
  let status: Status?

  private enum CodingKeys: String, CodingKey {
    case data, status
  }
}

struct Status: Codable {
  let timestamp: String?
  let errorCode: Int?
  let errorMessage: String?
  let elapsed: Int?
  let creditCount: Int?
  
  private enum CodingKeys: String, CodingKey {
    case timestamp, errorCode = "error_code", errorMessage = "error_message", elapsed, creditCount = "credit_count"
  }
}
