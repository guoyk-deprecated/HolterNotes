//
//  SettingsViewController.swift
//  HolterNotes
//
//  Created by Yanke Guo on 2019/2/28.
//  Copyright © 2019 Yanke Guo. All rights reserved.
//

import QuickLook
import RealmSwift
import SafariServices
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
            // output
            var output = ""
            let realm = try! Realm()
            let results = realm.objects(Entry.self).sorted(byKeyPath: "date", ascending: true)
            results.forEach { entry in
                output = output + HNFormat(date: entry.date) + " " + entry.content + "\r\n"
            }

            if output.isEmpty {
                let alert = UIAlertController(title: NSLocalizedString("no_entries", comment: ""), message: nil, preferredStyle: .alert)
                alert.view.tintColor = navigationController!.navigationBar.tintColor
                alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel, handler: nil))
                navigationController!.present(alert, animated: true, completion: nil)
            } else {
                // write new
                try! output.write(to: exportFileURL, atomically: true, encoding: .utf8)

                // display file
                let controller = QLPreviewController()
                controller.dataSource = self
                navigationController?.pushViewController(controller, animated: true)
            }
        }

        if indexPath.section == 1 {
            let alert = UIAlertController(title: NSLocalizedString("confirm_to_delete", comment: ""),
                                          message: NSLocalizedString("this_action_cannot_be_undo", comment: ""),
                                          preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: NSLocalizedString("delete_all", comment: ""), style: .destructive, handler: { _ in
                let realm = try! Realm()
                try! realm.write {
                    realm.deleteAll()
                }
                self.navigationController?.popViewController(animated: true)
            }))
            alert.view.tintColor = navigationController!.navigationBar.tintColor
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
            navigationController!.present(alert, animated: true, completion: nil)
        }

        if indexPath.section == 2 {
            let controller = SFSafariViewController(url: URL(string: "https://yankeguo.github.io/HolterNotes")!)
            controller.dismissButtonStyle = .close
            controller.preferredControlTintColor = navigationController!.navigationBar.tintColor
            navigationController?.present(controller, animated: true, completion: nil)
        }
    }

    func numberOfPreviewItems(in _: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt _: Int) -> QLPreviewItem {
        return ExportPreviewItem(url: exportFileURL)
    }
}
