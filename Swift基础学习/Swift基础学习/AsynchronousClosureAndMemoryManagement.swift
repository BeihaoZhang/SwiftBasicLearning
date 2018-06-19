//
//  AsynchronousClosureAndMemoryManagement.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/16.
//  Copyright © 2018年 Lincoln. All rights reserved.
//

import Foundation

class Tutorial2 {
    let title: String
    // weak是弱引用，肯定是用在可选值中的，因为它在对象的引用计数为0时，将对象置为nil。
    weak var editor: Editor?
    // unowned是弱引用，但不会使对象的引用计数为0时置为nil
    unowned let author: Author
    init(title: String, author: Author) {
        self.title = title
        self.author = author
    }
    
    lazy var createDescription: () -> String = {
        // 通过对 self 进行弱引用来打破引用循环
        [unowned self] in
        return "\(self.title) by \(self.author.name)"
    }
    
    deinit {
        print("Goodbye Tutorial \(title)!")
    }
}

class Editor {
    let name: String
    let tutorials: [Tutorial2] = []
    
    init(name: String) {
        self.name = name
    }
    
    func myTest() {
        // 别忘了通过self来传入
        execute(backgroundWork: { self.addNumbers(upTo: 100) },
                mainWork: { self.log(message: "The sum is \($0)") })
    }
    func log(message: String) {
        let thread = Thread.current.isMainThread ? "Main" : "Background"
        print("\(thread) thread: \(message)")
    }
    
    func addNumbers(upTo range: Int) -> Int {
        log(message: "Adding numbers...")
        return (1...range).reduce(0, +)
    }
    
    let queue = DispatchQueue(label: "queue")
    
    // 1
    func execute<Result>(backgroundWork: @escaping () -> Result,
                         mainWork: @escaping (Result) -> ()) {
        // 2
        queue.async {
            let result = backgroundWork()
            // 3
            DispatchQueue.main.async {
                mainWork(result)
            }
        }
    }
    
    deinit {
        print("Goodbye Author \(name)!")
    }
}

extension Editor {
    func feedback(for tutorial: Tutorial2) -> String {
        let tutorialStatus: String
        if arc4random_uniform(10) % 2 == 0 {
            tutorialStatus = "published"
        } else {
            tutorialStatus = "rejected"
        }
        return "Tutorial \(tutorialStatus) by \(self.name)"
    }
    
    func editTutorial(_ tutorial: Tutorial2) {
        queue.async() {
            /*
             虽然没有引用循环，但是在运行时会崩溃
             // the editor went out of scope before editTutorial had completed, self.feedback would crash when it eventually executed.
             
            [unowned self] in
            let feedback = self.feedback(for: tutorial)
            DispatchQueue.main.async(execute: {
                print(feedback)
            })
             */
            
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

class Author {
    let name: String
    var tutorials: [Tutorial2] = []
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
         print("Goodbye Author \(name)!")
    }
}

class CaptureLists {
    func capture() {
        var counter = 0
        var closure = { print("counter = \(counter)") }
        counter = 1
        closure() // counter = 1。因为闭包捕获了counter变量，强引用了它，而不是拷贝。
        closure = { [counter] in print("counter = \(counter)") } // counter = 1。将 counter 拷贝到了一个新的局部常量中，并且同名
        counter = 2
        closure()
    }
}

class AsyncClosures {
    func myTest() {
        // 别忘了通过self来传入
        execute(backgroundWork: { self.addNumbers(upTo: 100) },
                mainWork: { self.log(message: "The sum is \($0)") })
    }
    func log(message: String) {
        let thread = Thread.current.isMainThread ? "Main" : "Background"
        print("\(thread) thread: \(message)")
    }

    func addNumbers(upTo range: Int) -> Int {
        log(message: "Adding numbers...")
        return (1...range).reduce(0, +)
    }

    let queue = DispatchQueue(label: "queue")

    // 1
    func execute<Result>(backgroundWork: @escaping () -> Result,
                         mainWork: @escaping (Result) -> ()) {
        // 2
        queue.async {
            let result = backgroundWork()
            // 3
            DispatchQueue.main.async {
                mainWork(result)
            }
        }
    }


}
