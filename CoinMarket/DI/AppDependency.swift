//
//  AppDependency.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 17.01.2021.
//

import Foundation
import Swinject

class AppDependency {
  
  private let container: Container
  
  init(container: Container) {
    self.container = container
  }
  
  func register() {
    // register Endpoint
    container.register(Endpoint.self) { _ in
//      return EndpointMock()
      return EndpointImp()
    }.inObjectScope(.container)

    container.register(CryptocurencyImageProvider.self) { _ in
      return CryptocurencyImageProvider(baseUrl: Constants.API.imageURL)
    }.inObjectScope(.container)

    container.register(EndpointProxy.self) { resolver in
      
      guard let endpoint = resolver.resolve(Endpoint.self) else {
        fatalError("we can not resolve \(Endpoint.self)")
      }
      
      return EndpointProxyImp(endpoint: endpoint)
    }.inObjectScope(.container)
  }
  
}
