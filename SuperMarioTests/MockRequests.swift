//
//  MockRequests.swift
//  SuperMarioTests
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
import SuperMario
import Combine
import Alamofire

class MockRequests: GameListing {
    var mockSuccess = true
    func fetchSeries() -> AnyPublisher<[Series], AFError> {
        return Future { promise in
            if self.mockSuccess {
                let series = Series(name: "", gameSeries: "", image: "")
                promise(.success([series]))
            } else {
                let error = AFError.explicitlyCancelled
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    
}
