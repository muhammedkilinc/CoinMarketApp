//
//  Application.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import UIKit
import Swinject
import SwinjectStoryboard

class Application {
  static let shared = Application()

  var container: Container = {
    let container = Container()
    // initialize singletons
    let singletons = AppDependency(container: container)
    singletons.register()
    // initialize controller
    let controllers = ControllerDepedency(container: container)
    controllers.register()
    return container
  }()
  
  func configureMainInterface(in window: UIWindow) {
    let viewController: CryptocurrencyListViewController = CryptocurrencyListViewController.loadFromStoryboard()
    window.rootViewController = UINavigationController(rootViewController: viewController)
  }
  
}
