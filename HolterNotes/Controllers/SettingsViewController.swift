//
//  SettingsViewController.swift
//  HolterNotes
//
//  Created by Yanke Guo on 2019/2/28.
//  Copyright © 2019 Yanke Guo. All rights reserved.
//

import QuickLook
import UIKit

let demoString = "Hello World\nHello World2\nHello World3"

class ExportPreviewItem: NSObject, QLPreviewItem {
    init(url: URL) {
        previewItemURL = url
    }

    var previewItemURL: URL?
}

class SettingsViewController: UITableViewController, QLPreviewControllerDataSource {
    var exportFileURL: URL?

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 {
            let fileURL = HNExportFileURL(forDate: Date())

            exportFileURL = fileURL

            try! demoString.write(to: fileURL, atomically: true, encoding: .utf8)

            let controller = QLPreviewController()
            controller.dataSource = self
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    func numberOfPreviewItems(in _: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt _: Int) -> QLPreviewItem {
        return ExportPreviewItem(url: exportFileURL!)
    }
}
