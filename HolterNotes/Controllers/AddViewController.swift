//
//  AddViewController.swift
//  HolterNotes
//
//  Created by Yanke Guo on 2019/2/28.
//  Copyright © 2019 Yanke Guo. All rights reserved.
//

import UIKit

class AddViewController: UITableViewController {
    @IBOutlet
    var textViewContent: UITextView?

    @IBOutlet
    var labelTimeLeft: UILabel?

    @IBOutlet
    var labelTimeRight: UILabel?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        textViewContent?.becomeFirstResponder()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
