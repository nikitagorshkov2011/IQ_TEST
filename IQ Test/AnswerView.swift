//
//  AnswersView.swift
//  IQ Test
//
//  Created by Admin on 23.08.17.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class AnswerView: UIView{

    static func createButtonInRect ( _ rect: CGRect) -> UIButton { //Creating button for answers in question
        let button = UIButton(frame: rect)
        button.layer.borderWidth = 0.75
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor(hex: "EE9480").cgColor
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }

    static func createRectsForButtons(view: UIView, buttonsInRows: [Int]) -> [CGRect]{ //Creating rectangles for buttons
        let rows = buttonsInRows.count
        var rectsForButtons = [CGRect]()
        
        for i in 0..<rows {
            let y = view.bounds.midY * 1 + view.bounds.midY * CGFloat(Double(i) / Double(rows)) * 0.75
            for j in 0..<buttonsInRows[i]{
                let x = view.bounds.maxX * 0.08 + view.bounds.maxX * CGFloat(Double(j) / Double(buttonsInRows[i])) * 0.84
                let width = view.bounds.maxX * CGFloat(1 / Double(buttonsInRows[i])) * 0.84
                let height = view.bounds.midY * CGFloat(1 / Double(rows)) * 0.75
                rectsForButtons += [CGRect(x: x ,y: y , width: width , height: height)]
            }
        }
        return rectsForButtons
    }
    
    
    static func setAnswersView(view: UIView, selectedTest: Test, index: Int, userAnswer: Int?) -> UIView {
        
        var userAnswerView: UIView?
        var correctAnswerView: UIView?
        
        let answers = userAnswer != nil ? [userAnswer!, selectedTest.questions[index].correctAnswers[0]] : [selectedTest.questions[index].correctAnswers[0]]
        
        var rectsForAnswers = [CGRect]()
        
        let x = userAnswer != nil ? [view.bounds.maxX * 0, view.bounds.maxX * 0.55] : [view.bounds.maxX * 0.275]
        let y = view.bounds.maxY * 0.05
        let width = view.bounds.maxX * 0.45
        let height = view.bounds.maxY * 0.9
        
        var answerViews = [UIView]()
        
        if userAnswer != nil {
            userAnswerView = UIView(frame: CGRect(x: x[0] ,y: y , width: width , height: height))
            correctAnswerView = UIView(frame: CGRect(x: x[1] ,y: y , width: width , height: height))
            answerViews += [userAnswerView!]
        } else {
            correctAnswerView = UIView(frame: CGRect(x: x[0] ,y: y , width: width , height: height))
        }
        answerViews += [correctAnswerView!]
        
        func addTextLabel(contentRect: UIView, text: String) {
            let answerContent = UILabel(frame: CGRect(x: contentRect.bounds.maxX * 0.1, y: contentRect.bounds.maxY * 0.1, width: contentRect.bounds.maxX * 0.8, height: contentRect.bounds.maxY * 0.8))
            answerContent.adjustsFontSizeToFitWidth = true
            answerContent.text = text
            answerContent.textAlignment = .center
            answerContent.numberOfLines = 0
            
            contentRect.addSubview(answerContent)
        }
        
        func addImageView(contentRect: UIView, image: String) {
            let answerContent = UIImageView(frame: CGRect(x: contentRect.bounds.maxX * 0.1, y: contentRect.bounds.maxY * 0.1, width: contentRect.bounds.maxX * 0.8, height: contentRect.bounds.maxY * 0.8))
            if let bundlePath = Bundle.main.path(forResource: image, ofType: "png", inDirectory: "drawable-en"){
                answerContent.image = UIImage(contentsOfFile: bundlePath)?.withRenderingMode(.alwaysOriginal)
                answerContent.contentMode = .scaleAspectFit
            }
            contentRect.addSubview(answerContent)
        }
        
        for (i,answerView) in answerViews.enumerated() {
            
            let answerLabel = UILabel(frame: CGRect(x: answerView.bounds.minX, y: answerView.bounds.minY, width: answerView.bounds.maxX, height: answerView.bounds.maxY * 0.2))
            answerLabel.textAlignment = .center
            answerLabel.text = answerViews.count > 1 && i == 0 ? NSLocalizedString("Your answer:", comment: "comment") : NSLocalizedString("Correct answer:", comment: "comment")
            
            let contentRect =  UIView(frame: CGRect(x: answerView.bounds.minX, y: answerView.bounds.maxY * 0.25, width: answerView.bounds.maxX, height: answerView.bounds.maxY * 0.75))
            
            if answers[i] != -1 {
                
                if let image = selectedTest.questions[index].answers[answers[i]].answerPict {
                    addImageView(contentRect: contentRect, image: image)
                } else {
                    addTextLabel(contentRect: contentRect, text: selectedTest.questions[index].answers[answers[i]].answerText!.capitalizingFirstLetter())
                }
                
                if selectedTest.questions[index].correctAnswers[0] == answers[i] {
                    contentRect.layer.borderColor = UIColor.green.cgColor
                } else {
                    contentRect.layer.borderColor = UIColor.red.cgColor
                }
            } else {
                addTextLabel(contentRect: contentRect, text: NSLocalizedString("Not answered", comment: "comment"))
                contentRect.layer.borderColor = UIColor.gray.cgColor
            }
            
            contentRect.layer.cornerRadius = 15
            contentRect.layer.borderWidth = answerViews.count == 2 ? 1 : 0
            answerView.addSubview(answerLabel)
            answerView.addSubview(contentRect)
            
            view.addSubview(answerView)
            
        }
        userAnswerView = nil
        correctAnswerView = nil
        return view
    }
    
    
}
