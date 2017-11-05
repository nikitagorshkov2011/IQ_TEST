//
//  HomePageViewController.swift
//  IQ Test
//
//  Created by Admin on 06.09.17.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

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
        self.navigationItem.title = NSLocalizedString("IQ TESTS", comment: "comment")
        self.navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func openSettings(_ sender: TestButton) {
        performSegue(withIdentifier: "OpenSettings", sender: sender)
    }
    
    @IBAction func openTests(_ sender: TestButton) {
        performSegue(withIdentifier: "OpenTests", sender: sender)
    }
    
    
    @IBAction func openRecords(_ sender: TestButton) {
        performSegue(withIdentifier: "OpenRecords", sender: sender)
    }
    
    @IBAction func unwindToHomeVC(segue: UIStoryboardSegue){}

    func setButtons() {
        for i in 1...3 {
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

}
