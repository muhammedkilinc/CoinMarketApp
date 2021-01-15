//
//  ObservableResponse.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import Foundation
import RxSwift

extension ObservableType {
  
  func applyResource<T>() -> Observable<Resource<T>> where Response<T> == Element {
    return self.map { response in
      if response.status?.errorCode ?? -1 > 0 {
        return .success(response.data, response.status?.errorCode)
      }
      return .failure(response.status?.errorCode, response.status?.errorMessage)
    }
  }
}
