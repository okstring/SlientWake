//
//  AlarmType.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/05/30.
//

import Foundation

enum AlarmType {
    case alarm1
    case alarm2
    case alarm3
    case alarm4
    case chickenSound
    case emergencyAlarm1
    case emergencyAlarm2
    case lifeSupportAlarm
    case phoneRing
    case radiationAlert
    case schoolBell
}

extension AlarmType {
    var name: String {
        switch self {
        case .alarm1:
            return "Alarm1"
        case .alarm2:
            return "Alarm2"
        case .alarm3:
            return "Alarm3"
        case .alarm4:
            return "Alarm4"
        case .chickenSound:
            return "ChickenSound"
        case .emergencyAlarm1:
            return "EmergencyAlarm1"
        case .emergencyAlarm2:
            return "EmergencyAlarm2"
        case .lifeSupportAlarm:
            return "LifeSupportAlarm"
        case .phoneRing:
            return "PhoneRing"
        case .radiationAlert:
            return "RadiantionAlert"
        case .schoolBell:
            return "SchoolBell"
        }
    }

    var withExtension: String {
        return "mp3"
    }

    var alarmURL: URL? {
        return Bundle.main.url(forResource: name, withExtension: withExtension)
    }
}
