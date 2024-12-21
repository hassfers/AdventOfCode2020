#!/usr/bin/env xcrun swift

import Foundation

let currentDirectory = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)

for day in 1...25 {
    let templateString =
        """
// https://adventofcode.com/2020/day/\(day)

enum Day_\(day):Day {
  static var day: Input.Day = .Day_\(day)

    static func solvePart1(input: [String]) -> String {
        return "add some code here"
    }

    static func solvePart2(input: [String]) -> String {
        return "add some code here"
    }
}

"""
    let filePathDay = currentDirectory
        .appendingPathComponent("Day_\(day)")
        .appendingPathComponent("Day_\(day).swift")

    let filePathInput = currentDirectory
        .appendingPathComponent("Day_\(day)")
        .appendingPathComponent("Day_\(day)_Input")


    try FileManager.default.createDirectory(at: filePathDay.deletingLastPathComponent(),
                                            withIntermediateDirectories: true)

    if FileManager.default.fileExists(atPath: filePathDay.path) {
        print("file with \(filePathDay.lastPathComponent) already exists")
    } else {
        do {
            try templateString.write(to: filePathDay, atomically: true, encoding: .utf8)
            print(filePathDay)
        } catch _ {
            print("An error occurred while writing to \(filePathDay)")
        }
    }


    if FileManager.default.fileExists(atPath: filePathInput.path) {
        print("file with \(filePathInput.lastPathComponent) already exists")
    } else {
        do {
            try "".write(to: filePathInput, atomically: true, encoding: .utf8)
            print(filePathInput)
        } catch _ {
            print("An error occurred while writing to \(filePathInput)")
        }

    }

}

