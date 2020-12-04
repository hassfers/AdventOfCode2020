//
//  ReadInput.swift
//  AdventOfCode
//
//  Created by Marcus Gollnick on 01.12.20.
//

import Foundation

enum Input {

    enum Day: String, CaseIterable {
        case Day_1, Day_2, Day_3, Day_4, Day_5, Day_6,
             Day_7, Day_8, Day_9, Day_10, Day_11, Day_12,
             Day_13, Day_14, Day_15, Day_16, Day_17, Day_18,
             Day_19, Day_20, Day_21, Day_22, Day_23, Day_24, Day_25
    }

    static func getIntArray(for day: Day) -> [Int] {
        let stringArray = getStringArray(for: day)
        let intContent = stringArray.compactMap({ Int($0) })
        return intContent
    }

    static func getStringArray(for day: Day) -> [String] {
        let url = URL(fileURLWithPath: #file)
            .deletingLastPathComponent()
            .appendingPathComponent(day.rawValue)
            .appendingPathComponent("\(day.rawValue)_Input")
        
        guard let stringContent = try? String(contentsOf: url) else {
            print("Could not read content this file here: \(url)")
            return []
        }
        return stringContent.components(separatedBy: "\n").dropLast()
    }
}
