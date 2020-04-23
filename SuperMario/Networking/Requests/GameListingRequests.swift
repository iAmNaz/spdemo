//
//  SubBillerRequest.swift
//  SuperMario
//
//  Created by Nazario Mariano on 3/23/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
import Alamofire
import Combine
import os

/// This is the protocol for the game listing related requests
public protocol GameListing {
    
    /// A get request of all Game Series
    /// - Returns: `AnyPublisher<[Series], AFError>`
    mutating func fetchSeries() -> AnyPublisher<[Series], AFError>
}
/**
 A concrete type made specifically for the Series collection
 */
struct GameListingRequests: GameListing {

    mutating func fetchSeries() -> AnyPublisher<[Series], AFError> {
        let resource = Resource(url: Endpoint.root.url!)
        let client = APIClient<GameListResult>()
        
        os_log("Fetching series - %{PRIVATE}@", log: apiLog, type: .info, resource.url.absoluteString)
        
        return client.loadDecodable(resource, body: Body(route: .getSeries))
            .receive(on: DispatchQueue.main)
            .map { return $0.series }
            .eraseToAnyPublisher()
    }
}
