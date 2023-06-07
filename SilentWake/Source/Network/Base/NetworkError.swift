//
//  NetworkError.swift
//  PhotoWidget
//
//  Created by Ok Hyeon Kim on 2023/04/05.
//

import Foundation

public struct NetworkError: Error, Equatable {
    let errorType: NetworkErrorType?

    init(_ errorType: NetworkErrorType?) {
        self.errorType = errorType
    }
}

public enum NetworkErrorType: Equatable {
    case noData
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self.errorType {
        case .noData:
            return "데이터가 없습니다."
        default:
            return "알 수 없는 에러입니다."
        }
    }
}
