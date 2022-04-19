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

typealias Generic_Callback<Result> = (_ handler: Result) -> Void

protocol UseCase {
    associatedtype SuccessData
    associatedtype FailureData
    typealias Result = UseCaseResult<SuccessData, FailureData>
    
    func execute(completion: ((Result) -> Void)?)
}
