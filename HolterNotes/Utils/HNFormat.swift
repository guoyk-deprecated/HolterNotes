//
//  File.swift
//  HolterNotes
//
//  Created by Yanke Guo on 2019/2/28.
//  Copyright © 2019 Yanke Guo. All rights reserved.
//

import Foundation

func HNFormat(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    return dateFormatter.string(from: date)
}

func HNFormat(timeInterval: TimeInterval) -> String {
    var seconds = Int64(timeInterval)

    if seconds <= 5, seconds >= -5 {
        return NSLocalizedString("time-ago.just_now", comment: "")
    }

    var digits = Int64(0)
    var prefix = ""
    var suffix = ""

    if seconds > 0 {
        suffix = "_ago"
    } else {
        suffix = "_later"
    }

    seconds = abs(seconds)

    if seconds > 5, seconds < 60 * 2 {
        prefix = "time-ago.seconds"
        digits = seconds
    } else if seconds >= 60 * 2, seconds < 60 * 60 * 2 {
        prefix = "time-ago.minutes"
        digits = seconds / 60
    } else if seconds >= 60 * 60 * 2, seconds < 60 * 60 * 24 * 2 {
        prefix = "time-ago.hours"
        digits = seconds / (60 * 60)
    } else if seconds >= 60 * 60 * 24 {
        prefix = "time-ago.days"
        digits = seconds / (60 * 60 * 24)
    }

    return NSLocalizedString(prefix + suffix, comment: "").replacingOccurrences(of: "__DIGITS__", with: digits.description)
}
