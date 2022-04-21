//
//  TagCollectionViewCell.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation
import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
    }
    
}
