//
//  TagsViewModel.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation
import UIKit

class TagsViewModel: NSObject {
    
    var reloadData: (() -> ())?
    var tagSelected: ((Tag) -> ())?
    
    var tags = [Tag]()
    
    func setup(tags: [Tag]) {
        self.tags = tags
        reloadData?()
    }
    
}

extension TagsViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier,
                                                         for: indexPath) as? TagCollectionViewCell {
            cell.titleLabel.text = tags[indexPath.row].name
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        tagSelected?(tag)
    }
    
}
