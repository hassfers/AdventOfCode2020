//
//  Day_3.swift
//  AdventOfCode2020
//
//  Created by Stefan Haßferter on 02.12.20.
//

import Foundation
enum Day_3: Day {
    static func solvePart1(input: [String]) -> String {
        //        234
        return String(searchTrees(horizontalStep: 3, verticalStep: 1, input: input))
    }

    static func solvePart2(input: [String]) -> String {
        //        5813773056
        let inputs = [
            (1,1),
            (3,1),
            (5,1),
            (7,1),
            (1,2)
        ]

        let treeCounts = inputs.map {
            searchTrees(horizontalStep: $0.0, verticalStep: $0.1, input: input)
        }
        .reduce(1, *)

        return String(treeCounts)
    }


    static var day: Input.Day {
        .Day_3
    }

    private static func searchTrees(horizontalStep: Int,
                                    verticalStep: Int,
                                    input:[String]) -> Int{
        var treeCount = 0
        var verticalCounter = verticalStep
        var positionCounter = horizontalStep

        while verticalCounter < input.count {
            if input[verticalCounter][positionCounter] == "#" {
                treeCount += 1
            }

            positionCounter += horizontalStep
            positionCounter %= input[verticalCounter].count
            verticalCounter += verticalStep
        }
        return treeCount
    }
}

