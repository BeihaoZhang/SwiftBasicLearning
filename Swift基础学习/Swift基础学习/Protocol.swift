//
//  Protocol.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/10.
//  Copyright © 2018年 Lincoln. All rights reserved.
//

import Foundation

protocol Vehicle {
    func accelerate()
    func stop()
}

class Unicycle: Vehicle {
    var peddling = false
    
    func accelerate() {
        peddling = true
    }
    
    func stop() {
        peddling = false
    }
}

enum Direction {
    case left
    case right
}

protocol DirectionalVehicle {
    func accelerate()
    func stop()
    func turn(_ direction: Direction)
    func description() -> String
}

protocol OptionalDirectionVehicle {
    func turn()
    func turn(_ direction: Direction)
}

protocol VehicleProperties {
    var weight: Int { get }
    var name: String { get set }
}

protocol Account {
    var value: Double { get set }
    // 如果协议中出现了初始化方法，那么在实现中必须加上 required 关键字
    init(initialAmount: Double)
    init?(transferAccount: Account)
}

class BitcoinAccount: Account {
    // Account协议中的value
    var value: Double
    
    required init(initialAmount: Double) {
        value = initialAmount
    }
    
    required init?(transferAccount: Account) {
        guard transferAccount.value > 0.0 else {
            return nil
        }
        value = transferAccount.value
    }
}

protocol WheeledVehicle: Vehicle {
    var numberOfWheels: Int { get }
    var wheelSize: Double { get set }
}

protocol WeightCalculatable {
    associatedtype WeightType
    var weight: WeightType { get }
}

class HeavyThing: WeightCalculatable {
    // this heavy thing only needs integer accuracy
    typealias WeightType = Int
    
    var weight: Int {
        return 100
    }
}

class LightThing: WeightCalculatable {
    // This light thing needs decimal places
    typealias WeightType = Double
    
    var weight: Double {
        return 0.0025
    }
}

// Error!
// let weightedTypeThing: WeightCalculatable = LightThing()

protocol Wheeled {
    var numberOfWheels: Int { get }
    var wheelSize: Double { get set }
}

class Bike: Vehicle, Wheeled {
    
    let numberOfWheels = 2
    var wheelSize = 16.0
    
    var peddling = false
    var brakesApplied = false
    
    func accelerate() {
        peddling = true
        brakesApplied = false
    }
    
    func stop() {
        peddling = false
        brakesApplied = true
    }
}

protocol Reflective {
    var typeName: String { get }
}

extension String: Reflective {
    var typeName: String {
        return "I'm a String"
    }
}

class AnotherBike: Wheeled {
    var peddling = false
    let numberOfWheels = 2
    var wheelSize = 16.0
}

extension AnotherBike: Vehicle {
    func accelerate() {
        peddling = true
    }
    
    func stop() {
        peddling = false
    }
}

protocol Named {
    var name: String { get set }
}

class ClassName: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct StructyName: Named {
    var name: String
}

struct Record {
    var wins: Int
    var losses: Int
}

extension Record: Equatable {
    static func ==(lhs: Record, rhs: Record) -> Bool {
        return lhs.wins == rhs.wins &&
               lhs.losses == rhs.losses        
    }
}

// MARK: Comparable 协议用来进行比较
extension Record: Comparable {
    static func <(lhs: Record, rhs: Record) -> Bool {
        if lhs.wins == rhs.wins {
            return lhs.losses > rhs.wins
        }
        return lhs.wins < rhs.wins
    }
}

class Student {
    let email: String
    var firstName: String
    var lastName: String
    
    init(email: String, firstName: String, lastName: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension Student: Equatable {
    static func ==(lhs: Student, rhs: Student) -> Bool {
        return lhs.email == rhs.email
    }
}

extension Student: Hashable {
    var hashValue: Int {
        return email.hashValue
    }
}

// 遵守 CustomStringConvertible 协议后可以重写 description 属性
extension Student: CustomStringConvertible {
    var description: String {
        return "\(firstName) \(lastName)"
    }
}

class ProtocolClass {
    func test() {
        var accountType: Account.Type = BitcoinAccount.self
        let account = accountType.init(initialAmount: 30.00)
        let transferAccount = accountType.init(transferAccount: account)!
        
        roundAndRound(transportation: Bike())
        
        let title = "Swift Apprentice"
        title.typeName
        
        var named: Named = ClassName(name: "Classy")
        var copy = named
        
        named.name = "Still Classy"
        print(named.name, copy.name)
        
        named.name = "Still Structy?"
        print(named.name, copy.name)
        
        let a = 5
        let b = 5
        
        a == b
        
        let swiftA = "Swift"
        let swiftB = "Swift"
        
        swiftA == swiftB
        
        let recordA = Record(wins: 10, losses: 5)
        let recordB = Record(wins: 10, losses: 5)
        
        if recordA == recordB {
            print("recordA 等于 recordB")
        }
        
        let teamA = Record(wins: 14, losses: 11)
        let teamB = Record(wins: 23, losses: 8)
        let teamC = Record(wins: 23, losses: 9)
        var leagueRecords = [teamA, teamB, teamC]
        
        let sortRecords = leagueRecords.sorted()
        let maxRecord = leagueRecords.max()
        let minRecord = leagueRecords.min()
        // starts中传入的数组元素必须是一段连续的值或者传入empty，才返回true。
        // leagueRecords.starts(with: [teamA, teamC]) // true
        let isSequenceContain = leagueRecords.starts(with: [teamA, teamC]) // false
        print(isSequenceContain)
        leagueRecords.contains(recordB)
        
        let john = Student(email: "johnny.appleseed@apple.com", firstName: "Johnny", lastName: "Appleseed")
        // key: john, value: "148"
        let lockerMap = [john: "148"]
        print(john)
        
        
        
        
    }
    
    func roundAndRound(transportation: Vehicle & Wheeled) {
        transportation.stop()
        print("The brakes are being applied to \(transportation.numberOfWheels) wheels")
    }
    

}

































