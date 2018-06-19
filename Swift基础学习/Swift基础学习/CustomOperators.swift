//
//  CustomOperators.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/13.
//  Copyright © 2018年 Lincoln. All rights reserved.
//

import Foundation

precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

// 如果是swift中未声明的操作符，需要显式说明
infix operator **: ExponentiationPrecedence

func **(base: Int, power: Int) -> Int {
    precondition(power >= 2)
    var result = base
    for _ in 2 ... power {
        result *= base
    }
    return result
}

// The exponentiation operator now works for all integer types: Int, UInt, Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64 and UInt64.
func **<T: BinaryInteger>(base: T, power: Int) -> T {
    precondition(power > 2)
    var result = base
    for _ in 2 ... power {
        result *= base
    }
    return result
}

infix operator **=
func **=<T: BinaryInteger>(lhs: inout T, rhs: Int) {
    lhs = lhs ** rhs
}

struct Vector2D {
    var x = 0.0
    var y = 0.0
}

fileprivate func +(lhs: Vector2D, rhs: Vector2D) -> Vector2D {
    return Vector2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

class CustomOperator {
    func test() {
        let lhs = Vector2D(x: 3, y: 6)
        let rhs = Vector2D(x: 4, y: 3)
        let result = lhs + rhs;
        let a = 3 + 4
        print(result, a)
        
        let intResult = 2 * 2 ** 3 ** 2
        print(intResult)
    }
}







