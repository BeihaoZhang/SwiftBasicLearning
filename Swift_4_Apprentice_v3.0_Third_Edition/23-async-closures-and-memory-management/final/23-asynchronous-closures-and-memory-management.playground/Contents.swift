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
import PlaygroundSupport

class Tutorial {
  let title: String
  unowned let author: Author
  weak var editor: Editor?

  init(title: String, author: Author) {
    self.title = title
    self.author = author
  }

  deinit {
    print("Goodbye Tutorial \(title)!")
  }

  lazy var makeDescription: () -> String = {
    [unowned self] in
    return "\(self.title) by \(self.author.name)"
  }
}

class Editor {
  let name: String
  var tutorials: [Tutorial] = []

  init(name: String) {
    self.name = name
  }

  deinit {
    print("Goodbye Editor \(name)!")
  }
}

class Author {
  let name: String
  var tutorials: [Tutorial] = []
  
  init(name: String) {
    self.name = name
  }
  
  deinit {
    print("Goodbye Author \(name)!")
  }
}

do {
  let author = Author(name: "Cosmin")
  let tutorial: Tutorial = Tutorial(title: "Memory management", author: author)
  print(tutorial.makeDescription())
  let editor: Editor = Editor(name: "Ray")
  author.tutorials.append(tutorial)
  tutorial.editor = editor
  editor.tutorials.append(tutorial)
}

var counter = 0
var closure = { print(counter) }
counter = 1
closure()

counter = 0
closure = { [counter] in print(counter) }
counter = 1
closure()

func log(message: String) {
  let thread = Thread.current.isMainThread ? "Main" : "Background"
  print("\(thread) thread: \(message)")
}

func addNumbers(upTo range: Int) -> Int {
  log(message: "Adding numbers...")
  return (1...range).reduce(0, +)
}

let queue = DispatchQueue(label: "queue")

func execute<Result>(backgroundWork: @escaping () -> Result, mainWork: @escaping (Result) -> ()) {
  queue.async {
    let result = backgroundWork()
    DispatchQueue.main.async {
      mainWork(result)
    }
  }
}

execute(backgroundWork: { addNumbers(upTo: 100) },
        mainWork:  { log(message: "The sum is \($0)") })

extension Editor {
  func feedback(for tutorial: Tutorial) -> String {
    let tutorialStatus: String
    // Should use the tutorial.content here, really :]
    // Instead, flip a coin
    if arc4random_uniform(10) % 2 == 0 {
      tutorialStatus = "published"
    } else {
      tutorialStatus = "rejected"
    }
    return "Tutorial \(tutorialStatus) by \(self.name)"
  }
  
  func editTutorial(_ tutorial: Tutorial) {
    queue.async() {
      [weak self] in
      
      guard let strongSelf = self else {
        print("I no longer exist so no feedback for you!")
        return
      }
      DispatchQueue.main.async {
        print(strongSelf.feedback(for: tutorial))
      }
    }
  }
}

do {
  let author = Author(name: "Cosmin")
  let tutorial: Tutorial = Tutorial(title: "Memory management", author: author)
  let editor: Editor = Editor(name: "Ray")
  author.tutorials.append(tutorial)
  tutorial.editor = editor
  editor.tutorials.append(tutorial)
  editor.editTutorial(tutorial)
}

PlaygroundPage.current.needsIndefiniteExecution = true

