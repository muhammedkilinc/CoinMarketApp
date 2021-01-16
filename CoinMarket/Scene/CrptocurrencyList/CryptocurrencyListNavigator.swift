//
//  CryptocurrencyListNavigator.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import UIKit

protocol CryptocurrencyListNavigator {
  func toCryptocurrencyList()
  func toDetail(item: Cryptocurrency)
}

class CryptocurrencyListNavigatorImp: CryptocurrencyListNavigator {
  
  private let storyboard: UIStoryboard
  private let navigationController: UINavigationController
  private let endpoint: Endpoint
  private let proxy: EndpointProxy
  private let imageProvider: CryptocurencyImageProvider

  init(storyboard: UIStoryboard,
       endpoint: Endpoint,
       navigationController: UINavigationController,
       imageProvider: CryptocurencyImageProvider) {
    self.storyboard = storyboard
    self.endpoint = endpoint
    self.navigationController = navigationController
    self.proxy = EndpointProxyImp(endpoint: endpoint)
    self.imageProvider = imageProvider
  }
  
  func toCryptocurrencyList() {
    let vc = storyboard.instantiateViewController(ofType: CryptocurrencyListViewController.self)
    vc.viewModel = CryptocurrencyListViewModel(endpoint: proxy, navigator: self, imageProvider: imageProvider)
    navigationController.pushViewController(vc, animated: true)
  }
  
  func toDetail(item: Cryptocurrency) {

  }
}
