//
//  CodableSerialization.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/15.
//  Copyright © 2018年 Lincoln. All rights reserved.
//

import Foundation

// Once you have a codable type, you can use JSONEncoder
struct Employee: Codable {
    var name: String
    var id: Int
    var favoriteToy: Toy2 // Toy也遵守Codable协议
    
    // 重命名json中的字段名
    enum CodingKeys: String, CodingKey {
        case id = "employeeId"
        // 如果不需要重命名，也要在这里写出来
        case name
        case favoriteToy
    }
}

struct Toy2: Codable {
    var name: String
}

class CodableSerialization {
    func myTest() {
        let toy1 = Toy2(name: "Teddy Bear")
        let employee1 = Employee(name: "John Appleseed", id: 7, favoriteToy: toy1)
        
        // json编码
        let jsonEncoder = JSONEncoder()
        // 将对象进行json编码，此时jsonData是一个data类型
        let jsonData = try? jsonEncoder.encode(employee1)
        print(jsonData)
        // 将data转成string，让它具有可读性
        if let jsonData = jsonData {
            let jsonString = String(data: jsonData, encoding: .utf8)
            // { "employeeId": 7, "name": "John Appleseed", "favoriteToy": {"name":"Teddy Bear"}}
            print(jsonString ?? "")
        }
        
        // json解码
        let jsonDecoder = JSONDecoder()
        // 第一个传入的参数是告诉swift对象的类型
        let employee2 = try! jsonDecoder.decode(Employee.self, from: jsonData!)
    }
}

/*
 上面做的处理其实都是swift库帮我们做的自动编解码。只需要遵照Codable协议即可。当json中的数据结构与自己想要的数据结构不一样时，就需要自己手动实现编解码了。
 比如自己想要的是 {"gift":"Teddy Bear"}，而json中的构造是 {"favoriteToy": {"name": "Teddy Bear"}}
 */
/*
 原来的数据结构：
 { "employeeId": 7, "name": "John Appleseed", "favoriteToy": {"name":"Teddy Bear"}}
 
 想要的数据结构：
 { "employeeId": 7, "name": "John Appleseed", "gift": "Teddy Bear" }
 
 */
// 这里不要写遵守 Codable协议
struct Employee22 {
    /* 这些变量其实就是对应的value */
    var name: String
    var id: Int
    var favoriteToy: Toy2
    
    // CodingKeys名字可以随便起。这个枚举中的成员其实就是对应的key。
    enum CodingKeys: String, CodingKey {
        // 在编解码时会进行替换的：把 "id" 替换为 "employeeId"
        case id = "employeeId"
        // 如果不需要重命名，也要在这里写出来
        case name
        case gift
    }
}

// 手动编码操作
extension Employee22: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        /* 不要忘了写关键字 try */
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(favoriteToy.name, forKey: .gift)
    }
}

// 手动解码操作
extension Employee22: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        /* 不要忘了写关键字 try */
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(Int.self, forKey: .id)
        let gift = try values.decode(String.self, forKey: .gift)
        favoriteToy = Toy2(name: gift)
    }
}
