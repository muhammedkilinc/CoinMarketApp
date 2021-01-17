//
//  CryptocurrencyDetailViewModel.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 17.01.2021.
//

import Foundation
import RxSwift
import RxCocoa

class CryptocurrencyDetailViewModel: ViewModelType {
  
  private let endpoint: EndpointProxy
  var cryptocurrency: Cryptocurrency!
  
  let imageProvider: CryptocurencyImageProvider
  
  private let disposeBag: DisposeBag = DisposeBag()
  
  private let loadingRelay: PublishRelay<Bool> = PublishRelay()
  private let infoRelay: PublishRelay<String?> = PublishRelay()
  private let responseRelay: PublishRelay<CryptocurrencyInfo?> = PublishRelay()
  
  struct Input {
    let willAppear: Observable<Void>
  }
  
  struct Output {
    let detail: Observable<CryptocurrencyInfo?>
    let loading: Observable<Bool>
    var info: Observable<String?>
  }
  
  init(endpoint: EndpointProxy, imageProvider: CryptocurencyImageProvider) {
    self.endpoint = endpoint
    self.imageProvider = imageProvider
  }
  
  func transform(input: Input) -> Output {
    
    let willAppearRequest = input.willAppear
      .do(onNext: { _ in
        //        self.responseRelay.acc)
      })
      .map { _ in
        return CryptocurrencyInfoRequest(id: self.cryptocurrency.id)
      }
    
    let networkSource = willAppearRequest
      .flatMapLatest { (request) -> Observable<Resource<[String: CryptocurrencyDetail]>> in
        return self.endpoint.cryptocurrencyInfo(request: request)
      }.do(onNext: { _ in
        self.loadingRelay.accept(true)
      })
    
    let responseSource = networkSource
//      .delay(.seconds(1), scheduler: MainScheduler.instance)
      .map { resource -> CryptocurrencyInfo? in
        switch resource {
        case .success(let items, _):
          if let items = items {
            return items.compactMap { key, value -> CryptocurrencyInfo? in
              return CryptocurrencyInfo(id: key, detail: value)
            }.first
          }
        case .failure(_, let message):
          self.infoRelay.accept(message)
          return nil
        }
        return nil
      }.do(onNext: { data in
        self.loadingRelay.accept(false)
      })
    
    responseSource.bind(to: responseRelay)
      .disposed(by: disposeBag)
    
    return Output(detail: responseRelay.asObservable(),
                  loading: loadingRelay.asObservable(),
                  info: infoRelay.asObservable())
    
  }
  
}
