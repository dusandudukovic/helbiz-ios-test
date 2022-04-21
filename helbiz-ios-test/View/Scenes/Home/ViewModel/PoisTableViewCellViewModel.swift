//
//  PoisTableViewCellViewModel.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation

class PoisTableViewCellViewModel: NSObject {
    
    var thumbnailImageUrl: String?
    var titleString: String
    var subtitleString: String
    var ratingString: String
    var distanceString: String
    
    init(poi: Poi) {
        if poi.images.count > 0 {
            thumbnailImageUrl = poi.images[0].sizes.thumbnail.url
        }
        
        titleString = poi.name
        subtitleString = poi.snippet
        ratingString = "\(poi.score.rounded(to: 2))/10"
        distanceString = "\(poi.distance)m"
    }
    
}
