//
//  Question.swift
//  IQ Test
//
//  Created by Admin on 19.08.17.
//  Copyright © 2017 Nikita. All rights reserved.
//

import Foundation

class Question {
    var questionNumber = -1
    var answersCount = 0
    var correctAnswersCount = 0
    var questionText: String?
    var questionPicture: String?
    var answers = [Answer]()
    var answersLayout = [Int]()
    var correctAnswers: [Int] = []
    var description: String?
    var questionLayout = "V"
}

class Answer {
    var answerText: String?
    var answerPict: String?
}
