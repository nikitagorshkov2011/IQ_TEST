//
//  File.swift
//  IQ Test
//
//  Created by Admin on 19.08.17.
//  Copyright © 2017 Nikita. All rights reserved.
//

import Foundation

class Test {
    var testNumber: String?
    let questionsCount = 40
    var questions: [Question] = []
    
    
     func parse(_ testName: String) -> Test {
        let test = Test()
        test.testNumber = String(testName.characters.last!)
        
        let questionData = NSLocalizedString("questions-en.txt", comment: "comment").contentsOrBlank().components(separatedBy: "TESTEND").filter { $0.contains("T\(test.testNumber!)Q1") }[0].components(separatedBy: "T\(test.testNumber!)Q").filter { $0 != "\n" && $0 != ""}
        
        let answersData = NSLocalizedString("answers-en.txt", comment: "comment").contentsOrBlank().components(separatedBy: "TESTEND").filter { $0.contains("\(test.testNumber!)~40~") }[0].components(separatedBy: "\n").filter { $0 != "" }
        
        
        for qstn in questionData {
            let lines = qstn.components(separatedBy: "\n")
            
            let question = Question()
            question.questionNumber = Int(lines[0])!
            
            // work with AnswersDATA
            let answersUsefulData = answersData[question.questionNumber-1].components(separatedBy: "\(test.testNumber!)~\(question.questionNumber)~")[1]
            var correctAnswersData = ""
            if answersUsefulData.contains("~") {
                question.description = answersUsefulData.components(separatedBy: "~")[1]
                correctAnswersData = answersUsefulData.components(separatedBy: "~")[0]
            } else {
                correctAnswersData = answersUsefulData
            }
            for correctAnswer in correctAnswersData.components(separatedBy: ",") {
                question.correctAnswers.append(Int(correctAnswer)! - 1)
            }
            
            //work with QuestionsDATA
            for line in lines {
                if line.contains("ANSWER_COUNT"){
                    let count = line.components(separatedBy: ":")[1]
                    question.answersCount = Int(count.components(separatedBy: ";")[0])!
                    question.correctAnswersCount = Int(count.components(separatedBy: ";")[1])!
                }
                if line.contains("INPUT_TEXT"){
                    question.questionText = line.components(separatedBy: ":")[1]
                }
                if line.contains("INPUT_PICT"){
                    let questionContent = line.components(separatedBy: ":")[1].components(separatedBy: ";")
                    question.questionPicture = questionContent[0]
                    if questionContent.count > 1 {
                        question.questionLayout = questionContent[1]
                    }
                }
                if line.contains("ANSWER_PICT") || line.contains("ANSWER_TEXT"){
                    let ans = line.components(separatedBy: ":")[1].components(separatedBy: ";")
                    for an in ans {
                        let answer = Answer()
                        if line.contains("ANSWER_PICT") {
                            answer.answerPict = an
                        } else {
                            answer.answerText = an
                        }
                        question.answers.append(answer)
                    }
                    question.answersLayout.append(ans.count)
                }
                
            }
            test.questions.append(question)
        }
        return test
    }

}
