//
//  UIViewControllerExtension.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 17.01.2021.
//

import UIKit
import SwinjectStoryboard
import Swinject

extension UIStoryboard {
  static func storyboard(name: String = "Main") -> SwinjectStoryboard {
    return SwinjectStoryboard.create(name: name, bundle: Bundle.main, container: Application.shared.container)
  }
//
//  static func instantiateFromStoryboardHelper<T>(_ name: String = "Main", type: T.Type) -> T {
//    let storyboard = self.storyboard(name: name)
//    let identifier = String(describing: type)
//    let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! T
//    return controller
//  }
}

extension UIViewController {
  static func loadFromStoryboard<T: UIViewController>(_ name: String = "Main") -> T {
    let storyboard = UIStoryboard.storyboard(name: name)
    let controller = storyboard.instantiateViewController(withIdentifier: T.reuseID) as! T
    return controller
  }
}
