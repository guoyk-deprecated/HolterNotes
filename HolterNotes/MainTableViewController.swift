//
//  MainTableViewController.swift
//  HolterNotes
//
//  Created by Yanke Guo on 2019/2/27.
//  Copyright © 2019 Yanke Guo. All rights reserved.
//

import Dispatch
import UIKit

class MainTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: NSLocalizedString("TITLE_PULL_TO_ADD", comment: ""))
        refreshControl?.addTarget(self, action: #selector(onRefreshControlChanged), for: .valueChanged)
    }

    @objc
    func onRefreshControlChanged() {
        showAddEntryUI()
    }

    func showAddEntryUI() {
        let alertViewController = UIAlertController(title: NSLocalizedString("TITLE_ADD_ENTRY", comment: ""), message: nil, preferredStyle: .alert)
        alertViewController.addTextField { textField in
            textField.returnKeyType = .done
        }
        alertViewController.addAction(UIAlertAction(title: NSLocalizedString("TITLE_CANCEL", comment: ""), style: .cancel, handler: { _ in
        }))
        navigationController?.present(alertViewController, animated: true, completion: {
            self.refreshControl?.endRefreshing()
        })
    }

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default")
        cell?.textLabel?.text = indexPath.description
        cell?.detailTextLabel?.text = indexPath.description
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
}
