//
//  Entry.swift
//  HolterNotes
//
//  Created by Yanke Guo on 2019/3/4.
//  Copyright © 2019 Yanke Guo. All rights reserved.
//

import Foundation
import RealmSwift

class Entry: Object {
    @objc dynamic var date = Date()
    @objc dynamic var content = ""
}
