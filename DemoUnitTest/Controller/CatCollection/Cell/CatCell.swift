//
//  CatCell.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/10/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import UIKit
import SDWebImage
import Async

class CatCell: UITableViewCell {

    @IBOutlet private weak var catImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var lifeSpanLabel: UILabel!
    @IBOutlet private weak var temperamentLabel: UILabel!

    var viewModel: CatCellViewModel? {
        didSet {
            guard viewModel != nil else { return }
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
//        catImageView.sd_setImage(with: viewModel.imageURL) { [weak self] (image, _, _, _) in
//            guard let this = self else { return }
//            Async.main {
//                this.catImageView.image = image
//            }
//        }
        nameLabel.text = viewModel.name
        lifeSpanLabel.text = viewModel.lifeSpan
        temperamentLabel.text = viewModel.temperament
    }
}
