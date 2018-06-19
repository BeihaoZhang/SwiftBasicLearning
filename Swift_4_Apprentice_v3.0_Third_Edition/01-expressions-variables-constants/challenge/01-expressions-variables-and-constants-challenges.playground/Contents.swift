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

/*: 
## Expressions, Variables & Constants Challenges

### Challenge 1
 Declare a constant `exercises` with value 9 and a variable `exercisesSolved` with value 0. Increment this variable every time you solve an exercise (including this one).
 */
let exercises: Int = 9
var exercisesSolved: Int = 0
exercisesSolved += 1

/*:
### Challenge 2
 Given the following code:
 ```swift
 age = 16
 print(age)
 age = 30
 print(age)
 ```
  Declare `age` so that it compiles.  Did you use `var` or `let`?
*/
var age: Int  // it is a var not a let
age = 16
print(age)
age = 30
print(age)
exercisesSolved += 1

/*:
### Challenge 3
 Consider the following code:

```swift
let a: Int = 46
let b: Int = 10
```
 Work out what `answer` equals when you add the following lines of code:
```swift
// 1
let answer1: Int = (a * 100) + b
// 2
let answer2: Int = (a * 100) + (b * 100)
// 3
let answer3: Int = (a * 100) + (b / 10)
```
*/
let a: Int = 46
let b: Int = 10
let answer1: Int = (a * 100) + b
let answer2: Int = (a * 100) + (b * 100)
let answer3: Int = (a * 100) + (b / 10)
exercisesSolved += 1

/*:
### Challenge 4
 Add parentheses to the following calculation. The parentheses should show the order in which the operations are performed and should not alter the result of the calculation.
 */
5 * 3 - 4 / 2 * 2
/*:
 Solution:
 */
(5 * 3) - ((4 / 2) * 2)
exercisesSolved += 1

/*:
### Challenge 5
 Declare two constants `x` and `y` of type `Double` and assign both a value. Calculate the average of `x` and `y` and store the result in a constant named `average`.
 */
let x: Double = 7.5
let y: Double = 5
let average: Double = (x + y) / 2
exercisesSolved += 1
/*:
 Bonus: why is it important that `x` and `y` are of type `Double`?
 
 Solution:
 If `x` and `y` were of type `Int`, the result would be an `Int` as well, and your average might not be integer.
*/

/*:
### Challenge 6
 A temperature expressed in °C can be converted to °F by multiplying by 1.8 then incrementing by 32. In this exercise, you will do the reverse: convert a temperature from °F to °C.
 
 Declare a constant named `fahrenheit` of type `Double` and assign it a value. Calculate the corresponding temperature in °C and store the result in a constant named `celcius`.
 */
let fahrenheit: Double = 121.0
let celcius: Double = (fahrenheit - 32) / 1.8
exercisesSolved += 1

/*:
### Challenge 7
 Suppose the squares on a chessboard are numbered left to right, top to bottom, with 0 being the top-left square and 63 being the bottom-right square. Rows are numbered top to bottom, 0 to 7. Columns are numbered left to right, 0 to 7.
 
 Declare a constant `position` and assign it a value between 0 and 63. Calculate the corresponding row and column numbers and store the results in constants named `row` and `column`.
 */
let position: Int = 54
let row: Int = position / 8
let column: Int = position % 8
exercisesSolved += 1

/*:
 ### Challenge 8
 A circle is made up of 2𝜋 radians, corresponding with 360 degrees. Declare a constant `degrees` of type `Double` and assign it an initial value. Calculate the corresponding angle in radians and store the result in a constant named `radians`.
 */
let degrees: Double = 360.0
let radians: Double = (degrees / 180) * Double.pi
exercisesSolved += 1

/*:
### Challenge 9
 Declare four constants named `x1`, `y1`, `x2` and `y2` of type `Double`. These constants represent the 2-dimensional coordinates of two points. Calculate the distance between these two points and store the result in a constant named `distance`.
 */
let x1: Double = 1.0
let y1: Double = 1.0
let x2: Double = 3.0
let y2: Double = 3.0
let dx: Double = x2 - x1
let dy: Double = y2 - y1
let distance: Double = (dx * dx + dy * dy).squareRoot()
exercisesSolved += 1
