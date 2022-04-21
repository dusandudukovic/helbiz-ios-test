//
//  PoisView.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation
import UIKit

class PoisView: ViewWithNib {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setup(with viewModel: PoisViewModel?) {
        guard let viewModel = viewModel else { return }
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        
        subtitleLabel.isHidden = !viewModel.pois.isEmpty
        
        viewModel.reloadData = { [weak self] in
            self?.tableView.reloadData()
            self?.subtitleLabel.isHidden = !viewModel.pois.isEmpty
        }
    }
    
    func setup() {
        tableView.backgroundColor = .clear
        tableView.backgroundView?.backgroundColor = .clear
        tableView.register(PoisTableViewCell.nib, forCellReuseIdentifier: PoisTableViewCell.identifier)
    }
    
}
