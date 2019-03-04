//
//  AddViewController.swift
//  HolterNotes
//
//  Created by Yanke Guo on 2019/2/28.
//  Copyright © 2019 Yanke Guo. All rights reserved.
//

import RealmSwift
import UIKit

class AddViewController: UITableViewController, DatePickerViewControllerDelegate {
    @IBOutlet
    var textViewContent: UITextView?

    @IBOutlet
    var labelTimeLeft: UILabel?

    @IBOutlet
    var labelTimeRight: UILabel?

    var date: Date = Date() {
        didSet {
            labelTimeLeft?.text = HNFormat(date: date)
            labelTimeRight?.text = "(" + HNFormat(timeInterval: Date().timeIntervalSince(date)) + ")"
        }
    }

    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        date = Date()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        textViewContent?.becomeFirstResponder()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startTimer()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        stopTimer()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0, indexPath.row == 0 {}

        if indexPath.section == 2, indexPath.row == 0 {
            submit()
        }
    }

    func datePickerViewController(_: DatePickerViewController, dateDidUpdated date: Date) {
        self.date = date
    }

    func startTimer() {
        if timer != nil {
            stopTimer()
        }
        timer = Timer(timeInterval: TimeInterval(1), target: self, selector: #selector(onTimerTicked(timer:)), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .default)
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc
    func onTimerTicked(timer t: Timer) {
        labelTimeRight?.text = "(" + HNFormat(timeInterval: t.fireDate.timeIntervalSince(date)) + ")"
    }

    func submit() {
        let realm = try! Realm()
        let entry = Entry()
        entry.date = date
        entry.content = textViewContent?.text ?? "..."
        entry.content = entry.content.trimmingCharacters(in: .whitespacesAndNewlines)
        if entry.content.isEmpty {
            entry.content = "(" + NSLocalizedString("no_content", comment: "") + ")"
        }
        try! realm.write {
            realm.add(entry)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == "date-picker" {
            let controller = segue.destination as! DatePickerViewController
            controller.date = date
            controller.delegate = self
        }
    }
}
