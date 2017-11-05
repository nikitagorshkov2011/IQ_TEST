//
//  RecordTableViewCell.swift
//  IQ Test
//
//  Created by Admin on 06.09.17.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    var colorView: UIView?
    var recordLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cleanCell() {
        recordLabel?.removeFromSuperview()
        colorView?.removeFromSuperview()
    }
    
    func setBackground() {
        colorView = UIView(frame: self.bounds)
        colorView?.backgroundColor = UIColor(hex: "FFE8C2")
        self.addSubview(colorView!)
        self.sendSubview(toBack: colorView!)
    }
    
    func setRecordView(_ testName: String, _ score: String) {
        cleanCell()
        setBackground()
        recordLabel = UILabel(frame: CGRect(x: self.bounds.maxX * 0.1, y: self.bounds.maxY * 0.1, width: self.bounds.maxX * 0.8, height: self.bounds.maxY * 0.8))
        recordLabel?.text = "\(testName)\n" + NSLocalizedString("Your best score is:", comment: "comment") + " \(score.components(separatedBy: ";")[0]) " + NSLocalizedString("correct\nYour max IQ is", comment: "comment") + " \(Int(score.components(separatedBy: ";")[0])!*2 + 70)" + NSLocalizedString("\nTime: ", comment: "comment") + "\(score.components(separatedBy: ";")[1])"
        recordLabel?.adjustsFontSizeToFitWidth = true
        recordLabel?.numberOfLines = 0
        recordLabel?.textAlignment = .center
        self.addSubview(recordLabel!)
    }
    
    func setEmptyView() {
        cleanCell()
        setBackground()
        recordLabel = UILabel(frame: CGRect(x: self.bounds.maxX * 0.1, y: self.bounds.maxY * 0.1, width: self.bounds.maxX * 0.8, height: self.bounds.maxY * 0.8))
        recordLabel?.text = NSLocalizedString("Complete tests to see your records!", comment: "comment")
        recordLabel?.adjustsFontSizeToFitWidth = true
        recordLabel?.numberOfLines = 0
        recordLabel?.textAlignment = .center
        self.addSubview(recordLabel!)
    }
}
