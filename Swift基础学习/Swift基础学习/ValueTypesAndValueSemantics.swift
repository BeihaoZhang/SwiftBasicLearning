//
//  ValueTypesAndValueSemantics.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/17.
//  Copyright © 2018年 Lincoln. All rights reserved.
//

import Foundation

struct ValueStruct {// 从下面结果可以看出：结构体虽然是值类型，但是如果它的成员变量中有引用类型时，那么在结构体的拷贝过程中，该成员变量依然会是引用类型，不会变成值类型。
    var age: Int
    let person: Person3
}

class Person3 {
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
/* 第一部分
 
var age = 50
let person = Person(name: "bye", age: 20)
var myStruct = ValueStruct(age: age, person: person)
myStruct.person.name = "may"
print(person.name) // "may"
myStruct.age = 40
print(age) // 50

*/

/* 第二部分
 
 var age = 50
 let person = Person(name: "bye", age: 20)
 var myStruct = ValueStruct(age: age, person: person)
 
 var secondStruct = myStruct
 myStruct.person.name = "may"
 myStruct.age = 40
 print(secondStruct.person.name) // may
 print(secondStruct.age) // 50
 
 */

struct Color: CustomStringConvertible {
    var red, green, blue: Double
    var description: String {
        return "r: \(red) g: \(green), b: \(blue)"
    }
}

extension Color {
    static var black = Color(red: 0, green: 0, blue: 0)
    static var white = Color(red: 1, green: 1, blue: 1)
    static var blue = Color(red: 0, green: 0, blue: 1)
    static var green = Color(red: 0, green: 1, blue: 0)
}

class Bucket {
    var color: Color
    var isRefilled = false
    
    init(color: Color) {
        self.color = color
    }
    
    func refill() {
        isRefilled = true
    }
}

extension Color {
    mutating func darken() {
        red *= 0.9; green *= 0.9; blue *= 0.9
    }
}

struct PaintingPlan { // 值类型
    // 私有的引用类型，for "deep storage"
    private var bucket = Bucket(color: .blue)
    
    var bucketColor: Color {
        get {
            return bucket.color
        }
        set {
            // 优化 copy-on-write（写时复制）
            // isKnownUniquelyReferenced: 用来检查某个实例是不是唯一的引用，如果是，说明该实例没有被共享，我们可以直接修改当前的实例，如果不是，说明实例被共享，这时对它进行更改就需要先复制。
            if isKnownUniquelyReferenced(&bucket) {
                bucket.color = newValue
            } else {
                bucket = Bucket(color: newValue)
            }
        }
    }
}

class ReferenceType {
    var value = 0
}

class ValueType {
    var value = 0
}

typealias MysteryType = ReferenceType
// or
// typealias MysteryType = ValueType

class Types {
    func myTest1() {
        // Bucket是class，引用类型
        let azurePaint = Bucket(color: .blue)
        let wallBluePaint = azurePaint
        print(wallBluePaint.isRefilled) // false, initially
        azurePaint.refill()
        print(wallBluePaint.isRefilled) // true, unsurprisingly!
        
        // Color是struct，值类型
        var azure = Color.blue
        var wallBlue = azure
        print(azure) // r: 0.0 g: 0.0 b: 1.0
        wallBlue.darken()
        print(azure) // r: 0.0 g: 0.0 b: 1.0 (unaffected)
    }
    
    func myTest2() {
        var x = MysteryType()
        var y = x
        exposeValue(x) // initial value derived from x
    }
    
    func exposeValue(_ mystery: MysteryType) -> Int {
        return mystery.value
    }
}


