//
//  GreetingsType.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/06/08.
//

import Foundation

enum GreetingsType {
    case morning
    case afternoon
    case evening
}

extension GreetingsType: CustomStringConvertible {
    var description: String {
        switch self {
        case .morning:
            return "Good Morning"
        case .afternoon:
            return "Good Afternoon"
        case .evening:
            return "Good Evening"
        }
    }

    static var now: Self {
        let dateComponents = Calendar.current.dateComponents([.hour], from: Date())

        guard let hour = dateComponents.hour else {
            Log.error("Greeting Type Error! -> \(Date())")
            return .morning
        }

        switch hour {
        case 5..<9:
            return .morning
        case 9..<17:
            return .afternoon
        default:
            return .evening
        }
    }

    /*
     * 새벽 : 0시 ~ 5시
     * 아침 : 5시 ~ 9시
     * 낮 : 9시 ~ 17시
     * 저녁 : 17시 ~ 21시
     * 밤 : 21시 ~ 24시
     */
}
