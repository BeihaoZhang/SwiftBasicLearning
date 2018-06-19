//
//  ErrorHandling.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/15.
//  Copyright © 2018年 Lincoln. All rights reserved.
//

import Foundation

struct PetHouse {
    let squareFeet: Int
    
    // 可选初始化方法
    init?(squareFeet: Int) {
        if squareFeet < 1 {
            return nil
        }
        self.squareFeet = squareFeet
    }
}


//class Pet2 {
//    var breed: String?
//
//    init(breed: String? = nil) {
//        self.breed = breed
//    }
//}

//class Person2 {
//    let pet: Pet
//
//    init(pet: Pet) {
//        self.pet = pet
//    }
//}

class Toy {
    enum Kind {
        case ball
        case zombie
        case bone
        case mouse
    }
    
    enum Sound {
        case squeak
        case bell
    }
    
    let kind: Kind
    let color: String
    let sound: Sound?
    // sound: Sound? = nil 有两个初始化方法，有 sound 和 没有 sound
    // sound: Sound? 只有一个初始化方法
    init(kind: Kind, color: String, sound: Sound? = nil) {
        self.kind = kind
        self.color = color
        self.sound = sound
    }
}

class Pet2 {
    enum Kind {
        case dog
        case cat
        case guineaPig
    }
    
    let name: String
    let kind:Kind
    let favoriteToy: Toy?
    
    init(name: String, kind: Kind, favoriteToy: Toy? = nil) {
        self.name = name
        self.kind = kind
        self.favoriteToy = favoriteToy
    }
}

class Person2 {
    let pet: Pet2?
    
    init(pet: Pet2? = nil) {
        self.pet = pet
    }
}

class ErrorHandling {
    func myPrint() {
        let tooSmall = PetHouse(squareFeet: 0) // nil
        let house = PetHouse(squareFeet: 1) // Optional(Pethouse)

        let janie = Person2(pet: Pet2(name: "Delia", kind: .dog, favoriteToy: Toy(kind: .ball, color: "Purple", sound: .bell)))

        let tammy = Person2(pet: Pet2(name: "Evil Cat Overlord", kind: .cat, favoriteToy: Toy(kind: .mouse, color: "Orange")))
        let felipe = Person2()
        
        // 可选链，只要有一个为nil，后面都为nil
        if let sound = janie.pet?.favoriteToy?.sound {
            print("Sound \(sound)")
        } else {
            print("No sound.")
        }
        
        if let sound = tammy.pet?.favoriteToy?.sound {
            print("Sound \(sound)")
        } else {
            print("No sound.")
        }
        
        if let sound = felipe.pet?.favoriteToy?.sound {
            print("Sound \(sound)")
        } else {
            print("No sound.")
        }
    }
}

class ErrorThrows {
    class Pastry {
        let flavor: String
        var numberOnHand: Int
        
        init(flavor: String, numberOnHand: Int) {
            self.flavor = flavor
            self.numberOnHand = numberOnHand
        }
    }
    
    enum BakeryError:Error {
        case tooFew(numberOnHand: Int)
        case doNotSell
        case wrongFlavor
    }
    
    class Bakery {
        var itemsForSale = [
            "Cookie": Pastry(flavor: "ChocolateChip", numberOnHand: 20),
            "PopTart": Pastry(flavor: "WildBerry", numberOnHand: 13),
            "Donut" : Pastry(flavor: "Sprinkles", numberOnHand: 24),
            "HandPie": Pastry(flavor: "Cherry", numberOnHand: 6)
        ]
        func orderPastry(item: String,
                         amountRequested: Int,
                         flavor: String) throws -> Int {
            guard let pastry = itemsForSale[item] else {
                throw BakeryError.doNotSell
            }
            guard flavor == pastry.flavor else {
                throw BakeryError.wrongFlavor
            }
            guard amountRequested <= pastry.numberOnHand else {
                throw BakeryError.tooFew(numberOnHand: pastry.numberOnHand)
            }
            pastry.numberOnHand -= amountRequested
            
            return pastry.numberOnHand
        }
    }
    
    func myTest() {
        let bakery = Bakery()
        /// 这样是编译不通过的，因为这个方法中有throws，你需要对它可能的error做处理
        // bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")
        
        /// 正确的做法
        do {
            let tt = try bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")
        } catch BakeryError.doNotSell {
            print("Sorry, but we don't sell this item")
        } catch BakeryError.wrongFlavor {
            print("Sorry, but we don't carry this flavor")
        } catch BakeryError.tooFew {
            print("Sorry, we don't have enough items to fulfill your order")
        } catch { // 一定要穷尽所有的错误类型。因为BakeryError继承自Error，所以还需要对Error的错误做处理
            
        }
        // try?：如果出现异常，会返回nil
        let remaining = try? bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")
        
        
        do {
            try bakery.orderPastry(item: "Cookie", amountRequested: 1, flavor: "ChocolateChip")
        } catch {
            fatalError()
        }
        // try!，一旦异常，立刻终止程序。下面的代码和上面是等价的
        let remaining2 = try! bakery.orderPastry(item: "Cookie", amountRequested: 1, flavor: "ChocolateChip")
    }
}

class AdvancedErrorHandling {
    enum Direction {
        case left
        case right
        case forward
    }
    
    enum PugBotError: Error {
        case invalidMove(found: Direction, expected: Direction)
        case endOfPath
    }
    
    class PugBot {
        let name: String
        let correctPath: [Direction]
        private var currentStepInPath = 0
        
        init(name: String, correctPath: [Direction]) {
            self.correctPath = correctPath
            self.name = name
        }
        
        func turnLeft() throws {
            guard currentStepInPath < correctPath.count else {
                throw PugBotError.endOfPath
            }
            let nextDirection = correctPath[currentStepInPath]
            guard nextDirection == .left else {
                throw PugBotError.invalidMove(found: .left, expected: nextDirection)
            }
            currentStepInPath += 1
        }
        
        func turnRight() throws {
            guard currentStepInPath < correctPath.count else {
                throw PugBotError.endOfPath
            }
            let nextDirection = correctPath[currentStepInPath]
            guard nextDirection == .right else {
                throw PugBotError.invalidMove(found: .right, expected: nextDirection)
            }
            currentStepInPath += 1
        }
        
        func moveForward() throws {
            guard currentStepInPath < correctPath.count else {
                throw PugBotError.endOfPath
            }
            let nextDirection = correctPath[currentStepInPath]
            guard nextDirection == .forward else {
                throw PugBotError.invalidMove(found: .forward, expected: nextDirection)
            }
            currentStepInPath += 1
        }
        func reset() {
            currentStepInPath = 0
        }
    }
    
    func myTest() {
        let pug = PugBot(name: "Pug", correctPath: [.forward, .left, .forward, .right])
        // 把可能出异常的地方都放在这个函数里，然后在do catch中统一try
        func goHome() throws {
            try pug.moveForward()
            try pug.turnLeft()
            try pug.moveForward()
            try pug.turnRight()
        }
        do {
            try goHome()
        } catch {
            print("PugBot failed to get home.")
        }
        
        
        pug.reset()
        moveSafely (goHome)
        
        pug.reset()
        moveSafely {
            try pug.moveForward()
            try pug.turnLeft()
            try pug.moveForward()
            try pug.turnRight()
        }
    }
    
    /// Handling multiple errors
    // 传入一个包含throws的闭包。
    // 既抛出异常，也处理异常。在闭包中抛出异常，然后在闭包外面处理异常。
    func moveSafely(_ movement: () throws -> ()) -> String {
        do {
            try movement()
            return "Completed operation successfully."
        } catch PugBotError.invalidMove(let found, let expected) {
            return "The PugBot was supposed to move \(expected), but moved \(found) instead."
        } catch PugBotError.endOfPath {
            return "The PugBot tried to move past the end of the path."
        } catch {
            return "An unknown error occurred"
        }
    }
    
    /// rethrows。自己处理异常，或者重新抛出该异常。
    func perform(times: Int, movement: () throws -> ()) rethrows {
        for _ in 1...times {
            try movement()
        }
    }
    
}

