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

import CoreGraphics

/*:
 ## Error Handling Challenges
 ### Question 1
 
 `CGAffineTransform` is a transform type used by Core Graphics to scale and rotate graphical elements.  You can obtain an inverse transform by calling the `inverted()` method.

 Just as dividing by zero will fail, inverting a singular transform can fail. When this happens, `CGAffineTransform` does nothing to warn you except print a message to the console. You can do better.

 The following code checks whether a transform can be inverted or will fail:

 ```swift
 extension CGAffineTransform {
   var isInvertable: Bool {
     return abs(a*d - b*c) > CGFloat.ulpOfOne
   }
 }

 CGAffineTransform().isInvertable  // false
 CGAffineTransform.identity.isInvertable // true

 ```

 Use the following code to make viewing transforms easy:

 ```swift
 extension CGAffineTransform: CustomStringConvertible {
   public var description: String {
     return [a,b,c,d,tx,ty].reduce("") { $0 + " \($1)" }
   }
 }
 ```

 Write a method on `CGAffineTransform` named `safeInverted()` that returns an optional type. If the transform can be inverted it returns the new transform.  Otherwise it returns `nil`.

 Test your method with `let scaleByTwo = CGAffineTransform.identity.scaledBy(x: 2, y: 2)` and observe the values you get back.

 */

// For nice debug printing
extension CGAffineTransform: CustomStringConvertible {
  public var description: String {
    return [a,b,c,d,tx,ty].reduce("") { $0 + " \($1)" }
  }
}

// A method to detect singular transforms
extension CGAffineTransform {
  var isInvertable: Bool {
    return abs(a*d - b*c) > CGFloat.ulpOfOne
  }
}

// Safe way to
extension CGAffineTransform {
  func safeInverted() -> CGAffineTransform? {
    return isInvertable ? inverted() : nil
  }
}
let singular = CGAffineTransform()
let scaleByTwo = CGAffineTransform.identity.scaledBy(x: 2, y: 2)
let scaleByHalf = scaleByTwo.safeInverted()


/*:
 ### Question 2
 
 Use optional chaning to safely invert the transform and then invert it again. Much like taking the reciprocal of the same number, you should wind up with the same number.
 */

let thereAndBackAgain = scaleByTwo.safeInverted()?.safeInverted()

/*:
 ### Question 3
 
 Change your design to throw `MathError.singular` if the transform can't be inverted. Name this new method `checkedInverted()` so it can co-exist nicely with your `safeInverted()` method.  Test it out.
 */

enum MathError: Error {
  case singular
}

extension CGAffineTransform {
  func checkedInverted() throws -> CGAffineTransform {
    guard isInvertable else {
      throw MathError.singular
    }
    return inverted()
  }
}

do {
  let scaled = try scaleByTwo.checkedInverted()
//  let scaled2 = try singular.checkedInverted()
  print(scaled)
}
catch MathError.singular {
  print("error")
}

/*: 
 ### Question 4
 Note the return types of `safeInverted()` and `checkedInverted()`.  How do they differ?
 */

// safeInverted returns an optional type where checkedInverted returns a transform that is valid within the scope that it was tried.  Note that if your function throws you don't need to make the return type optional.

