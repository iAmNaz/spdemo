//
//  File.swift
//  SuperMario
//
//  Created by Nazario Mariano on 3/23/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation

protocol HandlerStore {
    associatedtype Success
    associatedtype Failure
    func success(_ block: Success) -> Self
    func failure(_ block: Failure) -> Self
}

class ResultHandler<T, E>: HandlerStore {
    enum Result {
        case Failure(E)
        case Success(T)
    }

    typealias SuccessBlock = (T) -> Void
    typealias FailureBlock = (E) -> Void
   
    private var _success: SuccessBlock
    private var _failure: FailureBlock
   
    init() {
       _success = { _ in }
       _failure = { _ in }
    }

    @discardableResult
    func success(_ block: @escaping SuccessBlock) -> Self {
       _success = block
       return self
    }

    @discardableResult
    func failure(_ block: @escaping FailureBlock) -> Self {
       _failure = block
       return self
    }
    
    func runBlocks(result: Result) {
        switch result {
        case .Success(let output):
            self._success(output)
        case .Failure(let error):
            self._failure(error)
        }
    }
}
