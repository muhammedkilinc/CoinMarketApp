//
//  URLRequestExtension.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 13.01.2021.
//

import Foundation
import Alamofire
import RxSwift

extension URLRequest {
  
  func perform<T>() -> Observable<T> where T: Decodable {
    return AF.request(self).seralize().debug()
  }
  
}
