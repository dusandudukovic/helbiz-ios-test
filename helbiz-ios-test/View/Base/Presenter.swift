//
//  Presenter.swift
//  StarterTemplate-core
//
//  Created by Dusan on 23.2.22..
//

import Foundation

protocol Presenter {
    var showAlert: ((String) -> ())? { get set }
    var showError: ((String) -> ())? { get set }
}
