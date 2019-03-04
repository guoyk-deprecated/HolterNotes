//
//  SettingsViewController.swift
//  HolterNotes
//
//  Created by Yanke Guo on 2019/2/28.
//  Copyright © 2019 Yanke Guo. All rights reserved.
//

import QuickLook
import RealmSwift
import UIKit

class ExportPreviewItem: NSObject, QLPreviewItem {
    init(url: URL) {
        previewItemURL = url
    }

    var previewItemURL: URL?
}

class SettingsViewController: UITableViewController, QLPreviewControllerDataSource {
    let exportFileURL: URL = HNExportFileURL(forDate: Date())

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 {
            // delete existing
            try! FileManager.default.removeItem(at: exportFileURL)

            // output
            var output = ""
            let realm = try! Realm()
            let results = realm.objects(Entry.self).sorted(byKeyPath: "date", ascending: true)
            results.forEach { entry in
                output = output + HNFormat(date: entry.date) + " " + entry.content + "\r\n"
            }

            // write new
            try! output.write(to: exportFileURL, atomically: true, encoding: .utf8)

            // display file
            let controller = QLPreviewController()
            controller.dataSource = self
            navigationController?.pushViewController(controller, animated: true)
        }

        if indexPath.section == 1 {
            let controller = UIAlertController(title: NSLocalizedString("confirm_to_delete", comment: ""),
                                               message: NSLocalizedString("this_action_cannot_be_undo", comment: ""),
                                               preferredStyle: .actionSheet)
            controller.addAction(UIAlertAction(title: NSLocalizedString("delete_all", comment: ""), style: .destructive, handler: { _ in
            }))
            controller.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
            navigationController!.present(controller, animated: true, completion: nil)
        }
    }

    func numberOfPreviewItems(in _: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt _: Int) -> QLPreviewItem {
        return ExportPreviewItem(url: exportFileURL)
    }
}
