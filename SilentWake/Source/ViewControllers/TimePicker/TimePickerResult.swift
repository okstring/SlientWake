//
//  TimePickerResult.swift
//  NewlabUIKit
//
//  Created by Ok Hyeon Kim on 2023/06/09.
//

import Foundation

public struct TimePickerResult {
    public var hour: Int
    public var minute: Int
    public var is24: Bool
    public var meridian: TimeMeridian

    public init() {
        self.hour = 0
        self.minute = 0
        self.is24 = false
        self.meridian  = .am
    }
}

extension TimePickerResult: CustomStringConvertible {
    public var description: String {
        return "\(hour):\(minute)" + (is24 ? "" : " \(meridian)")
    }

    var date: Date {
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        var dateComponents = Calendar.current.dateComponents(components, from: Date())

        dateComponents.hour = meridian == .am ? hour : hour + 12
        dateComponents.minute = minute
        
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
}
