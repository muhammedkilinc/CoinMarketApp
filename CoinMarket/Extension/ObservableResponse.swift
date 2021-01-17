//
//  ObservableResponse.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
  
  func applyResource<T>() -> Observable<Resource<T>> where Response<T> == Element {
    return self.map { response in
      if response.status?.errorCode ?? -1 > 0 {
        return .failure(response.status?.errorCode, response.status?.errorMessage)
      }
      return .success(response.data, response.status?.errorCode)
    }
  }
}

extension ObservableType {
  
  func catchErrorJustComplete() -> Observable<Element> {
    return `catch` { _ in
      return Observable.empty()
    }
  }
  
  func asDriverOnErrorJustComplete() -> Driver<Element> {
    return asDriver { error in
      assertionFailure("Error \(error)")
      return Driver.empty()
    }
  }
  
  func mapToVoid() -> Observable<Void> {
    return map { _ in }
  }
}
