/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

// try 0: values driving values
enum PetKind {
  case cat
  case dog
}

struct KeeperKind {
  var keeperOf: PetKind
}

let catKeeper = KeeperKind(keeperOf: .cat)
let dogKeeper = KeeperKind(keeperOf: .dog)

// types driving types

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
//var aKeeper = Keeper()  // compile-time error!
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
  var name: String { get }  // all pets respond to a name
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

herd(dogs)
herd(cats)
herd(pets)

extension Array where Element: Cat {
  func meow() {
    forEach { print("\($0.name) says meow!") }
  }
}

// dogs.meow() // error: 'Dog' is not a subtype of 'Cat'
cats.meow()

let animalAges: Array<Int> = [2,5,7,9]

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
  // other properties here
  var birthday: OptionalDate
  var lastName: OptionalString
}

// Keep this commented out so we can keep using Swift's Optional type, not our own.
//enum Optional<Wrapped> {
//  case none
//  case some(Wrapped)
//}

var birthdate: Optional<Date> = .none
if birthdate == .none {
  // no birthdate
}

var birthdate2: Date? = nil
if birthdate2 == nil {
  // no birthdate
}

func swapped<T, U>(_ x: T, _ y: U) -> (U, T) {
  return (y, x)
}

swapped(33, "Jay")  // returns ("Jay", 33)
