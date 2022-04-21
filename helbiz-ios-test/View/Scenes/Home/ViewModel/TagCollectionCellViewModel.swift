//
//  TagCollectionCellViewModel.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation

class TagCollectionCellViewModel {
    
    var cellResetState: (() -> ())?
    
    var titleLabelText: String
    var isSelected = false
    
    init(tag: Tag) {
        titleLabelText = tag.name
    }
    
}
