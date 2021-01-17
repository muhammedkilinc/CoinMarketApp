//
//  CryptocurrencyTableViewCell.swift
//  CoinMarket
//
//  Created by Muhammed Kılınç on 15.01.2021.
//

import UIKit
import Kingfisher

class CryptocurrencyTableViewCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var imgView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func bind(_ viewModel: CryptocurrencyItemViewModel) {
    nameLabel.text = viewModel.name
    numberLabel.text = viewModel.number
    priceLabel.text = viewModel.price
    symbolLabel.text = viewModel.symbol
    if viewModel.percentChange == .up {
      priceLabel.textColor = Style.Colors.green
    } else if viewModel.percentChange == .down {
      priceLabel.textColor = Style.Colors.red
    } else {
      priceLabel.textColor = Style.Colors.gray
    }
    imgView.kf.setImage(with: viewModel.imageURL)
    
  }
    
}
