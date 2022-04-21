//
//  PoisViewModel.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation
import UIKit

class PoisViewModel: NSObject {
    
    var reloadData: (() -> ())?
    var poiSelected: ((Poi) -> ())?
    
    var pois = [Poi]()
    
    func setup(pois: [Poi]) {
        self.pois = pois
        reloadData?()
    }

}

extension PoisViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let poi = pois[indexPath.row]
        poiSelected?(poi)
    }
    
}
