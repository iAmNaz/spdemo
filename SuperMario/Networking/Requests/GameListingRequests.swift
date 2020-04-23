//
//  SubBillerRequest.swift
//  SuperMario
//
//  Created by Nazario Mariano on 3/23/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
import Combine
import os

/**
 A concrete type made specifically for the Series collection
 */
struct GameListingRequests {

    /// A get request of all Game Series
    mutating func fetchSeries() -> AnyPublisher<[Series], APIError> {
        let resource = Resource(url: Endpoint.root.url!)
        let client = APIClient<GameListResult>()
        
        os_log("Fetching series - %{PRIVATE}@", log: apiLog, type: .info, resource.url.absoluteString)
        
        return client.loadDecodable(resource, body: Body(route: .getSeries))
            .receive(on: DispatchQueue.main)
            .map { return $0.series }
            .eraseToAnyPublisher()
    }
    
    
}
