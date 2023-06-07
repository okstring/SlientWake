//
//  JsonAPI.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/06/07.
//

import Foundation

public enum JsonAPI { }

public extension JsonAPI {
    struct Post: NetworkAPIDefinition {
        public let urlInfo: URLInfo
        public let requestInfo: RequestInfo<EmptyParameters> = .init(method: .get)

        public init() {
            self.urlInfo = .jsonAPI(path: "/posts", queryString: [:])
        }

        public typealias Response = Data
    }
}
