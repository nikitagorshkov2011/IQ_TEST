//
//  QuestionViewController.swift
//  IQ Test
//
//  Created by Admin on 09.08.17.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    //@IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var buttonPrev: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonMid: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var questionView: QuestionView?
    
    var answerButtons = [Int:UIButton]()
    
    var currentTestNumber: String? {
        didSet {
            currentTest = Test().parse(currentTestNumber!)
        }
    }
    var currentTest: Test? {
        didSet {
            questions = currentTest!.questions
        }
    }
    var questions = [Question]()
    var userAnswers = Array(repeating: -1, count: 40)
    
    
    var currentQuestion: Int = 0
    var selectedAnswer: Int = -1
    
    weak var timer = Timer()
    var seconds  = 180
    var isTimerOn = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //currentQuestionLabel.text = String(currentQuestion + 1) + "/40"
        timerLabel.text = "3:00"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        assignbackground()
        addSwipes()
        addNavigationButtons()
        printQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func createAnswerButtons () {    //Creating answer buttons in rectangles
        let rects = AnswerView.createRectsForButtons(view: view, buttonsInRows: questions[currentQuestion].answersLayout)
        for i in 0..<rects.count {
            answerButtons[i] = AnswerView.createButtonInRect(rects[i])
            answerButtons[i]?.addTarget(self, action: #selector(buttonTaped), for: .touchUpInside)
            let contentRect =  CGRect(x: (answerButtons[i]?.bounds.maxX)! * 0.1, y: (answerButtons[i]?.bounds.maxY)! * 0.1, width: (answerButtons[i]?.bounds.maxX)! * 0.8, height: (answerButtons[i]?.bounds.maxY)! * 0.8)
            
            if let image = questions[currentQuestion].answers[i].answerPict {
                
                var imageView = UIImageView(frame: contentRect)
                if let bundlePath = Bundle.main.path(forResource: image, ofType: "png", inDirectory: NSLocalizedString("drawable-en", comment: "comment")){
                    imageView.image = UIImage(contentsOfFile: bundlePath)?.withRenderingMode(.alwaysOriginal)
                }
                imageView.contentMode = .scaleAspectFit
                answerButtons[i]?.imageView?.contentMode = .scaleAspectFit
                answerButtons[i]?.addSubview(imageView)
                imageView = UIImageView()
                
            } else {
                
                var textView = UILabel(frame: contentRect)
                textView.text = questions[currentQuestion].answers[i].answerText?.capitalizingFirstLetter()
                textView.textAlignment = .center
                textView.numberOfLines = 0
                answerButtons[i]?.addSubview(textView)
                textView = UILabel()
            }
            self.view.addSubview(answerButtons[i]!)
        }
        
    }
    
    func createQuestion() {
        questionView = QuestionView(frame: CGRect(x: view.bounds.maxX * 0.1 ,y: view.bounds.maxY * 0.1 , width: view.bounds.maxX * 0.8 , height: view.bounds.maxY * 0.375))
        self.view.addSubview(questionView!)
        
        questionView = QuestionView.createQuestionView(view: questionView, test: currentTest, questionNumber: currentQuestion)
    }
    
    func addSwipes() {
        let swipe_next = UISwipeGestureRecognizer(target: self, action: #selector (submit))
        let swipe_prev = UISwipeGestureRecognizer(target: self, action: #selector (prev))
        
        swipe_next.direction = .left
        swipe_prev.direction = .right
        self.view.addGestureRecognizer(swipe_next)
        self.view.addGestureRecognizer(swipe_prev)
    }
    
    func addNavigationButtons() {
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: NSLocalizedString("BACK", comment: "comment"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        let newBackButtonRight = UIBarButtonItem(title: NSLocalizedString("FINISH", comment: "comment"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(finish))
        self.navigationController?.navigationBar.tintColor = UIColor(hex: "FFE8C2")
        self.navigationItem.leftBarButtonItem = newBackButton
        self.navigationItem.rightBarButtonItem = newBackButtonRight
    }
    
    func assignbackground(){
        
        let colorView = UIView(frame: view.bounds)
        let innerColorView = UIView(frame: CGRect(x: colorView.bounds.minX + 10, y: colorView.bounds.maxY * 0.1, width: colorView.bounds.maxX - 20, height: colorView.bounds.maxY * 0.9 - 10))
        colorView.backgroundColor = UIColor(hex: "BD615F")
        innerColorView.backgroundColor = UIColor(hex: "FFE8C2")
        innerColorView.layer.cornerRadius = 10
        colorView.addSubview(innerColorView)
        view.addSubview(colorView)
        self.view.sendSubview(toBack: colorView)
        
        timerLabel.textColor = UIColor(hex: "FFE8C2")
        buttonMid.setTitleColor(UIColor(hex: "B0413E"), for: .normal)
        buttonMid.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonMid.titleLabel?.numberOfLines = 0
        buttonMid.titleLabel?.textAlignment = .center
        buttonNext.setTitleColor(UIColor(hex: "B0413E"), for: .normal)
        buttonPrev.setTitleColor(UIColor(hex: "B0413E"), for: .normal)
        
        for i in [21, 22] {
            if let button: UIButton = self.view.viewWithTag(i) as? UIButton {
                button.setTitleColor(UIColor(hex: "BD615F"), for: .normal)
            }
        }
    }
    
    @objc func back(sender: UIBarButtonItem) {
        let alert  =  UIAlertController(title: NSLocalizedString("Back", comment: "comment"), message: NSLocalizedString("Really want to get back?", comment: "comment"), preferredStyle:  UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "comment"), style: UIAlertActionStyle.default, handler: { (action) in
            self.performSegue(withIdentifier: "unwindToHomeVC", sender: sender) }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "comment"), style: UIAlertActionStyle.default, handler: { (action) in }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func finish(sender: UIBarButtonItem) {
        let alert  =  UIAlertController(title: NSLocalizedString("Finish", comment: "comment"), message: NSLocalizedString("Want to see results?", comment: "comment"), preferredStyle:  UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "comment"), style: UIAlertActionStyle.default, handler: { (action) in
            self.performSegue(withIdentifier: "finish", sender: sender) }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Not now", comment: "comment"), style: UIAlertActionStyle.default, handler: { (action) in }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func updateTimer () {
        seconds -= 1
        if(seconds - seconds/60*60>=10){
            timerLabel.text = String(seconds/60) + ":" + String(seconds - seconds/60*60)
        }
        else {
            timerLabel.text = String(seconds/60) + ":0" + String(seconds - seconds/60*60)
        }
        if(seconds==0) {
            performSegue(withIdentifier: "finish", sender: self)
        }
    }
    
    func printQuestion() {
        
        //currentQuestionLabel.text = String(currentQuestion+1) + "/40"
        
        buttonPrev.isHidden=false
        buttonNext.isHidden=false
     
        
        if (currentQuestion==0) {
            buttonPrev.isHidden=true
        }
        if (currentQuestion >= questions.count-1) {
            buttonNext.isHidden=true
        }
        
        for button in answerButtons.values {
            button.removeFromSuperview()
        }
        questionView?.removeFromSuperview()
        answerButtons = [:]
        
        createQuestion()
        createAnswerButtons()
            
        if( userAnswers[currentQuestion] > -1) {
                answerButtons[userAnswers[currentQuestion]]?.layer.borderWidth = 3
        }
    }
    
    @objc func buttonTaped(_ sender: UIButton) {
        for (key,_) in answerButtons {
            answerButtons[key]?.layer.borderWidth = 0.75
            if (sender==answerButtons[key]) {
               userAnswers[currentQuestion] = key
                selectedAnswer = key
            }
        }
        sender.layer.borderWidth = 3
    
        
        if (!userAnswers.contains(-1)) {
            buttonMid.setTitle("Finish", for:.normal)
        }
    }
    
    @IBAction func submit(_ sender: UIButton) {
      if (currentQuestion < questions.count-1) {
            currentQuestion += 1
            printQuestion()
        }
    }
    
    @IBAction func prev(_ sender: UIButton) {
        
        if (currentQuestion > 0) {
            currentQuestion -= 1
            printQuestion()
        }
    }
    
    @IBAction func midButtontapped(_ sender: UIButton) {
        
        if sender.currentTitle != NSLocalizedString("Finish", comment: "comment") {
            for i in 1...userAnswers.count {
                if i + currentQuestion > userAnswers.count - 1 {
                    currentQuestion -= userAnswers.count
                }
                if userAnswers[i + currentQuestion] == -1 {
                    currentQuestion += i
                    break
                }
            }
            printQuestion()
            
        } else {
                performSegue(withIdentifier: "finish", sender:sender)
        }
    }
    
    func checkRecords(_ test: Test, _ score: Int) {
        let defaults = UserDefaults.standard
        var records = defaults.object(forKey: "RecordsForTests") as? [String : String] ?? [String : String]()
        if let currentTestRecord = records["Test "+(currentTest?.testNumber)!] {
            if score > Int(currentTestRecord.components(separatedBy: ";")[0])! {
                records["Test "+(currentTest?.testNumber)!] = "\(score);\(timerLabel.text!)"
            }
        } else {
            records["Test "+(currentTest?.testNumber)!] = "\(score);\(timerLabel.text!)"
        }
        defaults.set(records, forKey: "RecordsForTests")
    }
    
    func testfunc (_ test: Int) -> Int {
        return 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let resultViewController = segue.destination as? ResultViewController{
            
            var resultText = ""
            var finishScore = 0
            
            for i in 0...39 {
                finishScore += questions[i].correctAnswers[0] == userAnswers[i] ? 1 : 0
            }
            
            if(seconds==0) {
                resultText = NSLocalizedString("Your time is over ⏱\n\n", comment: "comment")
            }
            let result = String(70 + finishScore*2)
            checkRecords(currentTest!, finishScore)
            resultViewController.text = resultText + NSLocalizedString("You answered correctly on", comment: "comment") + " \(finishScore)" + NSLocalizedString("/40\nYour IQ -", comment: "comment") + " \(result)"
            resultViewController.selectedTest = currentTest
            resultViewController.userAnswers = userAnswers
        }
        timer!.invalidate()
    }

    
}
