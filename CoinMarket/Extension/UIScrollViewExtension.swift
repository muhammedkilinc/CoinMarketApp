//
//  UIScrollViewExtension.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 16.01.2021.
//

import UIKit
import RxSwift

//https://gist.github.com/brocoo/aaabf12c6c2b13d292f43c971ab91dfa
extension Reactive where Base: UIScrollView {
  public var reachedBottom: Observable<Void> {
    let scrollView = self.base as UIScrollView
    return self.contentOffset.flatMap{ [weak scrollView] (contentOffset) -> Observable<Void> in
      guard let scrollView = scrollView else { return Observable.empty() }
      let visibleHeight = scrollView.frame.height - self.base.contentInset.top - scrollView.contentInset.bottom
      let y = contentOffset.y + scrollView.contentInset.top
      let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
      return (y > threshold - (threshold / 4)) ? Observable.just(()) : Observable.empty()
    }
  }
}

