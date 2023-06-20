//
//  ThemeAttribute.swift
//  NewlabUIKit
//
//  Created by Ok Hyeon Kim on 2023/06/09.
//

import UIKit

public struct ThemeAttribute {
    public var contentViewBackgroundColor: UIColor
    public var wheelCellBackgroundColor: UIColor
    public var stripColor: UIColor
    public var wheelFont: UIFont
    public var wheelTextColor: UIColor
    public var is24: Bool = false

    public init() {
        contentViewBackgroundColor = UIColor.contentViewBackgroundColor
        wheelCellBackgroundColor = UIColor.wheelCellBackgroundColor
        stripColor = UIColor.stripColor
        wheelFont = .systemFont(ofSize: 18)
        wheelTextColor = UIColor.wheelTextColor
        is24 = is24Format()
    }

    func is24Format() -> Bool {
        let locale = NSLocale.current
        guard let formatter = DateFormatter.dateFormat(fromTemplate: "j", options:0, locale:locale) else {
            return true
        }

        if formatter.contains("a") {
            return false
        } else {
            return true
        }
    }
}

public enum Theme {
    case light
    case dark
    case custom(ThemeAttribute)

    public var attribute: ThemeAttribute {
        switch self {
        case .light:
            return ThemeAttribute()

        case .dark:
            var attrib = ThemeAttribute()
            attrib.contentViewBackgroundColor = UIColor.contentViewBackgroundColor
            attrib.wheelCellBackgroundColor = UIColor.wheelCellBackgroundColor
            attrib.wheelTextColor = UIColor.wheelTextColor
            return attrib

        case .custom(let attrib):
            return attrib
        }
    }
}
