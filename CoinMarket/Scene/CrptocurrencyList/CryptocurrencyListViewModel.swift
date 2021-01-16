//
//  CryptocurrencyListViewModel.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import Foundation
import RxSwift
import RxCocoa

class CryptocurrencyListViewModel: ViewModelType {
  
  private let navigator: CryptocurrencyListNavigator
  private let endpoint: EndpointProxy
  
  let imageProvider: CryptocurencyImageProvider

  private let disposeBag: DisposeBag = DisposeBag()
  
  private let loadingRelay: PublishRelay<Bool> = PublishRelay()
  private let infoRelay: PublishRelay<String?> = PublishRelay()
  private let responseRelay: BehaviorRelay<[Cryptocurrency]> = BehaviorRelay(value: [])
  
  
  private var start: Int = 1
  private var limit: Int = 20
  private var isLoadMore: Bool = false
    
  struct Input {
    let willAppear: Observable<Void>
    let pullToRefresh: Observable<Void>
    let loadMore: Observable<Void>
    let selection: Observable<CryptocurrencyItemViewModel>
  }
  
  struct Output {
    let items: Observable<[Cryptocurrency]>
    let loading: Observable<Bool>
    var info: Observable<String?>
  }
  
  init(endpoint: EndpointProxy, navigator: CryptocurrencyListNavigator, imageProvider: CryptocurencyImageProvider) {
    self.endpoint = endpoint
    self.navigator = navigator
    self.imageProvider = imageProvider
  }
  
  func transform(input: Input) -> Output {
    
    let willAppearRequest = input.willAppear
      .do(onNext: { _ in
        self.start = 1
        self.responseRelay.accept([])
      })
      .map { _ in
        return CryptocurrencyListRequest(start: self.start, limit: self.limit, cryptocurrencyType: .all)
      }
    
    let refreshRequest = input.pullToRefresh
      .do(onNext: { _ in
        self.start = 1
        self.responseRelay.accept([])
      })
      .map { _ in
        return CryptocurrencyListRequest(start: self.start, limit: self.limit, cryptocurrencyType: .all)
      }
    
    let loadMoreRequest = input.loadMore
      .filter { _ in
        return self.responseRelay.value.count < self.start && !self.isLoadMore
      }
      .do(onNext: { _ in
        self.isLoadMore = true
        self.start += self.limit
      })
      .map { _ in
        return CryptocurrencyListRequest(start: self.start, limit: self.limit, cryptocurrencyType: .all)
      }
    
    let networkSource = Observable.merge(willAppearRequest, refreshRequest, loadMoreRequest)
      .flatMapLatest { (request) -> Observable<Resource<[Cryptocurrency]>> in
        return self.endpoint.cryptocurrencyLatest(request: request)
      }.do(onNext: { _ in
        self.loadingRelay.accept(true)
      })
    
    let responseSource = networkSource
      .delay(.seconds(1), scheduler: MainScheduler.instance)
      .map { resource -> [Cryptocurrency] in
        switch resource {
        case .success(let items, _):
          if let items = items {
            return self.responseRelay.value + items
          }
        case .failure(_, let message):
          self.infoRelay.accept(message)
          return []
        }
        return []
      }.do(onNext: { data in
        self.isLoadMore = false
        self.loadingRelay.accept(false)
        self.start += self.limit
      })
    
    
    responseSource.bind(to: responseRelay)
      .disposed(by: disposeBag)
    
    input.selection
      .subscribe(onNext: { viewModel in
        self.navigator.toDetail(item: viewModel.item)
      })
      .disposed(by: disposeBag)
    
    return Output(items: responseRelay.asObservable(),
                  loading: loadingRelay.asObservable(),
                  info: infoRelay.asObservable())
    
  }
  
}

enum FetchError: Error {
  case general
}
