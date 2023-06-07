//
//  NetworkAPI.swift
//  PhotoWidget
//
//  Created by Ok Hyeon Kim on 2023/04/06.
//

import Foundation

public enum NetworkAPI { }

public extension NetworkAPI.URLInfo {
    static var jsonHost: String {
        guard let jsonHost = Bundle.main.infoDictionary?["JsonPlaceholderHost"] as? String else {
            Log.error("URL 확인 필요")
            return ""
        }

        return jsonHost
    }

    static func jsonAPI(path: String, queryString: [String: String]) -> Self {
        Self.init(host: jsonHost, path: path, query: queryString)
    }
}
