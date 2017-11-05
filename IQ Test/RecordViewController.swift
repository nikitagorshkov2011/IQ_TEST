//
//  RecordViewController.swift
//  IQ Test
//
//  Created by Admin on 06.09.17.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    var records = [String : String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        records = defaults.object(forKey: "RecordsForTests") as? [String : String] ?? [String : String]()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationItem.title = NSLocalizedString("RECORDS", comment: "comment")
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: NSLocalizedString("◀︎ Menu", comment: "comment"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(openHome))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func openHome(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToHomeVC", sender: sender)
    }
    
    func setBackground() {
        let colorView = UIView(frame: view.bounds)
        let innerColorView = UIView(frame: CGRect(x: colorView.bounds.minX + 10, y: colorView.bounds.maxY * 0.1, width: colorView.bounds.maxX - 20, height: colorView.bounds.maxY * 0.9 - 10))
        colorView.backgroundColor = UIColor(hex: "BD615F")
        innerColorView.backgroundColor = UIColor(hex: "FFE8C2")
        innerColorView.layer.cornerRadius = 10
        colorView.addSubview(innerColorView)
        view.addSubview(colorView)
        self.view.sendSubview(toBack: colorView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count > 0 ? records.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecordTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecordTableViewCell
        if let score = records["Test \(indexPath.row + 1)"] {
            cell.setRecordView("Test \(indexPath.row + 1)", score)
        } else if indexPath.row == 0 {
            cell.setEmptyView()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.maxY * 0.3
    }

}
