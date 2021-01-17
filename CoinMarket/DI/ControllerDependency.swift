//
//  ControllerDependency.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 17.01.2021.
//

import Foundation
import Swinject
import SwinjectStoryboard

class ControllerDepedency {
  
  private let container: Container
  
  init(container: Container) {
    self.container = container
  }
  
  func register() {
   
    container.storyboardInitCompleted(CryptocurrencyListViewController.self) { resolver, controller in
      guard let endpoint = resolver.resolve(EndpointProxy.self) else {
        fatalError("endpoint not found")
      }

      guard let imageProvider = resolver.resolve(CryptocurencyImageProvider.self) else {
        fatalError("imageProvider not found")
      }
      controller.viewModel = CryptocurrencyListViewModel(endpoint: endpoint, imageProvider: imageProvider)
    }
    
  }
}
