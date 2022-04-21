//
//  TagCollectionViewCellViewModel.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation

class TagCollectionViewCellViewModel {
    
    var cellResetState: (() -> ())?
    
    var titleString: String
    var isSelected = false
    
    init(tag: Tag) {
        titleString = tag.name
    }
    
}
