//
//  PatternMatching.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/14.
//  Copyright © 2018年 Lincoln. All rights reserved.
//
/*
 Swift中where的使用：https://www.jianshu.com/p/50736a304c08
 1. if, guard, while三个语句中where被去掉了，直接使用,相隔就行了
 2. do catch、switch、for in 中可以使用


 */


import Foundation

class PatternMatching {
    func myPrint() {
        // Tuple 元组
        let coordinate = (x: 1, y: 0, z: 0)
        // 这种方式可读性差
        if (coordinate.y == 0) && (coordinate.z == 0) {
            print("along the x-axis")
        }
        // 这种方式与上面的效果一样，但可读性好。需要注意的是这里是赋值操作
        if case (_, 0, 0) = coordinate {
            print("along the x-axis")
        }
        
        let groupSizes = [1, 5, 4, 6, 2, 1, 3]
        for case 1 in groupSizes {
            // 相当于一个filter，当元素中包含1时，执行到这里。所以这里执行2次
            print("Found an individual")
        }
        
        // 第一个例子中，通过值绑定模式 value-binding pattern，来操作数据
        if case (let x, let y, 0) = coordinate {
            print("\(x), \(y)")// 1, 0
        }
        //  也可以将 let 关键字放在外面
        if case let(x, y, 0) = coordinate {
            print("\(x), \(y)")
        }
        
        /* 错误
        if case(x, y, 0) = coordinate {
            print("\(x), \(y)")
        }
         */
        
        let pet = Organism.animal(legs: 4)
        switch pet {
        case .animal(let legs):
            print("Potentially cuddly with \(legs) legs")
        default:
            print("No chance for cuddles")
        }
        
        // is 模式，但不能访问到元素
        let array: [Any] = [15, "George", 2.0]
        for element in array {
            switch element {
                case is String:
                print("Found a string") // 1 time
                default:
                print("Found something else") // 2 times
            }
        }
        
        // as 模式
        for element in array {
            switch element {
                case let text as String:
                    print("Found a string:\(text)") // 1 time
                default:
                    print("Found something else") // 2 times
            }
        }
        
        
    }
    
    func miniExercise() {
        let names: [String?] = ["Michelle", nil, "Brandon", "Christine", nil, "David"]
        // Optional pattern 可选模式
        // 方法一
        for case let name? in names {
            print(name) // 打印4次
        }
        // 方法二
        for case .some(let name) in names {
            print(name) // 4 times
        }
    }
    
    func customTuple() {
        let name = "Bob"
        let age = 23
        // 赋值操作
        if case ("Bob", 23) = (name, age) {
            print("Found the right Bob!")
        }
        
        // 在登录操作中，点击登录时告诉用户哪个字段没有填写
        var username: String?
        var password: String?
        
        switch (username, password) {
        case let (username?, password?):
            print("Success! User: \(username) Pass:\(password)")
        // fallthrough 表示会继续执行下面一个case
        case let (username?, nil):
            print("Password is missing. User:\(username)")
        case let (nil, password?):
            print("Username is missing. Pass:\(password)")
        case (nil, nil):
            print("Both username and password are missing") // Printed!
        }
    }
    
    // 检查可选值是否有值
    func validateOptionalExists() {
        let user: String? = "Bob"
        guard let _ = user else {
            print("There is no user.")
            fatalError()
        }
        print("User exists, but identity not needed.") // Printed!
        
        // 如果不需要值，这种方式更加清晰
        guard user != nil else {
            print("there is no user.")
            fatalError()
        }
    }
    
    func matched() {
        let matched = (1...10 ~= 5)
        if matched {
            print("匹配")
        }
    }
    
}

enum Organism {
    case plant
    case animal(legs: Int)
}

enum Number {
    case integerValue(Int)
    case doubleValue(Double)
    case booleanValue(Bool)
}

class ComplicatedIfStatement {
    
    let a = 5
    let b = 6
    let c: Number? = .integerValue(7)
    let d: Number? = .integerValue(8)
    
    // 回调地狱
    func complicatedOne() {
        
        if a != b {
            if let c = c {
                if let d = d {
                    if case .integerValue(let cValue) = c {
                        if case .integerValue(let dValue) = d {
                            if dValue > cValue {
                                print("a and b are different") // Printed!
                                print("d is greater than c") // printed!
                                print("sum: \(a + b + cValue + dValue)") // 26
                            }
                        }
                    }
                }
            }
        }
    }
    
    // 通过解包和约束值处理
    func simpledOne() {
        if a != b,
           let c = c,
           let d = d,
           case .integerValue(let cValue) = c,
           case .integerValue(let dValue) = d,
            dValue > cValue {
            print("a and b are different") // Printed!
            print("d is greater than c") // printed!
            print("sum: \(a + b + cValue + dValue)") // 26
        }
        
    }
}

class Challenge {
    func challenge1() {
        enum FormField {
            case firstName(String)
            case lastName(String)
            case emailAddress(String)
            case age(Int)
        }
        let minimumAge = 21
        let submittedAge = FormField.age(22)
        
        if case .age(let years) = submittedAge, years > minimumAge {
            print("Welcome!")
        } else {
            print("Sorry, you're too young!")
        }
    }
    
    func challenge2() {
        enum CelestialBody {
            case star
            case planet(liquidWater: Bool)
            case comet
        }
        
        let telescopeCensus = [
            CelestialBody.star,
            CelestialBody.planet(liquidWater: false),
            CelestialBody.planet(liquidWater: true),
            CelestialBody.planet(liquidWater: true),
            CelestialBody.comet
        ]
        
        for case .planet(let water) in telescopeCensus where water {
            print("Found a potentially habitable planet!")
        }
    }
    
    func challenge3() {
        let queenAlbums = [
            ("A Night at the Opera", 1974),
            ("Sheer Heart Attack", 1974),
            ("Jazz", 1978),
            ("The Game", 1980)
        ]
        
        for case (let album, 1974) in queenAlbums {
            print("Queen's album \(album) was released in 1974")
        }
    }
    
    func challenge4() {
        let coordinates = (lat: 192.89483, long: -68.887463)
        
        switch coordinates {
        case (let lat, _) where lat < 0:
            print("In the Southern hemisphere!")
        case (let lat, _) where lat == 0:
            print("Its on the equator!")
        case (let lat, _) where lat > 0:
            print("In the Northern hemisphere!")
        default:
            break
        }
    }
}
