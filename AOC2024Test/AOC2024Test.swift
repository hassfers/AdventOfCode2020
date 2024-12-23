//
//  AOC2024Test.swift
//  AOC2024Test
//
//  Created by Stefan Haßferter on 14.12.24.
//

import XCTest
import AOC2024

enum Direction {
    case UP, RIGHT, DOWN, LEFT
    
    var nextDirection: Direction {
        switch(self) {
        case .UP:
                .RIGHT
        case .RIGHT:
                .DOWN
        case .DOWN:
                .LEFT
        case .LEFT:
                .UP
        }
    }
}

struct Point: Hashable{
    let x:Int
    let y:Int
}

class Day6: Day {
    
    
    var example: [String]?
    
    var day: Input.Day = .Day_6
    func solvePart1(input: [String]) -> String {
        var visited_points = Set<Point>()
        
        var startingPoint = input.twoDimensionalFirstSearch(string: "^")
        var direction = Direction.UP
        print(startingPoint)
        while(true){
            let result = input.findWay(direction: direction, startPoint: startingPoint)
            do {
                let points = try result.get()
                print(points)
                visited_points = visited_points.union(points)
                print(visited_points)
                print(visited_points.count)
                direction = direction.nextDirection
                startingPoint = points.last!
            } catch  {
                print(error)
                break
            }
        }
        
        return "\(visited_points.count)"
    }
    func solvePart2(input: [String]) -> String {
        return ""
    }
    
    init(example:[String]?){
        self.example = example
    }
    
}

extension Array where Element == String {
    
    func column(number: Int) -> String {
        return String(
            self.map { String($0[number])}
                .joined())
    }
    
    func findWay(direction: Direction, startPoint: Point) -> Result<[Point],GuardLeaveAreaException> {
        switch direction {
        case .UP:
            let potentionalWay = self.column(number:startPoint.x)
            let startIndex = potentionalWay.index(potentionalWay.startIndex, offsetBy: startPoint.y, limitedBy: potentionalWay.endIndex)
            if let index = potentionalWay.firstIndex(of: "#") {
                let test = abs( potentionalWay.distance(from: startIndex!, to: index))
                return .success((0..<test).map { Point(x: startPoint.x, y: startPoint.y - $0) })
            } else {
                let test = abs( potentionalWay.distance(from: startIndex!, to: potentionalWay.startIndex))
                return .failure(GuardLeaveAreaException(lastPoints: (0..<test).map { Point(x: startPoint.x, y: startPoint.y - $0) }))
            }
            
        case .DOWN:
            let potentionalWay = self.column(number:startPoint.x)
            let startIndex = potentionalWay.index(potentionalWay.startIndex, offsetBy: startPoint.y, limitedBy: potentionalWay.endIndex)
            if let index = potentionalWay.firstIndex(of: "#") {
                let test = abs( potentionalWay.distance(from: startIndex!, to: index))
                return .success((0..<test).map { Point(x: startPoint.x, y: startPoint.y + $0) })
            } else {
                let test = abs( potentionalWay.distance(from: startIndex!, to: potentionalWay.endIndex))
                return .failure(GuardLeaveAreaException(lastPoints:(0..<test).map { Point(x: startPoint.x, y: startPoint.y + $0) }))
            }
            
        case .LEFT:
            let FullpotentionalWay = self[startPoint.y]
            let globalStarting = FullpotentionalWay.index(FullpotentionalWay.startIndex, offsetBy: startPoint.x)
            let potentionalWay = self[startPoint.y].substring(to: globalStarting)
            let startIndex = potentionalWay.index(potentionalWay.startIndex, offsetBy: startPoint.x, limitedBy: potentionalWay.endIndex)
            if let index = potentionalWay.lastIndex(of: "#") {
                let test = abs( potentionalWay.distance(from: startIndex!, to: index))
                return .success((0..<test).map { Point(x: startPoint.x - $0, y: startPoint.y) })
            } else {
                let test = abs( potentionalWay.distance(from: startIndex!, to: potentionalWay.startIndex))
                return .failure(GuardLeaveAreaException(lastPoints:(0..<test).map { Point(x: startPoint.x - $0, y: startPoint.y) }))
            }
            
        case .RIGHT:
            
            let FullpotentionalWay = self[startPoint.y]
            let globalStarting = FullpotentionalWay.index(FullpotentionalWay.startIndex, offsetBy: startPoint.x)
            let potentionalWay = self[startPoint.y].substring(from: globalStarting)
            let startIndex = potentionalWay.index(potentionalWay.startIndex, offsetBy: startPoint.x, limitedBy: potentionalWay.endIndex)
            if let index = potentionalWay.firstIndex(of: "#") {
                let test = abs( potentionalWay.distance(from: startIndex!, to: index))
                return .success((0..<test).map { Point(x: startPoint.x + $0, y: startPoint.y) })
            } else {
                let test = abs( potentionalWay.distance(from: startIndex!, to: potentionalWay.endIndex))
                return .failure(GuardLeaveAreaException(lastPoints:(0..<test).map { Point(x: startPoint.x + $0, y: startPoint.y) }))
            }
        }
    }
    
    func twoDimensionalFirstSearch(string: String) -> Point {
        for (y, row) in self.enumerated() {
            for (x, char) in row.enumerated() {
                if String(char) == string {
                    return Point(x: x, y: y)
                }
            }
        }
        return Point(x: -1, y: -1)
    }
    
}

struct GuardLeaveAreaException: Error {
    let lastPoints: [Point]
}



class AOC2024Test: XCTestCase {
    let example = Array(arrayLiteral:
                            "....#.....",
                        ".........#",
                        "..........",
                        "..#.......",
                        ".......#..",
                        "..........",
                        ".#..^.....",
                        "........#.",
                        "#.........",
                        "......#...")
    
    
    func testPartOneExample() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        Day6(example: example).solve()
    }
    
    func testPartOnePuzzleExample() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        Day6(example: nil).solve()
    }
    
}
