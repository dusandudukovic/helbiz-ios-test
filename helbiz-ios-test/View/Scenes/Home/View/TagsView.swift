//
//  TagsView.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation
import UIKit

class TagsView: ViewWithNib {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(with viewModel: TagsViewModel?) {
        guard let viewModel = viewModel else { return }
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func setup() {
        collectionView.backgroundColor = .clear
        collectionView.backgroundView?.backgroundColor = .clear
        collectionView.clipsToBounds = false
        collectionView.register(TagCollectionViewCell.nib, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
    }
    
}
