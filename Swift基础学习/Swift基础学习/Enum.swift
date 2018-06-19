//
//  Enum.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/9.
//  Copyright © 2018年 Lincoln. All rights reserved.
//

import Foundation

enum Icon: String {
    case music
    case sports
    case weather
    var filename: String {
        return "\(rawValue).png"
    }
}

enum Coin: Int {
    case penny = 1
    case nickel = 5
    case dime = 10
    case quarter = 25
}

enum Coin2: Int {
    case penny = 1
    case nickel = 5
    // rawValue: 6
    case dime
    // rawValue: 7
    case quarter
}

var balance = 100

enum WithdrawalResult {
    case success(newBalance: Int)
    case error(message: String)
}

enum HTTPMethod {
    case get
    case post(body: String)
}

enum TrafficLight {
    case red, yellow, green
}

enum Math {
    static func factorial(of number: Int) -> Int {
        return (1...number).reduce(1, *)
    }
}

enum Month2: Int {
    case january = 1, february, march, april, may, june, july, august, september, october, november, december
    
    var monthsUntilWinterBreak: Int {
//        return type(of: self).december.rawValue - self.rawValue
//        return Month2.december.rawValue - self.rawValue
        return Month2.december.rawValue - rawValue
    }
    
}

class EnumClass {
    let icon = Icon.weather
    
    func enumPrint() {
        print(icon.rawValue)
        let result = withdraw(amount: 99)
        print(result)
        print(type(of: result))
        
        switch result {
        case .success(let newBalance):
            print("Your new balance is: \(newBalance)")
        case .error(let message):
            print(message)
        }
        
        let request = HTTPMethod.post(body: "Hi, there")
        // 将request赋值给 case .post(let body)。这里说明 guard 的条件判断可以是case类型的
        guard case .post(let body) = request else {
            fatalError("No message was posted")
        }
        print(body)
        
        let trafficLight = TrafficLight.red
        print(trafficLight)
        
        let factorial = Math.factorial(of: 6)
        print(factorial)
        
        var age: Int?
        age = 17
        age = nil
        
        // 可选值包含两个状态值 .some、.none
        switch age {
        case .none:
            print("No value")
        
        case .some(let value):
            print("Get a value: \(value)")
        
        }
        
        let optionalNil: Int? = .none
        // 在可选值中，nil 和 .none 是等价的
        optionalNil == nil // true
        optionalNil == .none // true        
        // let april: Int
        let april = Month2.april.rawValue
        print(april)
        
        monthsUntilWinterBreak(from: .april) // 8
        // 枚举的初始化方法。返回一个可选值。这里添加一个 ! 用来强制解包
        let fifthMonth = Month2(rawValue: 5)!
        monthsUntilWinterBreak(from: fifthMonth)
        
        fifthMonth.monthsUntilWinterBreak
        
        print(Coin2.quarter) // quarter
        
    }
    
    func monthsUntilWinterBreak(from month: Month2) -> Int {
        return Month2.december.rawValue - month.rawValue
    }
    
    func withdraw(amount: Int) -> WithdrawalResult {
        if amount <= balance {
            balance -= amount
            return .success(newBalance: balance)
        } else {
            return .error(message: "Not enough money!")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

