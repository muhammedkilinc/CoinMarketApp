//
//  MockServer.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 17.01.2021.
//

import Foundation

class MockServer {
  
  private let decoder = JSONDecoder()
  private let bundle: Bundle
  
  init(bundle: Bundle = Bundle.main) {
    self.bundle = bundle
  }
  
  func loadJson<T: Decodable>(filename fileName: String, type: T.Type) -> T? {
    if let url = bundle.url(forResource: fileName, withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        return try decoder.decode(type, from: data)
      } catch {
        print("Failed parse json \(error.localizedDescription)")
      }
    }
    return nil
  }
}
