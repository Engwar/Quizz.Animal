//
//  ResultsViewController.swift
//  Quizz.Animal
//
//  Created by Igor Shelginskiy on 11/10/2018.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    var responces: [Answer]! //восклицательный знак это опционал (forced unwrapped), и означает, что мы уверены, что он будет не пустой когда мы к нему обратимся. Иначе будет ошибка времени исполнения

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculateResult()
    }
    
    func calculateResult() {
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        
        let resposeTypes = responces.map {$0.type}
        
        for response in resposeTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        
        let frequencyOfAnswersSorted = frequencyOfAnswers.sorted(by: {
            (pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        
        let mostCommonAnswer = frequencyOfAnswersSorted.first!.key
        
        resultAnswerLabel.text = "You — are \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }

}
