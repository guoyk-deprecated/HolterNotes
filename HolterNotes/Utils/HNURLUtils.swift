//
//  HNURLUtils.swift
//  HolterNotes
//
//  Created by Yanke Guo on 2019/2/28.
//  Copyright © 2019 Yanke Guo. All rights reserved.
//

import Foundation

func HNExportFileURL(forDate date: Date) -> URL {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.string(from: date)

    var url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last!
    url.appendPathComponent("holter-notes-" + date + ".txt")

    return url
}
