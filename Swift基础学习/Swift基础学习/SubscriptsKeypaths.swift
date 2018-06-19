//
//  SubscriptsKeypaths.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/14.
//  Copyright © 2018年 Lincoln. All rights reserved.
//

import Foundation
import CoreGraphics

/*
subscript(parameterList) -> ReturnType {
    get {
        // return someValue of ReturnType
    }
    
    set(newValue) {
        // set someValue of ReturnType to newValue
    }
}
*/

////////////////////Subscript 下标////////////////////////////
class Person {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

extension Person {
    // 设置下标
    subscript(property key: String) -> String? {
        switch key {
        case "name":
            return name
        case "age":
            return "\(age)"
        default:
            return nil
        }
    }
}

class Subscripts {
    func myPrint() {
        let me = Person(name: "Cosmin", age: 31)
        let name = me[property: "name"]
        let age = me[property: "age"]
        print(name, age)
    }
}

////////////////////Keypaths////////////////////////////
class Tutorial {
    let title: String
    let author: Person
    let type: String
    let publishDate: Date
    
    init(title: String, author: Person, type: String, publishDate: Date) {
        self.title = title
        self.author = author
        self.type = type
        self.publishDate = publishDate
    }
}

class Keypaths {
    func myPrint() {
        let me = Person(name: "Beihao", age: 31)
        let tutorial = Tutorial(title: "Object Oriented Programming in Swift", author: me, type: "Swift", publishDate: Date())
        // KeyPath类型
        let title = \Tutorial.title
        let tutorialTitle = tutorial[keyPath: title]
        print(tutorialTitle)
        
        // appending keypaths 获取值
        let authorPath = \Tutorial.author
        let authorNamePath = authorPath.appending(path: \.name)
        let tutorialAuthor = tutorial[keyPath: authorNamePath]
        print(tutorialAuthor)
        
        // setting properties 修改值
        let jukebox = Jukebox(song: "Nothing else matters")
        let song = \Jukebox.song
        jukebox[keyPath: song] = "Stairway to heaven"
        
    }
}

class Jukebox {
    var song: String
    
    init(song: String) {
        self.song = song
    }
}

//////////////challenge 1
extension Array {
    subscript(index index: Int) -> (String, String)? {
        guard let value = self[index] as? Int else {
            return nil
        }
        
        switch (value >= 0, abs(value) % 2) {
            case (true, 0):
            return ("positive", "even")
            case (true, 1):
            return ("positive", "odd")
            case (false, 0):
            return ("negative", "even")
            case (false, 1):
            return ("negative", "odd")
            default:
            return nil
        }
    }
}/*
 let numbers = [-2, -1, 0, 1, 2]
 numbers[index: 0]
 numbers[index: 1]
 numbers[index: 2]
 numbers[index: 3]
 numbers[index: 4]
 */

//////////////challenge 2
// Write a subscript that computes the character at a certain index in a string.

extension String {
    subscript(index: Int) -> Character? {
        // 先判断index是否超出了范围
        guard (0..<count).contains(index) else {
            return nil
        }
        return self[self.index(startIndex, offsetBy: index)]
    }
}/*
 let me = "Cosmin"
 me[3]
 */

infix operator **
func **<T: FloatingPoint>(base: T, power: Int) -> T {
    precondition(power >= 2)
    var result = base
    for _ in 2...power {
        result *= base
    }
    return result
}/*
 let exponent = 2
 let baseDouble = 2.0
 var resultDouble = baseDouble ** exponent
 let baseFloat: Float = 2.0
 var resultFloat = baseFloat ** exponent
 let base80: Float80 = 2.0
 var result80 = base80 ** exponent
 let baseCG: CGFloat = 2.0
 var resultCG = baseCG ** exponent
 */

