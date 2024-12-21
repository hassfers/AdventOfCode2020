//
//  DayOne.swift
//  AdventOfCode2020
//
//  Created by Stefan Haßferter on 01.12.20.
//

import Foundation


enum Day_1: Day {

    static var day: Input.Day {
        .Day_1
    }

    static func solvePart1(input: [Int]) -> String {
        var returnString = ""
        var intArray = input

        while !intArray.isEmpty {
            let first = intArray.first!
            intArray = Array( intArray.dropFirst())
            intArray.forEach{
                if first + $0 == 2020 {
                    intArray.removeAll()
                    returnString = "\(first * $0)"
                }
            }
        }
        return returnString
    }

    static func solvePart2(input: [Int]) -> String {
        var returnString = ""
        let intArray = input

        for firstIndex in 0..<intArray.count {
            let first = intArray[firstIndex]
            for secondIndex in firstIndex..<intArray.count {
                let second = intArray[secondIndex]
                intArray.dropFirst(secondIndex).forEach{
                    if first + second + $0 == 2020 {
                        returnString = "\(first * second * $0)"
                        return
                    }
                }
            }
        }
        return returnString
    }
}
