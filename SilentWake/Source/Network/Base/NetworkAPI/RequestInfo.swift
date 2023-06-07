//
//  RequestInfo.swift
//  PhotoWidget
//
//  Created by Ok Hyeon Kim on 2023/04/06.
//

import Foundation

public extension NetworkAPI {
    struct RequestInfo<T: Encodable> {
        var method: Method
        var headers: [String: String]?
        var parameters: T?

        public init(method: NetworkAPI.Method,
                    headers: [String : String]? = nil,
                    parameters: T? = nil) {
            self.method = method
            self.headers = headers
            self.parameters = parameters
        }
    }
}

public extension NetworkAPI.RequestInfo {
    func requests(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = parameters.flatMap { try? JSONEncoder().encode($0) }
        headers.map {
            request.allHTTPHeaderFields?.merge($0) { lhs, rhs in lhs }
        }
        return request
    }
}
