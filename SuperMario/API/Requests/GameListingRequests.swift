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

struct GameListingRequests {

    mutating func fetchGames() -> AnyPublisher<[Series], APIError> {
        let resource = Resource(url: Endpoint.root.url!)
        let client = APIClient<GameListResult>()
        
        os_log("Fetching series - %{PRIVATE}@", log: apiLog, type: .info, resource.url.absoluteString)
        
        return client.loadDecodable(resource, body: Body(route: .getGames))
            .receive(on: DispatchQueue.main)
            .map { return $0.series }
            .eraseToAnyPublisher()
    }
}
