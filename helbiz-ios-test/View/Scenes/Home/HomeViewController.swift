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
    @IBOutlet weak var mapView: MapView!
    
    @IBOutlet var tagsLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var poisTopConstraint: NSLayoutConstraint!
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapView.moveCameraToUser()
    }
    
    @IBAction func backTapped() {
        presenter?.loadData()
        tagsLeadingConstraint.isActive = true
        poisTopConstraint.isActive = true
        tagsView.collectionView.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.2, delay: 0, options: []) {
            self.view.layoutIfNeeded()
        } completion: { bool in
            if bool {
                self.mapView.isHidden = true
            }
        }
    }
    
    func setupViews() {
        tagsView.setup(with: presenter?.tagsViewModel)
        poisView.setup(with: presenter?.poisViewModel)
        mapView.setup(with: presenter?.mapViewModel)
        
        poisView.setCornerRadius(30, maskedCornes: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
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
        
        presenter?.onTagSelected = { [weak self] tag in
            
        }
        
        presenter?.onGetPOIsByTagSuccess = { [weak self] pois in
            self?.tagsLeadingConstraint.isActive = false
            self?.poisTopConstraint.isActive = false
            self?.mapView.isHidden = false
            
            UIView.animate(withDuration: 0.2, animations: {
                self?.view.layoutIfNeeded()
            })
        }
    }
}
