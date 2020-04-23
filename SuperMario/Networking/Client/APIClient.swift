import Foundation
import Combine
import Alamofire
import os

/// The logging category for the API module
let apiLog = OSLog(subsystem: "com.naz.SuperMario", category: "api")

/// Only log when on debuggin mode, i.e. when running via a simulator or test device
#if DEBUG
    var AFSession = Session(eventMonitors: [APILogger()])
#else
    var AFSession = Session()
#endif

/*
 A generic networking interface
 */
final class APIClient<T: Decodable> {
    
    init() {}

    /// A method for fetching data that returns encoded objects
    ///
    /// Use this method when the endpoint returns a valid json formatted response
    /// and encode them to a `Codable` data model
    ///  - Parameter resource: The `Resource` object which has the url and http method
    ///  - Parameter body: The `Body`parameters
    ///  - Returns: A `Future` result of type T or an `AFError`
    func loadDecodable(_ resource: Resource, body: Body) -> Future<T, AFError> {
        return Future { promise in
            
            AFSession.request(resource, body: body)
                    .validate(statusCode: 200..<300)
                    .responseDecodable(of: T.self,
                        queue: .global(),
                        completionHandler: { (response: DataResponse<T, AFError>) in
                        switch response.result {
                        case .success(let data):
                            promise(.success(data))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    })
        }
    }
}
