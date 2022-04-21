//
//  TagCollectionViewCell.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation
import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetState()
    }
    
    func setup(with viewModel: TagCollectionViewCellViewModel) {
        titleLabel.text = viewModel.titleString
        if viewModel.isSelected {
            selectCell()
        }
        
        viewModel.cellResetState = { [weak self] in
            self?.resetState()
        }
        
        resetState()
    }
    
    func resetState() {
        titleLabel.textColor = .white
        borderColor = .white
        iconImage.tintColor = .white
    }
    
    func selectCell() {
        let actionColor = UIColor(named: "Action")!
        layer.bounceOnce(duration: 0.1, scale: 1.1)
        titleLabel.textColor = actionColor
        borderColor = actionColor
        iconImage.tintColor = actionColor
    }
    
}
