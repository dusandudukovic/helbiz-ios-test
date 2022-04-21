//
//  PoiDetailsViewController.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation
import UIKit

class PoiDetailsViewController: BaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
    var poi: Poi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        setup()
    }
    
    func setup() {
        guard let poi = poi else { return }
        if poi.images.count > 0 {
            let url = poi.images[0].sizes.medium.url
            imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "icon-image"))
        }
        
        title = poi.name
        ratingLabel.text = "\(poi.score.rounded(to: 2))/10"
        distanceLabel.text = "\(poi.distance)m"
        subtitleLabel.text = poi.snippet
        introLabel.text = poi.intro
    }
    
}
