//
//  PlayerError.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/05/30.
//

import Foundation

struct PlayerError: Error {
    let errorType: PlayerErrorType
}

enum PlayerErrorType {
    case invalidURL
}

extension PlayerErrorType: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Alarm URL 에러"
        }
    }
}
