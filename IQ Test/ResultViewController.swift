//
//  ResultViewController.swift
//  IQ Test
//
//  Created by Евгений on 14.08.17.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var text : String? {
        didSet {
            countOfCells += 1
        }
    }
    
    var selectedTestNumber: String? {
        didSet {
            selectedTest = Test().parse(selectedTestNumber!)
        }
    }
    
    var selectedTest: Test? {
        didSet {
            countOfCells += (selectedTest?.questions.count)!
        }
    }
    
    var selectedCellIndexPath: IndexPath?
    
    var userAnswers = [Int]()
    var countOfCells = 0

    override func viewDidLoad() {

        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationButton()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResultTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ResultTableViewCell
        
        let isCollapsed = selectedCellIndexPath == indexPath ? false: true
        
        if countOfCells == 40 {
            cell.setQuestionView(selectedTest: selectedTest!, index: indexPath.row, userAnswer: nil, isCollapsed: isCollapsed)
        } else {
            if indexPath.row == 0 {
                cell.setResultCell(text: text!)
            } else {
                cell.setQuestionView(selectedTest: selectedTest!, index: indexPath.row - 1, userAnswer: userAnswers[indexPath.row - 1], isCollapsed: isCollapsed)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = countOfCells == 40 ? indexPath.row : indexPath.row - 1
        if indexPath.row != 0 || countOfCells == 40 {
            if selectedCellIndexPath != indexPath {
                return tableView.bounds.maxX * 0.15
            } else if selectedTest?.questions[index].description != nil {
                return tableView.bounds.maxX * 1.5
            } else {
                return tableView.bounds.maxX * 1.05
            }
        }
        return tableView.bounds.maxX * 0.45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSelected = selectedCellIndexPath != nil ? selectedCellIndexPath : indexPath
        if selectedCellIndexPath != indexPath {
            selectedCellIndexPath = indexPath
            tableView.reloadRows(at: [indexPath, currentSelected!], with: UITableViewRowAnimation.fade)
            tableView.beginUpdates()
            tableView.endUpdates()
        } else {
            selectedCellIndexPath = nil
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    
    
    func setNavigationButton() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = countOfCells == 40 ? NSLocalizedString("ANSWERS", comment: "comment") : NSLocalizedString("RESULTS", comment: "comment")
        let newBackButton = UIBarButtonItem(title: NSLocalizedString("◀︎ Menu", comment: "comment"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(openHome))
        self.navigationItem.leftBarButtonItem = newBackButton
    }

    @objc func openHome(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToHomeVC", sender: sender)
    }

}
