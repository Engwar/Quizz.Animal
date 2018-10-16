//
//  QuestionViewController.swift
//  Quizz.Animal
//
//  Created by Igor Shelginskiy on 11/10/2018.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multiLabels: [UILabel]!
    @IBOutlet var multiSwitches: [UISwitch]!
    
    @IBOutlet weak var rangeStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let answers = questions[questionIndex].answers
        
        for index in 0..<singleButtons.count {
            if singleButtons[index] == sender {
                answersChosen.append(answers[index])
                break
            }
        }
       nextQuestion()
    }
    
    @IBAction func multiButtonPressed() {
        let answers = questions[questionIndex].answers
        
        for index in 0..<multiSwitches.count {
            if multiSwitches[index].isOn {
                answersChosen.append(answers[index])
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedButtonPressed() {
        let answers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(answers.count - 1)))
        answersChosen.append(answers[index])
        
        nextQuestion()
    }
    
    var questions: [Question] = [
        Question(text: "What kind of food do you like",
                 type: .single,
                 answers: [
                    Answer(text: "Meat", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrot", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
            ]
        ),
        Question(text: "What do you like to do",
                 type: .multiple,
                 answers: [
                    Answer(text: "Swim", type: .turtle),
                    Answer(text: "Sleep", type: .cat),
                    Answer(text: "Jump", type: .rabbit),
                    Answer(text: "Eat", type: .dog),
                    ]
        ),
        Question(text: "Do you like drive a car",
                 type: .ranged,
                 answers: [
                    Answer(text: "Hate", type: .cat),
                    Answer(text: "Nervous", type: .rabbit),
                    Answer(text: "Passive", type: .turtle),
                    Answer(text: "Awesome", type: .dog),
                    ]
        ),
        ]
    
    var questionIndex = 0 // счетчик вопросов
    
    var answersChosen: [Answer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangeStackView.isHidden = true
        
        
        let question = questions[questionIndex]
        let answers = question.answers
        let progress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question № \(questionIndex + 1)"
        questionLabel.text = question.text
        progressView.setProgress(progress, animated: true)

        switch  question.type  {
        case .single:
            updateSingleStack(using: answers)
        case .multiple:
            updateMultipleStack(using: answers)
        case .ranged:
            updateRangedStack(using: answers)
        }
    }
    
    func updateSingleStack(using answers:[Answer]) {
        singleStackView.isHidden = false
        for index in 0..<answers.count {
            singleButtons[index].setTitle(answers[index].text, for: .normal)
        }
    }
    func updateMultipleStack(using answers:[Answer]) {
        multipleStackView.isHidden = false
        for index in 0..<answers.count {
            multiLabels[index].text = answers[index].text
            multiSwitches[index].isOn = false
        }
    }
    func updateRangedStack(using answers:[Answer]) {
        rangeStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabels[0].text = answers.first?.text
        rangedLabels[1].text = answers.last?.text
    }
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController // по умолчанию это вьюконтроллер, нам надо привести его к резалтсвьюконтроллер (восклицательный знак потому что мы уверены что переход по сегвею будет в резалтсвьюкоонтроллер
            resultsViewController.responces = answersChosen
        }
    }
}
