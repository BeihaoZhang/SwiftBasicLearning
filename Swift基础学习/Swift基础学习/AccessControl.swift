//
//  AccessControl.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/12.
//  Copyright © 2018年 Lincoln. All rights reserved.
//

import Foundation

//: Challenge 1
class Logger {
    // A private initializer is required to restrict instantiation so only the class itself can create objects.
    private init() {}
    
    static let sharedInstance = Logger()
    
    func log(_ text: String) {
        print(text)
    }
}

// Logger.sharedInstance.log("Hello, swift!")

//: Challenge 2
struct Stack<Element> {
    private var elements: [Element] = []
    
    func peek() -> Element? {
        return elements.last
    }
    
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    mutating func pop() -> Element? {
        if elements.isEmpty {
            return nil
        }
        return elements.removeLast()
    }
    
    var count: Int {
        return elements.count
    }
    
}

/*
var strings = Stack<String>()
strings.push("Great!")
strings.push("is")
strings.push("Swift")

//strings.elements.removeAll() // The implementation details of `Stack` are hidden.

strings.peek()

while let string = strings.pop() {
    Logger.sharedInstance.log(string)
}
*/



// 缺少访问控制
protocol Account2 {
    associatedtype Currency
    
    var balance: Currency { get }
    func deposit(amount: Currency)
    func withdraw(amount: Currency)
}

typealias Dollars = Double

class BasicAccount: Account2 {
    
    // 通过该修饰符，只能在内部修改 balance 属性
    private(set) var balance: Dollars = 0.0
    
    func deposit(amount: Dollars) {
        balance += amount
    }
    
    func withdraw(amount: Dollars) {
        if amount <= balance {
            balance -= amount
        } else {
            balance = 0
        }
    }
}

class CheckingAccount: BasicAccount {
    private let accountNumber = UUID().uuidString
    
    class Check {
        let account: String
        var amount: Dollars
        // private: 只在该类内部和该类的extension中可以访问
        // 这里 set 被限制为了 private
        private(set) var cashed = false
        
        func cash() {
            cashed = true
        }
        
        // fileprivate: 只在该文件内可以访问
        fileprivate init(amount: Dollars, from account: CheckingAccount) {
            self.amount = amount
            // 如果在 CheckingAccount 作用域外面访问 accountNumber 属性会报错的
            self.account = account.accountNumber
        }
    }
    
    func writeCheck(amount: Dollars) -> Check? {
        guard balance > amount else {
            return nil
        }
        
        let check = Check(amount: amount, from: self)
        withdraw(amount: check.amount)
        return check
    }
    // 父类中有个 func deposit(amount: Dollars)，子类又重载了这个方法。
    func deposit(_ check: Check) {
        guard !check.cashed else {
            return
        }
        
        deposit(amount: check.amount)
        check.cash()
        // error: Cannot assign to property: 'cashed' setter is inaccessible
//        check.cashed = true
    }
    
}

class AccountControl {
    
    private var issuedChecks: [Int] = []
    private var currenCheck = 1
    
    func controlPrint() {
        let account = BasicAccount()
        
        account.deposit(amount: 10.00)
        account.withdraw(amount: 5.00)
        // 只能在内部进行修改
//        account.balance = 1000000000000.00
        
        let johnChecking = CheckingAccount()
        johnChecking.deposit(amount: 300.00)
        
        let check = johnChecking.writeCheck(amount: 200.00)!
        
        let janeChecking = CheckingAccount()
        janeChecking.deposit(check)
        janeChecking.balance // 200.00
        
        // Try to cash the check again. Of course, it had no effect on
        janeChecking.deposit(check)
        janeChecking.balance // 200.00
        
        /* 这些访问修饰符不能修饰局部变量或常量，因为一旦出了局部作用域，变量或常量就被销毁了 */
        // Attribute 'private' can only be used in a non-local scope
//        private var issuedCHecks: [Int] {
//            return [1, 2, 3]
//        }
        
        // Attribute 'private' can only be used in a non-local scope
//        private var issuedCHecks: [Int] = []
        
        // Attribute 'public' can only be used in a non-local
//        public var issuedCHecks: [Int] = []
        
        // Attribute 'open' can only be used in a non-local scope
//        open var issuedCHecks: [Int] = []
    }
}

