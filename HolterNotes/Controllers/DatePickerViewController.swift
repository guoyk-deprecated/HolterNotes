//
//  DatePickerViewController.swift
//  HolterNotes
//
//  Created by Yanke Guo on 2019/3/4.
//  Copyright © 2019 Yanke Guo. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerDelegate {
    func datePickerViewController(_ viewController: DatePickerViewController, dateDidUpdated date: Date)
}

class DatePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var delegate: DatePickerViewControllerDelegate?

    @IBOutlet
    var datePicker: UIDatePicker?

    @IBOutlet
    var timePicker: UIPickerView?

    var date = Date() {
        didSet {
            updateTitle()

            delegate?.datePickerViewController(self, dateDidUpdated: date)
        }
    }

    let secondRanges = Calendar.current.maximumRange(of: .second)!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateTitle()

        datePicker?.date = date
        timePicker?.selectRow(Calendar.current.component(.second, from: date), inComponent: 0, animated: false)
    }

    func updateTitle() {
        navigationItem.title = HNFormat(date: date)
    }

    @IBAction
    func onDatePickerValueChanged(datePicker: UIDatePicker) {
        let sec = Calendar.current.component(.second, from: date)
        date = Calendar.current.date(bySetting: .second, value: sec, of: datePicker.date)!
    }

    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return secondRanges.count
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        return String(format: ": %02d", secondRanges[row])
    }

    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        let hou = Calendar.current.component(.hour, from: date)
        let min = Calendar.current.component(.minute, from: date)
        date = Calendar.current.date(bySettingHour: hou, minute: min, second: row, of: date)!
    }
}
