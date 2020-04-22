import Foundation
import Combine
import Alamofire
import os

let apiLog = OSLog(subsystem: "com.naz.SuperMario", category: "api")

#if DEBUG
var AFSession = Session(eventMonitors: [APILogger()])
#else
var AFSession = Session()
#endif

final class APIClient<T:Decodable> {
    
    init() {}

    func loadDecodable(_ resource: Resource, body: Body) -> Future<T, APIError> {
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
                                promise(.failure(APIError.error(message: error.localizedDescription)))
                        }
                    })
        }
    }
}
