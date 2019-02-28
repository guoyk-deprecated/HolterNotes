//
//  HNPopSegue.swift
//  HolterNotes
//
//  Created by Yanke Guo on 2019/2/28.
//  Copyright © 2019 Yanke Guo. All rights reserved.
//

import UIKit

class HNPopSegue: UIStoryboardSegue {
    var viewController: UIViewController?

    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)

        viewController = source
    }

    override func perform() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
