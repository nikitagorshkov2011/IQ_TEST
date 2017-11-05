//
//  ResultTableViewCell.swift
//  IQ Test
//
//  Created by Admin on 23.08.17.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    var cellHeaderView: UIView?
    var questionView: QuestionView?
    var answerView: UIView?
    var descriptionView: UIView?
    var colorView: UIView?
    
    var resultLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setResultCell(text: String) {
        cleanCell()
        setBackground()
        resultLabel = UILabel(frame: CGRect(x: self.bounds.minX, y: self.bounds.maxY * 0.15, width: self.bounds.maxX, height: self.bounds.maxY * 0.7))
        resultLabel?.text = text
        resultLabel?.textAlignment = .center
        resultLabel?.numberOfLines = 0
        self.addSubview(resultLabel!)
    }
    
    func setQuestionView(selectedTest: Test, index: Int, userAnswer: Int?, isCollapsed: Bool) {
        cleanCell()
        var constants: [String:CGFloat] = ["cellHeader" : 0.1, "question" : 0.3, "answer" : 0.3, "description" : 0.3,]
        if isCollapsed {
            constants["cellHeader"] = 1
            constants["question"] = 0
            constants["answer"] = 0
            constants["description"] = 0
        } else if selectedTest.questions[index].description == nil {
            constants["cellHeader"] = 1/7
            constants["question"] = 3/7
            constants["answer"] = 3/7
            constants["description"] = 0
        }
        cellHeaderView = UIView(frame: CGRect(x: self.bounds.maxX * 0 ,y: self.bounds.maxY * 0 , width: self.bounds.maxX, height: self.bounds.maxY * constants["cellHeader"]!))
        questionView = QuestionView(frame: CGRect(x: self.bounds.maxX * 0.05 ,y: self.bounds.maxY * constants["cellHeader"]!, width: self.bounds.maxX * 0.9, height: self.bounds.maxY * constants["question"]!))
        answerView = UIView(frame: CGRect(x: self.bounds.maxX * 0.05 ,y: self.bounds.maxY * (constants["cellHeader"]! + constants["question"]!), width: self.bounds.maxX * 0.9, height: self.bounds.maxY * constants["answer"]!))
        descriptionView = UIView(frame: CGRect(x: self.bounds.maxX * 0.05 ,y: self.bounds.maxY * (constants["cellHeader"]! + constants["question"]! + constants["answer"]!) , width: self.bounds.maxX * 0.9, height: self.bounds.maxY * constants["description"]!))
        
        self.addSubview(cellHeaderView!)
        self.addSubview(questionView!)
        self.addSubview(answerView!)
        self.addSubview(descriptionView!)
        setBackground()
    
        cellHeaderView = QuestionView.createCellHeaderView(cellHeaderView: cellHeaderView!, selectedTest: selectedTest, index: index, userAnswer: userAnswer, isCollapsed: isCollapsed)
        questionView = QuestionView.createQuestionView(view: questionView, test: selectedTest, questionNumber: index)
        answerView = AnswerView.setAnswersView(view: answerView!, selectedTest: selectedTest, index: index, userAnswer: userAnswer )
        descriptionView = QuestionView.createDescriptionView(view: descriptionView!, selectedTest: selectedTest, index: index)
    }
    
    func cleanCell() {
        cellHeaderView?.removeFromSuperview()
        colorView?.removeFromSuperview()
        questionView?.removeFromSuperview()
        answerView?.removeFromSuperview()
        descriptionView?.removeFromSuperview()
        resultLabel?.removeFromSuperview()
    }
    
    func setBackground() {
        colorView = UIView(frame: self.bounds)
        colorView?.backgroundColor = UIColor(hex: "FFE8C2")
        
        
        self.addSubview(colorView!)
        self.sendSubview(toBack: colorView!)
    }
    
    
    
}
