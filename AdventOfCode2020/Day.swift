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
        print("********** \(day) Year 2020 **********")
        print("Solution for Part 1: \(solvePart1(input: input()))")
        print("Solution for Part 2: \(solvePart2(input: input()))")
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
