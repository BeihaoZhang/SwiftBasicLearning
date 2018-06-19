//
//  ProtocolOrientedProgramming.swift
//  Swift基础学习
//
//  Created by Lincoln on 2018/6/19.
//  Copyright © 2018年 Lincoln. All rights reserved.
//

import Foundation

extension String {
    func shout() {
        print(uppercased())
    }
}
// "Swift is pretty cool".shout()

protocol TeamRecord {
    var wins: Int { get }
    var losses: Int { get }
    var winningPercentage: Double { get }
}

extension TeamRecord {
    var gamesPlayed: Int {
        return wins + losses
    }
    // Protocol中winningPercentage的默认实现
    var winningPercentage: Double {
        return Double(wins) / Double(wins + losses)
    }
}

struct BaseballRecord: TeamRecord {
    var wins: Int
    var losses: Int
    
    var winningPercentage: Double {
        return Double(wins) / Double(wins + losses)
    }
}


class MyTest {
    func myTest() {
        "Swift is pretty cool".shout()
        
        let sanFranciscoSwifts = BaseballRecord(wins: 10, losses: 5)
        print(sanFranciscoSwifts.gamesPlayed)
        
    }
}

protocol Winloss {
    var wins: Int { get }
    var losses: Int { get }
}

extension Winloss {
    var winningPercentage: Double {
        return Double(wins) / Double(wins + losses)
    }
}

struct CricketRecord: Winloss {
    var wins: Int
    var losses: Int
    var draws: Int
    
    var winningPercentage: Double {
        return Double(wins) / Double(wins + losses + draws)
    }
}

/* 虽然 miamiTuples 和 winLoss包含同一个实例变量，但是动态派发要实现哪个是基于它所在的类型决定的
 let miamiTuples = CricketRecord(wins: 8, losses: 7, draws: 1)
 let winLoss: WinLoss = miamiTuples
 miamiTuples.winningPercentage // 0.5
 winLoss.winningPercentage // 0.53 !!!
*/
