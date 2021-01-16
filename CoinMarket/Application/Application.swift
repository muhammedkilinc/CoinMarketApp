//
//  Application.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import UIKit

class Application {
  static let shared = Application()
  
  private let endpoint: Endpoint
  private let imageProvider: CryptocurencyImageProvider

  private init() {
    self.endpoint = EndpointImp()
    self.imageProvider = CryptocurencyImageProvider(baseUrl: Constants.API.imageURL)
  }
  
  func configureMainInterface(in window: UIWindow) {
    let networkNavigationController = UINavigationController()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let networkNavigator = CryptocurrencyListNavigatorImp(storyboard: storyboard,
                                                          endpoint: self.endpoint,
                                                          navigationController: networkNavigationController,
                                                          imageProvider: imageProvider)
    
    window.rootViewController = networkNavigationController
    
    networkNavigator.toCryptocurrencyList()
  }
  
}
