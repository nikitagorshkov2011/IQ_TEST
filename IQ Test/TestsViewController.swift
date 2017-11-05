//
//  ViewController.swift
//  IQ Test
//
//  Created by Admin on 09.08.17.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class TestsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        setButtons()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = NSLocalizedString("IQ TESTS", comment: "comment")
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: NSLocalizedString("◀︎ Menu", comment: "comment"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(openHome))
        self.navigationItem.leftBarButtonItem = newBackButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func openTest(_ sender: Any?) {
        
        performSegue(withIdentifier: "OpenTest", sender: sender)
        
    }
    
    @IBAction func openDescription(_ sender: UIButton) {
        
        performSegue(withIdentifier: "OpenDescription", sender: sender)
        
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
    
    func setButtons() {
        
        let defaults = UserDefaults.standard
        let records = defaults.object(forKey: "RecordsForTests") as? [String : String] ?? [String : String]()
        
        for i in 101...105 {
            if let button: UIButton = self.view.viewWithTag(i) as? UIButton {
                if records.keys.contains("Test " + String(button.tag - 100)) {
                    button.setTitleColor(UIColor(hex: "6B717E"), for: .normal)
                    button.isUserInteractionEnabled = true
                } else {
                    button.setTitleColor(UIColor(hex: "FFE8C2"), for: .normal)
                    button.isUserInteractionEnabled = false
                }
            }
        }
        
        for i in 11...15 {
            if let button: UIButton = self.view.viewWithTag(i) as? UIButton {
                if records.keys.contains("Test " + String(button.tag - 11)) || i == 11 {
                    button.setTitleColor(UIColor(hex: "BD615F"), for: .normal)
                    button.backgroundColor = UIColor(hex: "FFE8C2")
                    button.layer.borderColor = UIColor(hex: "BD615F").cgColor
                    button.isUserInteractionEnabled = true
                } else {
                    button.setTitleColor(.gray, for: .normal)
                    button.backgroundColor = UIColor(hex: "FFE8C2")
                    button.layer.borderColor = UIColor.gray.cgColor
                    button.isUserInteractionEnabled = false
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let x = sender as? UIButton {
            if let text = x.currentTitle {
                if let questionViewController = segue.destination as? QuestionViewController {
                    questionViewController.currentTestNumber = text
                } else if let resultViewController = segue.destination as? ResultViewController, let button = sender as? UIButton {
                    resultViewController.selectedTestNumber = "Test \(button.tag - 100)"
                }
            }
        }
    }
        
}
