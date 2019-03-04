//
//  MainViewController.swift
//  HolterNotes
//
//  Created by Yanke Guo on 2019/2/28.
//  Copyright © 2019 Yanke Guo. All rights reserved.
//

import UIKit
import RealmSwift

class MainCell: UITableViewCell {
    
    @IBOutlet
    var dateLabel: UILabel?
    
    @IBOutlet
    var contentLabel: UILabel?
    
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet
    var tableView: UITableView?
    
    @IBOutlet
    var buttonAdd: UIButton?

    @IBOutlet
    var labelEmpty: UILabel?
    
    var results: Results<Entry>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        
        self.results = realm.objects(Entry.self).sorted(byKeyPath: "date", ascending: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView?.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // adjust title of buttonAdd
        buttonAdd?.titleEdgeInsets.bottom = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0) / 2
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default") as! MainCell
        cell.dateLabel?.text = HNFormat(date: results[indexPath.row].date)
        cell.contentLabel?.text = results[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            let entry = results[indexPath.row]
            try! realm.write {
                realm.delete(entry)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
