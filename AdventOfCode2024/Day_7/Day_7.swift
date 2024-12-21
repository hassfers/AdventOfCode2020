// https://adventofcode.com/2020/day/7

import Foundation

enum Day_7:Day {
    static var day: Input.Day = .Day_7

    static func solvePart1(input: [String]) -> String {
        let number = recursiveBagSearchOne(input: input, color: "shiny gold")

        return "\(Set(number).count)"
    }

    static func solvePart2(input: [String]) -> String {
        let example = [
            "shiny gold bags contain 2 dark red bags.",
            "dark red bags contain 2 dark orange bags.",
            "dark orange bags contain 2 dark yellow bags.",
            "dark yellow bags contain 2 dark green bags.",
            "dark green bags contain 2 dark blue bags.",
            "dark blue bags contain 2 dark violet bags.",
            "dark violet bags contain no other bags."
        ]

        let example2 = [
            "light red bags contain 1 bright white bag, 2 muted yellow bags.",
            "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
            "bright white bags contain 1 shiny gold bag.",
            "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
            "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
            "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
            "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
            "faded blue bags contain no other bags.",
            "dotted black bags contain no other bags."
        ]

        //        recursiveBagSearchTwo(input: expample, color: "shiny gold")
        return "\( recursiveBagSearchTwo(input: input, color: "shiny gold"))"
    }

    static func recursiveBagSearchOne(input: [String], color: String) -> [String] {
        let outerBags = input.filter {
            !$0.starts(with: color) && $0.contains(color)
        }.map{
            $0.split(separator: " ")
                .firstElements(n: 2)
                .joined(separator: " ")
        }

        var colors = outerBags
        let allColors = outerBags.flatMap{
            colors.append( contentsOf: recursiveBagSearchOne(input: input, color: $0))
        }
        return colors
    }


    static func recursiveBagSearchTwo(input: [String], color: String) -> Int {
        // filter inner bags
        return input.filter {
            $0.starts(with: color)
        }.flatMap{
            $0.dropFirst(color.count + 6 + 8)
                .replacingOccurrences(of: "bags", with: "")
                .replacingOccurrences(of: "bag", with: "")
                .replacingOccurrences(of: ".", with: "")
                .split(separator: ",")
                .map{
                    $0.trimmingCharacters(in: .whitespaces)
                }

        // count recrusiv 
        }.reduce(0){ (result,next) -> Int in
            let array = next.split(separator: " ")
            let count = Int(array[0]) ?? 0
            return result + count + count * (array.count == 3 ? recursiveBagSearchTwo(input: input, color: (array[1] + " " + array[2])) : 1)
        }
    }
}

