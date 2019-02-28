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

    var time: Date = Date() {
        didSet {
            labelTimeLeft?.text = HNFormat(date: time)
            labelTimeRight?.text = "(" + HNFormat(timeInterval: Date().timeIntervalSince(time)) + ")"
        }
    }

    var content: String = ""

    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        time = Date()
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
        labelTimeRight?.text = "(" + HNFormat(timeInterval: t.fireDate.timeIntervalSince(time)) + ")"
    }

    func submit() {
        // TODO: implementes submit
    }
}
