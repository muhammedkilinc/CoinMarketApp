//
//  NumberFormatter.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 16.01.2021.
//

import Foundation

extension NumberFormatter {
 
  static var currencyFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter
  }
  
}
