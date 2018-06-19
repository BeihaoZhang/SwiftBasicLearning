//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


#if swift(>=3.2)
let a = 10
#else
let b = 20
#endif

var welcomeMessage: String
var red, green, blue: Double
welcomeMessage = "hello"
print("The current value of friendlyWelcome is \(welcomeMessage)")

let minValue = uint.min

let decimalInteger = 17 /// 十进制
let binaryInteger = 0b10001 /// 0b 二进制
let octalInteger = 0o21 /// 0o 八进制
let hexadecimalInteger = 0x11 /// 0x 十六进制

/* 十六进制表示的浮点数：十六进制浮点数字面量必须有一个指数，通过大写或小写的p来表示。p是2的次方
 表示 15 x 2^2 = 60.0
 */
0xFp2
/// 表示 15 x 2^-2 = 3.75
0xFp-2
/// 12.3 * (2^0) =
// 12.1875
print("\(0xC.3p0)")

2 + 5

sin( 45 * Double.pi / 180)
sqrt(2)

var mClosure: (Int, Int) -> Int
func operateOnNumbers(a: Int, b: Int, operation:(Int, Int) -> Int) -> Int {
    let result = operation(a, b)
    return result
}
let addClosure = {(a: Int, b: Int) -> Int in
    a + b
}
var result: Int
result = operateOnNumbers(a: 2, b: 5, operation: addClosure)

operateOnNumbers(a: 2, b: 4) { (_ a: Int, _ b: Int) -> Int in
    return a + b
}

operateOnNumbers(a: 2, b: 4, operation: { $0 + $1 })
operateOnNumbers(a: 2, b: 4, operation: {
    $0 + $1
})

func addFunc(a: Int, b: Int) -> Int {
    return a + b
}
// 可以直接传入函数指针
operateOnNumbers(a: 2, b: 4, operation: addFunc)

operateOnNumbers(a: 2, b: 4, operation: +)

let voidClosure:() -> Void = {
    print("Swift Apprentice is awesome!")
}
voidClosure()

var counter = 0

// 作用域定义了一个实体(变量、常量等)可访问的范围。您看到了使用if语句引入的新范围。闭包还引入一个新的范围，并继承定义它的范围可见的所有实体。
let incrementCounter = {
    counter += 1
}

incrementCounter()
incrementCounter()
incrementCounter()
print(counter)

// 返回一个闭包
func countingClosure() -> () -> Int {
    var counter = 0
    // swift无法进行隐式推断，需要显式声明类型
    let incrementCounter: () -> Int = {
        counter += 1
        return counter
    }
    return incrementCounter
}
let counter1 = countingClosure()
let counter2 = countingClosure()
counter1() // 1
counter2() // 1
counter1() // 2
counter1() // 3
counter2() // 2

// counter1就是闭包，因为需要调用闭包，所以最后还要()
counter1()
counter2()
counter1()

let names = ["ZZZZZ", "BBB", "AAAAAA", "EEEEE"]
names.sorted()
let sortedByLength = names.sorted {
    $0.count > $1.count
}
sortedByLength

// FUNCTIONAL
let values = [1, 2, 3, 4, 5]
values.forEach { (a: Int) in
    print("\(a): \(a * a)")
}

var prices = [1.5, 10, 4.99, 2.30, 8.19]
let largePrices = prices.filter { return $0 > 5}

let salePrices = prices.map { (a: Double) -> Double in
    return a * 0.9
}
let salePrices2 = prices.map { return $0 * 0.9 }

let userInput = ["0", "11", "haha", "42"]
// 返回的结果是个可选类型 Int?
let numbers1 = userInput.map{ Int($0) }

let possibleNumbers = ["1", "2", "three", "///4///", "5"]
// mapped：返回可选值的元素
let mapped: [Int?] = possibleNumbers.map { str in Int(str) } // mapped = [1, 2, nil, 5]
// compactMapped：紧凑型映射，返回的数组元素是“非可选型”类型
let compactMapped: [Int] = possibleNumbers.compactMap{ str in Int(str) } // compactMapped = [1, 2, 5]
// 在 Swift4.1 中已经弃用，改为compactMapped
//possibleNumbers.flatMap{str in Int(str)}

// reduce
let numbers = [1, 2, 3, 4]
// 0是初始值，后面的闭包表示前两个值的处理方式。返回的结果就是每个元素相互作用后的总值
let numberSum = numbers.reduce(0, {x, y in x + y}) // numberSum = 10

let letters = "abracadabra"
let letterCount = letters.reduce(into: [:]) { (counts, letter) in
    counts[letter, default: 0] += 1
}// letterCount == ["a": 5, "b": 2, "r": 2, "c": 1, "d": 1]

// ps:ZNH
 letters.reduce(into: [:]) { (counts: inout [Character: Int], letter: Character) in
    return counts[letter, default: 0] += 1
}

let stock = [1.5: 5, 10: 2, 4.99: 20, 2.30: 5, 8.19: 30]
let stockSum = stock.reduce(0) {
    return $0 + $1.key * Double($1.value)
}

func countingClosure2() -> () -> Int {
    var counter = 0
    let incrementCounter: () -> Int = {
        counter += 1
        return counter
    }
    return incrementCounter
}
var closure = countingClosure2()
var value1 = closure()
var value2 = closure()
var value3 = closure()

let farmAnimals = ["🐴": 5, "🐶": 1, "🐑": 50, "🐰": 25]
/* Reduce 是 map、flatMap（4.1后用compactMap）或filter的一种扩展形式。（后三个函数能干嘛，reduce就能用另一种方式实现。）
 Reduce的基础思想是将一个序列转换为一个不同类型的数据，期间通过一个累加器（Accumulator）来持续记录递增状态。为了实现这个方法，我们会向reduce方法中传入一个用于处理序列中每个元素的结合(compactMap) 闭包/函数/方法。
 */
let allAnimals = farmAnimals.reduce(into: []) { (result, this: (key: String, value: Int)) in
    for _ in 0 ..< this.value {
        result.append(this.key)
    }
}


// var prices = [1.5, 10, 4.99, 2.30, 8.19]
// 删除前几个和后几个
let removeFirst = prices.dropFirst()
let removeFirstTwo = prices.dropFirst(2)
let removeLast = prices.dropLast()
let removeLastTwo = prices.dropLast(2)
// 取出前几个或后几个
let firstTwo = prices.prefix(2)
let lastTwo = prices.suffix(2)

/////////////////String////////////////////////
let fullName = "Matt Galloway"
let spaceIndex = fullName.index(of: " ")!
// Matt
let firstName = fullName[..<spaceIndex]
// Galloway
let lastName = fullName[fullName.index(after: spaceIndex)...]
// 将subString强转成String
let lastNameString = String(lastName)
if fullName.elementsEqual(lastName) {
    print("相等")
} else {
    print("不相等")
}
let char = "\u{00bd}"
for i in char.utf8 {
    //i：Unicode.UTF8.CodeUnit
    print(i)
    String(i, radix: 2)
}

/////////////////结构体 Struct////////////////////////
struct Location {
    let x: Int
    let y: Int
}

struct DilverArea: CustomStringConvertible {
    let center: Location
    var radius: Double
    var description: String {
        return """
        Area with center: x:\(center.x) - y:\(center.y),
        radius: \(radius)
        """
    }
}

/////////////////属性 Properties////////////////////////
/* 存储型属性会分配内存空间，计算型属性不会分配内存空间 */
/*
 计算属性可以用于类、结构体和枚举里，存储属性只能用于类和结构体。
 */

struct Car {
    let make: String
    let color: String
}

struct Contact {
    var fullName: String
    let emailAddress: String
    var type = "Friend"
}

var person = Contact(fullName: "Grace Murray", emailAddress: "grace@navy.mil", type: "Friend")

let name = person.fullName // Grace Murray
let email = person.emailAddress // grace@navy.mil

struct TV {
    /* 存储型属性 */
    var height: Double
    var width: Double
    
    /* 计算型属性 */
    var diagonal: Int {
        get {
            let result = (height * height + width * width).squareRoot().rounded()
            return Int(result)
        }
        set {
            let ratioWidth = 16.0
            let ratioHeight = 9.0
            let ratioDiagonal = (ratioWidth * ratioWidth + ratioHeight * ratioHeight).squareRoot()
            height = Double(newValue) * ratioHeight / ratioDiagonal
            width = height * ratioWidth / ratioHeight
        }
    }
}

var tv = TV(height: 53.93, width: 95.87)
let size = tv.diagonal // 100

tv.width = tv.height
let diagonal = tv.diagonal

tv.diagonal = 70
let height = tv.height // 34.32...
let width = tv.width // 61.01...

struct Level {
    // 不能通过instance的形式访问类型属性
    static var highestLevel = 1
    let id: Int
    var boss: String
    /* 存储型属性 */
    var unlocked: Bool {
        /* 通过willSet和didSet进行属性观察 */
        willSet { // 即将改变
            newValue
        }
        didSet { // 已经改变
            oldValue
            if unlocked {
                // Even though you’re inside an instance of the type, you still have to access type properties with the type name preﬁx.
                if unlocked && id > Level.highestLevel {
                    Level.highestLevel = id
                }
            }
        }
    }
}

let level1 = Level(id: 1, boss: "Chameleon", unlocked: true)
let level2 = Level(id: 2, boss: "Squid", unlocked: false)
let level3 = Level(id: 3, boss: "Chupacabra", unlocked: false)
let level4 = Level(id: 4, boss: "Yeti", unlocked: false)

// Error: you can't access a type property on an instance
//let highestLevel = level3.highestLevel

let highestLevel = Level.highestLevel // 1
struct LightBulb {
    static let maxCurrent = 40
    // 计算型属性：Computed property must have accessors specified
    var current = 0 {
        didSet {
            if current > LightBulb.maxCurrent {
                print("Current too high, falling back to previous setting.")
                current = oldValue
            }
        }
    }
}

var light = LightBulb()
light.current = 50
var current = light.current // 0
light.current = 40
current = light.current // 40

struct Circle {
    /* 懒加载必须定义为变量var */
    lazy var pi = {
        return ((4.0 * atan(1.0 / 5/0)) - atan(1.0 / 239.0)) * 4.0
    }()
    var radius = 0.0
    var circumference: Double {
        mutating get {
            return pi * radius * 2
        }
    }    
    init(radius: Double) {
        self.radius = radius
    }
}

var circle = Circle(radius: 5) // got a circle, pi has not been run
let circumference = circle.circumference // 31.42
// also, pi now has a value


/////////////////方法：Method////////////////////////
var numbers2 = [1, 2, 3]
numbers2.removeLast()

let months = ["January", "February", "March",
              "April", "May", "June",
              "July", "August", "September",
              "October", "November", "December"
                ];

struct SimpleDate {
    var month: String
    var day: Int
    
    func monthsUntilWinterBreak() -> Int {
        return months.index(of: "December")! - months.index(of: month)!
    }
    
    mutating func advance() {
        day += 1
    }
}

extension SimpleDate {
    init() {
        month = "January"
        day = 1
    }
}

var date = SimpleDate()
date.day
date.advance()
date.day

date.month
date.monthsUntilWinterBreak()

let valentinesDay = SimpleDate(month: "February", day: 14)
valentinesDay.month
valentinesDay.day

struct Math {
    static func factorial(of number: Int) -> Int {
        return (1...number).reduce(1, *)
    }
}

Math.factorial(of: 6)

extension Math {
    static func primeFactors(of value: Int) -> [Int] {
        var remainingValue = value
        var testFactor = 2
        var primes: [Int] = []
        while testFactor * testFactor <= remainingValue {
            if remainingValue % testFactor == 0 {
                primes.append(testFactor)
                remainingValue /= testFactor
            }
            else {
                testFactor += 1
            }
        }
        if remainingValue > 1 {
            primes.append(remainingValue)
        }
        return primes
    }
}

Math.primeFactors(of: 81)

/////////////////类：Class////////////////////////
class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

let john = Person(firstName: "Johnny", lastName: "Appleseed")

class SimplePerson {
    let name: String
    init(name: String) {
        self.name = name
    }
}

var var1 = SimplePerson(name: "John")
var var2 = var1

struct DeliveryArea {
    var range: Double
    let center: Location
}

func printAddress(values: AnyObject...) {
    print("---------------------------------")
    for value in values {
        print(Unmanaged.passUnretained(value).toOpaque())
    }
    print("---------------------------------")
}

var area1 = DeliveryArea(range: 2.5, center: Location(x: 2, y: 4))
var area2 = area1
print(area1.range) // 2.5
print(area2.range) // 2.5
// 地址不同
printAddress(values: area1 as AnyObject, area2 as AnyObject)

// 单例
final class Single: NSObject {
    static let sharedManager = Single()
    private override init() {
        
    }
}

struct Person2 {
    var name: String
    var age: Int
    mutating func fullName() -> String {
        name = "BeihaoZhang"
        return name
    }
}

class Person3 {
    let name: String
    let age: Int
    init(name: String, age: Int) {
        // 在初始化的时候可以给常量属性赋值，但是在一般的func中需要将let转成var才能赋值
        self.name = name
        self.age = age
    }
}

var pp = Person2(name: "Home", age: 22)
pp = Person2(name: "test", age: 23)
pp.name = "work"


/////////////////类：Advanced Classes////////////////////////
struct Grade {
    var letter: Character
    var points: Double
    var credits: Double
}

class PersonP {
    var firstName: String
    var lastName: String
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    deinit {
        print("\(firstName) \(lastName) is being removed from memory!")
    }
}

class Student: PersonP {
    weak var partner: Student?
    var grades: [Grade] = []
    
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
    }
    
    deinit {
        print("\(firstName) is being deallocated!")
    }
}

let johnP = PersonP(firstName: "Johnny", lastName: "Applessed")
let janeP = Student(firstName: "Jane", lastName: "Applessed")

johnP.firstName // "John"
janeP.firstName // "Jane"

let history = Grade(letter: "B", points: 9.0, credits: 3.0)
janeP.recordGrade(history)

class BandMember: Student {
    var minimumPracticeTime = 2
}

class OboePlayer: BandMember {
    override var minimumPracticeTime: Int {
        get {
            return super.minimumPracticeTime * 2
        }
        set {
            super.minimumPracticeTime = newValue / 2
        }
    }
}

func phonebookName(_ person: PersonP) -> String {
    return "\(person.lastName), \(person.firstName)"
}

let personP = PersonP(firstName: "Johnny", lastName: "Appleseed")
let oboePlayerP = OboePlayer(firstName: "Jane", lastName: "Appleseed")

phonebookName(personP) // Appleseed, Johnny
phonebookName(oboePlayerP) // Appleseed, Jane

var hallMonitor = Student(firstName: "Jill", lastName: "Bananapeel")
// 子类对象赋值给父类
hallMonitor = oboePlayerP

let studentPP = oboePlayerP as Student

hallMonitor as? BandMember
(hallMonitor as? BandMember)?.minimumPracticeTime // 4 (optional)

hallMonitor as! BandMember // 强制解包，如果没有值，运行时会crash
(hallMonitor as! BandMember).minimumPracticeTime // 强制解包

if let hallMonitor = hallMonitor as? BandMember {
    print("This hall monitor is a band member and practices at least \(hallMonitor.minimumPracticeTime)")
}

func afterClassActivity(for student: Student) -> String {
    return "Goes home!"
}

func afterClassActivity(for student: BandMember) -> String {
    return "Goes to practice!"
}

afterClassActivity(for: oboePlayerP) // Goes to practice!
afterClassActivity(for: oboePlayerP as Student) // Goes home

class StudentAthlete: Student {
    var failedClasses: [Grade] = []
    override func recordGrade(_ grade: Grade) {
        super.recordGrade(grade)
        
        if grade.letter == "F" {
            failedClasses.append(grade)
        }
    }
    var isEligible: Bool {
        return failedClasses.count < 3
    }
}

final class FinalStudent: Person {}

class AnotherStudent: Person {
    /* final 关键字可以用在class、func或者 var 前面进行修饰，表示不允许对该内容进行继承或者重写操作*/
    final func recordGrade(_ grade: Grade) {}
}

class AnotherStudentAthlete: AnotherStudent {
    
}

/////// final
class Parent {
    final func method() {
        print("开始配置")
        // ..必要的代码
        methodImpl()
        // ..必要的代码
        print("结束配置")
    }
    func methodImpl() {
        fatalError("子类必须实现这个方法")
        // 或者也可以给出默认实现
    }
}

class Child: Parent {
    override func methodImpl() {
        // ..子类的业务逻辑
    }
}
///////

class NewStudent {
    let firstName: String
    let lastName: String
    var grades: [Grade] = []
    
    required init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    convenience init(transfer: NewStudent) {
        self.init(firstName: transfer.firstName, lastName: transfer.lastName)
    }
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
    }
}

class NewStudentAthlete: NewStudent {
    var failedClasses: [Grade] = []
    var sports: [String]
    
    init(firstName: String, lastName: String, sports:[String]) {
        self.sports = sports
        let passGrade = Grade(letter: "P", points: 0.0, credits: 0.0)
        super.init(firstName: firstName, lastName: lastName)
        recordGrade(passGrade)
    }
    
    required init(firstName: String, lastName: String) {
        self.sports = []
        super.init(firstName: firstName, lastName: lastName)
    }
    
    override func recordGrade(_ grade: Grade) {
        super.recordGrade(grade)
        
        if grade.letter == "F" {
            failedClasses.append(grade)
        }
    }
    
    var isEligible: Bool {
        return failedClasses.count < 3
    }
}

class Team {
    var players: [StudentAthlete] = []
    
    var isEligible: Bool {
        for player in players {
            if !player.isEligible {
                return false
            }
        }
        return true
    }
}

class Button {
    func press() {}
}

class Image {}

class ImageButton: Button {
    var image: Image
    
    init(image: Image) {
        self.image = image
    }
}

class TextButton: Button {
    var text: String
    
    init(text: String) {
        self.text = text
    }
}

var someone = Person(firstName: "Johnny", lastName: "Appleseed")
// Person object has a reference count of 1 (someone variable)

var anotherSomeone: Person? = someone
// Reference count 2 (someone, anotherSomeone)

var lotsOfPeople = [someone, someone, anotherSomeone, someone]
// Reference count 6 (someone, anotherSome, 4 references in lotsOfPeople)

anotherSomeone = nil
// Reference count 5 (someone, 4 references in lotsOfPeople)

lotsOfPeople = []
// Reference count 1 (someone)

someone = Person(firstName: "Johnny", lastName: "Appleseed")
// Reference count 0 for the original Person object!
// Variable someone now references a new object

var alice: Student? = Student(firstName: "Alice", lastName: "Appleseed")
var bob: Student? = Student(firstName: "Bob", lastName: "Appleseed")

alice?.partner = bob
bob?.partner = alice
alice = nil
bob = nil

//class SuperClass1 {
//    var name: String
//    init(name: String) {
//        self.name = name
//    }
//}
//class SubClass1: SuperClass1 {
//
//}
//
//func test1(type: SuperClass1) {
//    print("hahah")
//}
//
//let type1 = SubClass1(name: "aaa")
//test1(type: type1)
//
//class ClassA {
//    let numA: Int
//    required init(num: Int) {
//        numA = num
//    }
//
//     convenience init(bigNum: Bool) {
//        self.init(num: bigNum ? 1000 : 1)
//    }
//}
//
//class ClassB: ClassA {
//    let numB: Int
//    required init(num: Int) {
//        numB = num + 1
//        super.init(num: num)
//    }
//}

///////////////////枚举：Enumerations//////////////////////
func semester(for month: String) -> String {
    switch month {
    case "August", "September", "October", "November", "December":
        return "Autumn"
    case "January", "February", "March", "April", "May":
        return "Spring"
    default:
        return "Not in the school"
    }
}

semester(for: "April")

enum Month: Int {
    case january = 1, february, march, april, may, june, july, august, september, october, november, december
}

func semester(for month: Month) -> String {
    switch month {
    case .august, .september, .october, .november, .december:
        return "Autumn"
    case .january, .february, .march, .april, .may:
        return "Spring"
    default:
        return "Summer"
    }
}

var month = Month.april
semester(for: month)
month = .september
semester(for: month)

func monthsUntilWinterBreak(from month: Month) -> Int {
    return Month.december.rawValue - month.rawValue
}
monthsUntilWinterBreak(from: .april)

let fifthMonth = Month(rawValue: 5)!
monthsUntilWinterBreak(from: fifthMonth)

// 1
enum Icon: String {
    case music
    case sports
    case weather
    var filename: String {
        // 2
        return "\(rawValue).png"
    }
}
let icon = Icon.weather
icon.filename

enum Coin: Int {
    case penny = 1
    case nickel = 5
    case dime = 10
    case quarter = 25
}

let coin = Coin.quarter
coin.rawValue

var balance = 100

enum WithdrawalResult {
    case success(newBalance: Int)
    case error(message: String)
}

func withdraw(amount: Int) -> WithdrawalResult {
    if amount <= balance {
        balance -= amount
        return .success(newBalance: balance)
    } else {
        return .error(message: "Not enough money!")
    }
}

let result2 = withdraw(amount: 99)
switch result2 {
case .success(let newBalance):
    print("Your new balance is: \(newBalance)")
case .error(let message):
    print(message)
}

enum HTTPMethod {
    case get
    case post(body: String)
}

let request = HTTPMethod.post(body: "Hi there")
guard case .post(let body) = request else {
    fatalError("No message was posted")
}
































