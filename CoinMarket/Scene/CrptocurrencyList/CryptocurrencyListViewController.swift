//
//  CryptocurrencyListViewController.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

class CryptocurrencyListViewController: UIViewController {
  
  private let disposeBag = DisposeBag()
  
  var viewModel: CryptocurrencyListViewModel!
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var infoLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  let refreshControl = UIRefreshControl()
    
  private let pullToRefreshRelay: PublishRelay<Void> = PublishRelay()
  private let viewWillAppearRelay: PublishRelay<Void> = PublishRelay()
  private let loadMoreRelay: PublishRelay<Void> = PublishRelay()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  func setupUI() {
    title = Constants.Screen.CryptocurrencyListTitle
    
    infoLabel.isHidden = true
    infoLabel.text = String.empty
    
    configureTableView()
    bindViewModel()
  }
  
  private func configureTableView() {
    tableView.register(type: CryptocurrencyTableViewCell.self)
    tableView.refreshControl = refreshControl
    tableView.rowHeight = UITableView.automaticDimension
    tableView.tableFooterView = UIView()
  }
  
  private func bindViewModel() {
    assert(viewModel != nil)
    
    rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
      .mapToVoid()
      .bind(to: viewWillAppearRelay)
      .disposed(by: disposeBag)
    
    refreshControl.rx
      .controlEvent(.valueChanged)
      .filter { self.refreshControl.isRefreshing }
      .bind(to: pullToRefreshRelay)
      .disposed(by: disposeBag)
    
    tableView.rx
      .reachedBottom
      .bind(to: loadMoreRelay)
      .disposed(by: disposeBag)

    tableView.rx.modelSelected(CryptocurrencyItemViewModel.self)
      .subscribe(onNext: { viewModel in
        let viewController = CryptocurrencyDetailViewController.loadFromStoryboard()
        viewController.viewModel.cryptocurrency = viewModel.item
        self.navigationController?.pushViewController(viewController, animated: true)
      })
      .disposed(by: disposeBag)
    
    let input = CryptocurrencyListViewModel.Input(willAppear: viewWillAppearRelay.asObservable(),
                                                  pullToRefresh: pullToRefreshRelay.asObservable(),
                                                  loadMore: loadMoreRelay.asObservable())
    
    let output = viewModel.transform(input: input)
    
    output.items.map { items in
      return items.map { item in
        return CryptocurrencyItemViewModel(with: item, imageProvider: self.viewModel.imageProvider)
      }
    }.bind(to: tableView.rx.items(cellIdentifier: CryptocurrencyTableViewCell.reuseID, cellType: CryptocurrencyTableViewCell.self)) { index, viewModel, cell in
      cell.bind(viewModel)
    }
    .disposed(by: disposeBag)
    
    
    output.loading
      .bind(to: refreshControl.rx.isRefreshing)
      .disposed(by: disposeBag)
    
    output.loading
      .bind(to: activityIndicator.rx.isAnimating)
      .disposed(by: disposeBag)

    output.info.subscribe(onNext: { info in
      self.infoLabel.isHidden = (info == nil)
      self.infoLabel.text = info
    })
    .disposed(by: disposeBag)

    pullToRefreshRelay.accept(())
  }
}
