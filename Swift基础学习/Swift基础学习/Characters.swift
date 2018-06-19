//
//  Characters.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/13.
//  Copyright © 2018年 Lincoln. All rights reserved.
//

import Foundation

enum GameCharacterType {
    case elf
    case giant
    case wizard
}

public protocol GameCharacter {
    var name: String { get }
    var hitPoints: Int { get set }
    var attackPoints: Int { get }
}

class Giant: GameCharacter {
    let name = "Giant"
    var hitPoints = 10
    let attackPoints = 3
}

class Wizard: GameCharacter {
    let name = "Wizard"
    var hitPoints = 5
    let attackPoints = 5
}

class Elf: GameCharacter {
    let name = "Elf"
    var hitPoints = 3
    let attackPoints = 10
}

struct GameCharacterFactory {
    public static func make(ofType type: GameCharacterType) -> GameCharacter {
        switch type {
        case .giant:
            return Giant()
        case .wizard:
            return Wizard()
        case .elf:
            return Elf()
        }
    }
}

public func battle(_ character1: GameCharacter,  vs character2: GameCharacter) {
    var character1 = character1
    var character2 = character2
    character2.hitPoints -= character1.attackPoints
    
    if character2.hitPoints <= 0 {
        print("\(character2.name) defeated!")
        return
    }
    
    character1.hitPoints -= character2.attackPoints
    
    if character1.hitPoints <= 0 {
        print("\(character1.name) defeated!")
    } else {
        print("Both players still active!")
    }
}
