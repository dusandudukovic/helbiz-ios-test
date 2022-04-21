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
    var viewModels = [TagCollectionViewCellViewModel]()
    var selectedIndex: Int?
    
    func setup(tags: [Tag]) {
        viewModels.removeAll()
        self.tags = tags
        
        for tag in tags {
            viewModels.append(TagCollectionViewCellViewModel(tag: tag))
        }
        
        reloadData?()
    }
    
    func resetStates() {
        viewModels.forEach { viewModel in
            viewModel.cellResetState?()
        }
    }
    
}

extension TagsViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier,
                                                         for: indexPath) as? TagCollectionViewCell {
            cell.setup(with: viewModels[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell {
            viewModels[indexPath.row].isSelected = true
            cell.selectCell()
            
            if let previouslySelected = selectedIndex {
                viewModels[previouslySelected].isSelected = false
                viewModels[previouslySelected].cellResetState?()
            }
            selectedIndex = indexPath.row
        }
        
        let tag = tags[indexPath.row]
        collectionView.isUserInteractionEnabled = false
        tagSelected?(tag)
    }
    
}
