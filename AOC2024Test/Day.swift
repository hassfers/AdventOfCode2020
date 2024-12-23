//
//  Day.swift
//  AdventOfCode2020
//
//  Created by Stefan Haßferter on 02.12.20.
//

import Foundation

protocol Day {
    associatedtype InputType
    func input() -> InputType
    
    func solvePart1(input: InputType) -> String
    func solvePart2(input: InputType) -> String
    var day: Input.Day { get }
    var example: InputType? {get}
}

extension Day {
     func solve() {
        let time1 = Date()
        print("********** \(day) Year 2024 **********")
        print("Solution for Part 1: \(solvePart1(input: input())) in \(Date().timeIntervalSinceReferenceDate - time1.timeIntervalSinceReferenceDate) sek")
        let time2 = Date()
        print("Solution for Part 2: \(solvePart2(input: input())) in \(Date().timeIntervalSinceReferenceDate - time2.timeIntervalSinceReferenceDate) sek")
        print("*************************************")
    }

    
    
    func input() -> [String] {
        if (example != nil){
            return example as! [String]
        }
        return Input.getStringArray(for: day)
    }

    func input() -> [Int] {
        if (example != nil){
            return example as! [Int]
        }
        return  Input.getIntArray(for: day)
    }

    func input() -> [[String]]{
        if (example != nil){
            return example as! [[String]]
        }
        return Input.getStringArray(for: day, separeted: "")
    }
}
