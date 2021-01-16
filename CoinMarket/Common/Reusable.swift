//
//  Reusable.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import UIKit

protocol Reusable {
  static var reuseID: String {get}
}

extension Reusable {
  static var reuseID: String {
    return String(describing: self)
  }
}

extension UITableViewCell: Reusable {}

extension UICollectionViewCell {}

extension UICollectionReusableView: Reusable {}

extension UIViewController: Reusable {}

extension UITableView {
  func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UITableViewCell {
    guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseID,
                                         for: indexPath) as? T else {
      fatalError()
    }
    return cell
  }
  
  func register<T>(type: T.Type) where T: UITableViewCell {
    register(UINib(nibName: T.reuseID, bundle: Bundle.main), forCellReuseIdentifier: T.reuseID)
  }
}

extension UICollectionView {
  func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UICollectionViewCell {
    guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseID,
                                         for: indexPath) as? T else {
      fatalError()
    }
    return cell
  }
  
  func register<T>(type: T.Type) where T: UICollectionViewCell {
    register(UINib(nibName: T.reuseID, bundle: Bundle.main), forCellWithReuseIdentifier: T.reuseID)
  }
  
  func registerSupplementaryView<T>(_: T.Type, ofKind kind: String)  where T: UICollectionReusableView {
    register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseID)
  }
  
  func registerSupplementaryViewFromNib<T>(_: T.Type, ofKind kind: String) where T: UICollectionReusableView {
    let bundle = Bundle(for: T.self)
    let nib = UINib(nibName: T.reuseID, bundle: bundle)
    register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseID)
  }
  
  func dequeueSupplementaryView<T>(ofKind kind: String, `for` indexPath: IndexPath) -> T where T: UICollectionReusableView {
    guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseID, for: indexPath) as? T else {
      fatalError("Could not dequeue supplementary view of kind: \(kind) with identifier: \(T.reuseID)")
    }
    return view
  }
}

extension UIStoryboard {
  func instantiateViewController<T>(ofType type: T.Type = T.self) -> T where T: UIViewController {
    guard let viewController = instantiateViewController(withIdentifier: type.reuseID) as? T else {
      fatalError()
    }
    return viewController
  }
}

extension UIViewController {
  static func loadFromNib() -> Self {
    func instantiateFromNib<T: UIViewController>() -> T {
      return T.init(nibName: T.reuseID, bundle: nil)
    }
    
    return instantiateFromNib()
  }
}
