//
//  QuestionView.swift
//  IQ Test
//
//  Created by Admin on 23.08.17.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class QuestionView: UIView {

    static func createQuestionView(view questionView: QuestionView?, test: Test?, questionNumber: Int) -> QuestionView {
        
        var textView: UILabel?
        var imageView: UIImageView?
        
        func setQuestionText(_ label: UILabel) {
            label.text = test?.questions[questionNumber].questionText
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 0
            label.textAlignment = .center
        }
        
        func setImage(_ imageView: UIImageView){
            if let image = test?.questions[questionNumber].questionPicture {
                if let bundlePath = Bundle.main.path(forResource: image, ofType: "png", inDirectory: NSLocalizedString("drawable-en", comment: "comment")){
                    imageView.image = UIImage(contentsOfFile: bundlePath)?.withRenderingMode(.alwaysOriginal)
                    imageView.contentMode = .scaleAspectFit
                }
            }
        }
        
        if test?.questions[questionNumber].questionPicture != nil && test?.questions[questionNumber].questionText != nil {
            if test?.questions[questionNumber].questionLayout == "H" {
                textView = UILabel(frame: CGRect(x: 0 ,y: 0 , width: questionView!.bounds.maxX * 0.45, height: questionView!.bounds.maxY))
                imageView = UIImageView(frame: CGRect(x: questionView!.bounds.maxX * 0.55, y: 0, width: questionView!.bounds.maxX * 0.45, height: questionView!.bounds.maxY))
            } else {
                textView = UILabel(frame: CGRect(x: 0 ,y: questionView!.bounds.maxY * 0.05 , width: questionView!.bounds.maxX, height: questionView!.bounds.maxY * 0.35))
                imageView = UIImageView(frame: CGRect(x: 0, y: questionView!.bounds.maxY * 0.5, width: questionView!.bounds.maxX, height: questionView!.bounds.maxY * 0.45))
            }
            setQuestionText(textView!)
            setImage(imageView!)
            questionView!.addSubview(textView!)
            questionView!.addSubview(imageView!)
            
            
        } else if test?.questions[questionNumber].questionText != nil {
            textView = UILabel(frame: CGRect(x: 0 ,y: 0 , width: questionView!.bounds.maxX, height: questionView!.bounds.maxY))
            setQuestionText(textView!)
            textView!.font = textView!.font.withSize(24)
            //textView.layer.borderWidth = 0.5
            questionView!.addSubview(textView!)
            
        } else {
            imageView = UIImageView(frame: CGRect(x: 0 ,y: 0 , width: questionView!.bounds.maxX, height: questionView!.bounds.maxY))
            setImage(imageView!)
            questionView!.addSubview(imageView!)
        }
        questionView?.layer.addBorder(edge: .bottom, color: UIColor(hex: "B0413E"), thickness: 0.5)
        return questionView!
    }
    
    
    static func createDescriptionView(view: UIView, selectedTest: Test, index: Int) -> UIView {
        var descriptionView: UILabel?
        if let description = selectedTest.questions[index].description {
            descriptionView = UILabel(frame: CGRect(x: view.bounds.maxX * 0.05, y: view.bounds.maxY * 0.05, width: view.bounds.maxX * 0.9, height: view.bounds.maxY * 0.8))
            descriptionView?.text = description.capitalizingFirstLetter()
            descriptionView?.adjustsFontSizeToFitWidth = true
            descriptionView?.numberOfLines = 0
            descriptionView?.textAlignment = .center
            view.layer.addBorder(edge: .top, color: UIColor(hex: "B0413E"), thickness: 0.5)
            view.addSubview(descriptionView!)
        }
        return view
    }
    
    
    static func createCellHeaderView(cellHeaderView: UIView, selectedTest: Test, index: Int, userAnswer: Int?, isCollapsed: Bool) -> UIView {
        let questionNumber = UILabel(frame: CGRect(x: cellHeaderView.bounds.maxX * 0.05, y: cellHeaderView.bounds.maxY * 0, width: cellHeaderView.bounds.maxX * 0.15, height: cellHeaderView.bounds.maxY))
        let correctLabel = UILabel(frame: CGRect(x: cellHeaderView.bounds.maxX * 0.25, y: cellHeaderView.bounds.maxY * 0, width: cellHeaderView.bounds.maxX * 0.5, height: cellHeaderView.bounds.maxY))
        let expandLabel = UILabel(frame: CGRect(x: cellHeaderView.bounds.maxX * 0.80, y: cellHeaderView.bounds.maxY * 0, width: cellHeaderView.bounds.maxX * 0.15, height: cellHeaderView.bounds.maxY))
        
        questionNumber.text = "\(index+1)/40"
        questionNumber.textColor = UIColor(hex: "B0413E")
        questionNumber.adjustsFontSizeToFitWidth = true
        questionNumber.textAlignment = .center
        
        if let answer = userAnswer {
            switch answer {
            case -1 : correctLabel.text = NSLocalizedString("Not answered", comment: "comment")
                correctLabel.textColor = .gray
            case selectedTest.questions[index].correctAnswers[0] : correctLabel.text = NSLocalizedString("Correct!", comment: "comment")
                correctLabel.textColor = .green
            default : correctLabel.text = NSLocalizedString("Fail!", comment: "comment")
                correctLabel.textColor = .red
            }
            correctLabel.adjustsFontSizeToFitWidth = true
            correctLabel.textAlignment = .center
        }

        expandLabel.text = isCollapsed ? "▽" : "△"
        expandLabel.textColor = UIColor(hex: "B0413E")
        expandLabel.adjustsFontSizeToFitWidth = true
        expandLabel.textAlignment = .center
        
        cellHeaderView.addSubview(questionNumber)
        cellHeaderView.addSubview(correctLabel)
        cellHeaderView.addSubview(expandLabel)
        cellHeaderView.layer.addBorder(edge: .top, color: UIColor(hex: "B0413E"), thickness: 1.2)
        return cellHeaderView
    }
}
