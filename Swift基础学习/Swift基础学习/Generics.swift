//
//  Generics.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/11.
//  Copyright © 2018年 Lincoln. All rights reserved.
//

import Foundation

// try 0: values driving values
enum PetKind {
    case cat
    case dog
}

struct KeeperKind {
    var keeperOf: PetKind
}

/* try 1: manually mirrored types
class Cat {}
class Dog {}

class KeeperForCats {}
class KeeperForDogs {}
*/

/* try 2: generics to establish type relationship
 class Cat {}
 class Dog {}
 
 class Keeper<Animal> {}
 
 var aCatKeeper = Keeper<Cat>()
//var aKeeper = Keeper() // 编译错误 Generic parameter 'Animal' could not be inferred
*/

/* try 3: add identity. now we have collections
 */
class Cat {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Dog {
    var name: String
    init(name: String) {
        self.name = name
    }
}

protocol Pet {
    var name: String { get } // all pets respond to a name
}

extension Cat: Pet {}
extension Dog: Pet {}

class Keeper<Animal: Pet> {
    var name: String
    var morningCare: Animal
    var afternoonCare: Animal
    
    init(name: String, morningCare: Animal, afternoonCare: Animal) {
        self.name = name
        self.morningCare = morningCare
        self.afternoonCare = afternoonCare
    }
}

let jason = Keeper(name: "Jason", morningCare: Cat(name: "Whiskers"), afternoonCare: Cat(name: "Sleepy"))

let cats = ["Miss Gray", "Whiskers", "Sleepy"].map { Cat(name: $0) }
let dogs = ["Sparky", "Rusty", "Astro"].map { Dog(name: $0) }
let pets: [Pet] = [Cat(name: "Mittens"), Dog(name: "Yeller")]

func herd(_ pets: [Pet]) {
    pets.forEach {
        print("Come \($0.name)!")
    }
}

// 把函数中需要用到的泛型放在函数名后面位置
func herd<Animal: Pet>(_ pets: [Animal]) {
    pets.forEach {
        print("Here \($0.name)!")
    }
}

func herd<Animal: Dog>(_ dogs: [Animal]) {
    dogs.forEach {
        print("Here \($0.name)! Come here!")
    }
}

//herd(dogs)
//herd(cats)
//herd(pets)

extension Array where Element: Cat {
    func meow() {
        forEach { print("\($0.name) says meow!") }
    }
}

// dogs.meow() // error: 'Dog' is not a subtype of 'Cat'
//cats.meow()

let animalAges: Array<Int> = [2, 5, 7, 9]
//let animalAges: [Int] = [2, 5, 7, 9] // 和上面的等价


let intNames: Dictionary<Int, String> = [42: "forty-two"]
let intNames2: [Int: String] = [42: "forty-two", 7: "seven"]
let intNames3 = [42: "forty-two", 7: "seven"]

enum OptionalDate {
    case none
    case some(Date)
}

enum OptionalString {
    case none
    case some(String)
}

struct FormResults {
    var birthday: OptionalDate
    var lastName: OptionalString
}

// Keep this commented out so we can keep using Swift's Optional type, not our own.
//enum Optional<Wrapped> {
//  case none
//  case some(Wrapped)
//}



class GenericsClass {
    func genericsPrint() {
        let catKeeper = KeeperKind(keeperOf: .cat)
        let dogKeeper = KeeperKind(keeperOf: .dog)
        
        // 枚举形式
        var birthdate: Optional<Date> = .none
        if birthdate == .none {
            // no birthdate
        }
        
        // 可选值形式。可选值就是通过枚举实现的。这是更常见的用法
        var birthdate2: Date? = nil
        if birthdate2 == nil {
            // no birthdate
        }
        
        func swapped<T, U>(_ x: T, _ y: U) -> (U,T) {
            return (y,x)
        }
        
        let newResult = swapped(33, "Jay") // return ("Jay", 33)
//        newResult.0 // String  类型
//        newResult.1 // Int 类型
        
        
        
    }
}


