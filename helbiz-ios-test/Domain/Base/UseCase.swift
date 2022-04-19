//
//  UseCase.swift
//  StarterTemplate-core
//
//  Created by Dusan on 23.2.22..
//

import Foundation

enum UseCaseResult<SuccessData, FailureData> {
    case success(_ data: SuccessData)
    case failure(_ data: FailureData)
}

protocol UseCase {
    associatedtype SuccessData
    associatedtype FailureData
    
    func execute(completion: ((UseCaseResult<SuccessData, FailureData>) -> Void)?)
}
