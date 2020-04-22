//
//  APILogger.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/2/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
import Alamofire

final class APILogger: EventMonitor {
    let queue = DispatchQueue(label: "api-logging")
    
    // Event called when any type of Request is resumed.
    func requestDidResume(_ request: Request) {
        print("Resuming: \(request)")
    }
    
    // Event called whenever a DataRequest has parsed a response.
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        debugPrint("Finished: \(response)")
    }
}
