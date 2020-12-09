//
//  Day.swift
//  AdventOfCode2020
//
//  Created by Stefan Haßferter on 02.12.20.
//

import Foundation

protocol Day {
    associatedtype InputType
    static func input() -> InputType
    
    static func solvePart1(input: InputType) -> String
    static func solvePart2(input: InputType) -> String
    static var day: Input.Day { get }

}

extension Day {
    static func solve() {
        let time1 = Date()
        print("********** \(day) Year 2020 **********")
        print("Solution for Part 1: \(solvePart1(input: input())) in \(Date().timeIntervalSinceReferenceDate - time1.timeIntervalSinceReferenceDate) sek")
        let time2 = Date()
        print("Solution for Part 2: \(solvePart2(input: input())) in \(Date().timeIntervalSinceReferenceDate - time2.timeIntervalSinceReferenceDate) sek")
        print("*************************************")
    }

    static func input() -> [String] { 
        Input.getStringArray(for: day)
    }

    static func input() -> [Int] {
        Input.getIntArray(for: day)
    }

    static func input() -> [[String]]{
        Input.getStringArray(for: day, separeted: "")
    }
}
