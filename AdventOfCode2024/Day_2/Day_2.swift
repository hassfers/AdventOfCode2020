//
//  DayTwo.swift
//  AdventOfCode2020
//
//  Created by Stefan Haßferter on 02.12.20.
//

import Foundation

enum Day_2: Day {
    static func solvePart1(input: [String]) -> String {
        "\(input.filter { validatePartOne(password: $0)}.count)"
    }

    static func solvePart2(input: [String]) -> String {
        "\(input.filter { validatePartTwo(password: $0)}.count)"
    }

    static var day: Input.Day = .Day_2

    static func extractParameter(passwordString: String) -> (min:Int, max:Int, letter:String, rawPassword:String) {
        let parts = passwordString.split(separator: " ")
        let numbers = parts[0].split(separator:"-")
        let minimum = Int(String(numbers[0]))!
        let maximum = Int(String(numbers[1]))!
        let letter = String(parts[1].dropLast())
        let rawPassword = String(parts[2])

        return (minimum,maximum,letter,rawPassword)
    }

    static func validatePartOne(password: String) -> Bool{
        //    "2-5 l: fllxf"
        var parameters = extractParameter(passwordString: password)

        parameters.rawPassword.removeAll { (Character) -> Bool in
            String(parameters.letter) != String(Character)
        }

        return (parameters.rawPassword.count >= parameters.min)
            && (parameters.rawPassword.count <= parameters.max)
    }

    static func validatePartTwo(password: String) -> Bool{
        //    "2-5 l: fllxf"
        let parameters = extractParameter(passwordString: password)

        let pattern = (String(parameters.rawPassword[(parameters.min-1)]) == parameters.letter,
                       String(parameters.rawPassword[(parameters.max-1)]) == parameters.letter)

        return pattern.0 && !pattern.1 || pattern.1 && !pattern.0
    }
}

