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
    var viewModels = [PoisTableViewCellViewModel]()
    
    func setup(pois: [Poi]) {
        self.pois = pois
        viewModels.removeAll()
        for poi in pois {
            viewModels.append(PoisTableViewCellViewModel(poi: poi))
        }
        
        reloadData?()
    }

}

extension PoisViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PoisTableViewCell.identifier,
                                                    for: indexPath) as? PoisTableViewCell {
            cell.setup(with: viewModels[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let poi = pois[indexPath.row]
        poiSelected?(poi)
    }
    
}
