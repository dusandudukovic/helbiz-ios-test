//
//  HomeViewController.swift
//  StarterTemplate-core
//
//  Created by Dusan on 14.3.22..
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tagsView: TagsView!
    @IBOutlet weak var poisView: PoisView!
    
    var style: Style?
    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupCallbacks()
        
        presenter?.startTracking()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.tagsViewModel.resetStates()
        tagsView.collectionView.isUserInteractionEnabled = true
    }
    
    func setupViews() {
        tagsView.setup(with: presenter?.tagsViewModel)
    }
    
    func setupCallbacks() {
        presenter?.authorizationGranted = { [weak self] bool in
            guard let `self` = self else { return }
            if bool { return }
            self.showAlert(title: "Tracking not allowed",
                           message: "Please allow sharing device location in Settings to use this app.",
                           buttonTitle: "Go to Settings", showCancel: true) { action in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
        }
        
        presenter?.onGetPOIsByTagSuccess = { [weak self] pois in
            print("DD:")
            print(pois)
        }
    }
}
