//
//  PoisTableViewCellViewModel.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation
import UIKit

class PoisTableViewCellViewModel: NSObject {
    
    var image: UIImage?
    var titleString: String
    var subtitleString: String
    var ratingString: String
    var distanceString: String
    
    init(poi: Poi) {
        titleString = poi.name
        subtitleString = poi.snippet
        ratingString = "\(poi.score.rounded(to: 2))/10"
        distanceString = "\(poi.distance)m"
    }
    
}
