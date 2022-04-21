//
//  PoisTableViewCell.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation
import UIKit
import SDWebImage

class PoisTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func setup(with viewModel: PoisTableViewCellViewModel) {
        nameLabel.text = viewModel.titleString
        subtitleLabel.text = viewModel.subtitleString
        ratingLabel.text = viewModel.ratingString
        distanceLabel.text = viewModel.distanceString
        
        if let url = viewModel.thumbnailImageUrl {
            thumbnailImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "icon-image"))
        }
        
    }
    
}
