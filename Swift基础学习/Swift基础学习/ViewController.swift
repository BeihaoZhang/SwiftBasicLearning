//
//  ViewController.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/9.
//  Copyright © 2018年 Lincoln. All rights reserved.
//

import UIKit

struct Position {
    var x: Double
    var y: Double
}

typealias Region = (Position) -> Bool

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        enumCall()
//        protocolCall()
//        patternMatchingCall()
        asynchronousClosureAndMemoryManagerment()
        
    }
    
    func asynchronousClosureAndMemoryManagerment() {
        let captureLists = CaptureLists()
        captureLists.capture()
        
    }
    
    func patternMatchingCall() {
        let pattern = PatternMatching()
        pattern.miniExercise()
    }
    
    func enumCall() {
        let enumCall = EnumClass()
        enumCall.enumPrint()
    }
    
    func protocolCall() {
        let protocolCall = ProtocolClass()
        protocolCall.test()
        
    }


}

