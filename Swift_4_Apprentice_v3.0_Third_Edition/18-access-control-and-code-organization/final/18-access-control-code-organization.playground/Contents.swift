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

// Create a new account
let account = BasicAccount()

// Deposit and withdraw some money
account.deposit(amount: 10.00)
account.withdraw(amount: 5.00)

// ... or do evil things!
//account.balance = 1000000.00

// Create a checking account for John. Deposit $300.00
let johnChecking = CheckingAccount()
johnChecking.deposit(amount: 300.00)

// Write a check for $200.00
let check = johnChecking.writeCheck(amount: 200.0)!

// Create a checking account for Jane, and deposit the check.
let janeChecking = CheckingAccount()
janeChecking.deposit(check)
janeChecking.balance // 200.00

// Try to cash the check again. Of course, it had no effect on
// Jane's balance this time :]
janeChecking.deposit(check)
janeChecking.balance // 200.00

class SavingsAccount: BasicAccount {
  var interestRate: Double
  
  init(interestRate: Double) {
    self.interestRate = interestRate
  }
  
  func processInterest() {
    let interest = balance * interestRate
    deposit(amount: interest)
  }
}
