//
//  Resource.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import Foundation

enum Resource<T>: CustomStringConvertible {
  case success(T?, Int?)
  case failure(Int?, String?)
  
  var description: String {
    get {
      switch self {
      case .success(let data, let code):
        guard let data = data else {
          return "code: \(code ?? -1)"
        }
        return "code: \(code ?? -1) data: \(data)"
      case .failure(let code, let message):
        guard let messageFriendly = message else {
          return "code: \(code ?? -1)"
        }
        return "code: \(code ?? -1) messageFriendly: \(messageFriendly)"
      }
    }
  }
}
