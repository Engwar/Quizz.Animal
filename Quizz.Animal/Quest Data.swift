//
//  Quest Data.swift
//  Quizz.Animal
//
//  Created by Igor Shelginskiy on 12/10/2018.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponsType
    var answers: [Answer]
}

enum ResponsType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}


enum AnimalType: Character {
    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog: return "You are dogy because you like party and so society"
        case .cat: return " You like live by youself, you like walk by youself"
        case .rabbit: return "You like all fluffy. You are full of energy"
        case .turtle: return " You are so clever and going to you goal, slowly but purposely"
            
        }
    }
}
