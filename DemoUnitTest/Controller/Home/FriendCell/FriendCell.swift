//
//  HomeCell.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/27/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import UIKit
import SDWebImage
import Async

class HomeCell: UITableViewCell {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var borderView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!

    var viewModel: HomeCellViewModel? {
        didSet {
            guard viewModel != nil else { return }
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        configUI()
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        distanceLabel.text = viewModel.distance
        locationLabel.text = viewModel.location
//        Async.main {
//            self.imageView?.sd_setImage(with: viewModel.imageURL, completed: { [weak self] (image, error, type, nil) in
//                guard let this = self else { return }
//                this.imageView?.image = image
//            })
//        }
    }

    private func configUI() {
        borderView.layer.cornerRadius = 20
        borderView.layer.masksToBounds = true
        borderView.border(color: Define.borderColor, width: Define.borderWidth)

        avatarImageView.layer.cornerRadius = 19
        avatarImageView.layer.masksToBounds = true
    }
}

// MARK: - Defination
extension HomeCell {

    struct Define {
        static let borderColor: UIColor = UIColor(red: 1, green: 0.599, blue: 0.229, alpha: 1)
        static let borderWidth: CGFloat = 1.5
    }
}
