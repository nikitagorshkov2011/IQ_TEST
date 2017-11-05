//
//  SettingsViewController.swift
//  IQ Test
//
//  Created by Admin on 07.09.17.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackground()
        setButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = NSLocalizedString("SETTINGS", comment: "comment")
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: NSLocalizedString("◀︎ Menu", comment: "comment"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(openHome))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func openHome(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToHomeVC", sender: sender)
    }
    
    func setButtons() {
        for i in 1...2 {
            if let button: UIButton = self.view.viewWithTag(i) as? UIButton {
                button.setTitleColor(UIColor(hex: "BD615F"), for: .normal)
                button.backgroundColor = UIColor(hex: "FFE8C2")
                button.layer.borderColor = UIColor(hex: "BD615F").cgColor
            }
        }
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
    
    @IBAction func resetProgress(_ sender: TestButton) {
        
        let alert  =  UIAlertController(title: NSLocalizedString("Reset records", comment: "comment"), message: NSLocalizedString("Are you sure you want to reset? All your progress will be deleted", comment: "comment"), preferredStyle:  UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "comment"), style: UIAlertActionStyle.default, handler: { (action) in
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "RecordsForTests")
            let resetCompleteAlert  =  UIAlertController(title: NSLocalizedString("Records are reseted", comment: "comment"), message: NSLocalizedString("Now you can pass tests again!", comment: "comment"), preferredStyle:  UIAlertControllerStyle.alert)
            resetCompleteAlert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "comment"), style: UIAlertActionStyle.default, handler: { (action) in }))
            self.present(resetCompleteAlert, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "comment"), style: UIAlertActionStyle.default, handler: { (action) in }))
        
        self.present(alert, animated: true, completion: nil)
        
    }

}
