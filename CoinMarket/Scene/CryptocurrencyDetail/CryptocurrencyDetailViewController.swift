//
//  CryptocurrencyDetailViewController.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 17.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

class CryptocurrencyDetailViewController: UIViewController {
  
  private let disposeBag = DisposeBag()
  
  var viewModel: CryptocurrencyDetailViewModel!
  var image: CryptocurrencyDetailViewModel!

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var infoLabel: UILabel!

  private let viewWillAppearRelay: PublishRelay<Void> = PublishRelay()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  func setupUI() {
    title = Constants.Screen.CryptocurrencyListTitle
    
//    infoLabel.isHidden = true
//    infoLabel.text = String.empty
    
    bindViewModel()
  }

  
  private func bindViewModel() {
    assert(viewModel != nil)
    
    rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
      .mapToVoid()
      .bind(to: viewWillAppearRelay)
      .disposed(by: disposeBag)
    
    
    let input = CryptocurrencyDetailViewModel.Input(willAppear: viewWillAppearRelay.asObservable())
    
    let output = viewModel.transform(input: input)
        
    output.info.subscribe(onNext: { info in
//      self.infoLabel.isHidden = (info == nil)
//      self.infoLabel.text = info
    })
    .disposed(by: disposeBag)
    
    output.detail.bind(to: postBinding)
      .disposed(by: disposeBag)
  }
  
  var postBinding: Binder<CryptocurrencyInfo?> {
    return Binder(self, binding: { (vc, content) in
      vc.nameLabel.text = content?.detail.name
      vc.descriptionLabel.text = content?.detail.description
      vc.typeLabel.text = content?.detail.category?.rawValue

      if let url = self.viewModel.imageProvider.imageURL(from: content?.detail.id ?? 0) {
        vc.imageView.kf.setImage(with: url)
      }
    })
  }
}
