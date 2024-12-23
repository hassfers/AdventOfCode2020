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
        var visited_points = [Point]()
        
        var visited = input
        
        var startingPoint = input.twoDimensionalFirstSearch(string: "^")
        var direction = Direction.UP
        print(startingPoint)
        while(true){
            let result = input.findWay(direction: direction, startPoint: startingPoint)
            do {
                let points = try result.get()
           
                visited_points.append(contentsOf: points)
                if example != nil {
                    print(points)
                    print(visited_points)
                    print(visited_points.count)
                }
                direction = direction.nextDirection
                startingPoint = points.last!
            } catch  {
                print(error)
                if (error is GuardLeaveAreaException) {
                    visited_points.append(contentsOf: error.lastPoints)
                }
                break
            }
        }
        
        if example != nil {
            visited_points.forEach {
                print($0)
                let index = visited[$0.y].index(visited[$0.y].startIndex, offsetBy: $0.x)
                visited[$0.y].replaceSubrange(index...index, with: "X")
                visited.forEach { print($0) }
                print("___")
            }
            
            visited.forEach { print($0) }
            print(visited.map { $0.count { $0 == "X" } }.sum)
        }
        
        return "\(Set(visited_points).count + 1)"
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
            let FullpotentionalWay = self.column(number:startPoint.x)
            let globalStarting = FullpotentionalWay.index(FullpotentionalWay.startIndex, offsetBy: startPoint.y)
            let potentionalWay = FullpotentionalWay.substring(to: globalStarting)
//            let startIndex = potentionalWay.index(potentionalWay.startIndex, offsetBy: startPoint.y, limitedBy: potentionalWay.endIndex)
            if let index = potentionalWay.lastIndex(of: "#") {
                let test = abs( potentionalWay.distance(from: potentionalWay.endIndex, to: index))
                return .success((0..<test).map { Point(x: startPoint.x, y: startPoint.y - $0) })
            } else {
                let test = abs( potentionalWay.distance(from: potentionalWay.endIndex, to: potentionalWay.startIndex))
                return .failure(GuardLeaveAreaException(lastPoints: (0..<test).map { Point(x: startPoint.x, y: startPoint.y - $0) }))
            }
            
        case .DOWN:
            let FullpotentionalWay = self.column(number:startPoint.x)
            let globalStarting = FullpotentionalWay.index(FullpotentionalWay.startIndex, offsetBy: startPoint.y)
            let potentionalWay = FullpotentionalWay.substring(from: globalStarting)
//            let startIndex = potentionalWay.index(potentionalWay.startIndex, offsetBy: startPoint.y, limitedBy: potentionalWay.endIndex)
            if let index = potentionalWay.firstIndex(of: "#") {
                let test = abs( potentionalWay.distance(from: potentionalWay.startIndex, to: index))
                return .success((0..<test).map { Point(x: startPoint.x, y: startPoint.y + $0) })
            } else {
                let test = abs( potentionalWay.distance(from: potentionalWay.startIndex, to: potentionalWay.endIndex))
                return .failure(GuardLeaveAreaException(lastPoints:(0..<test).map { Point(x: startPoint.x, y: startPoint.y + $0) }))
            }
            
        case .LEFT:
            let FullpotentionalWay = self[startPoint.y]
            let globalStarting = FullpotentionalWay.index(FullpotentionalWay.startIndex, offsetBy: startPoint.x)
            let potentionalWay = self[startPoint.y].substring(to: globalStarting)
//            let startIndex = potentionalWay.index(potentionalWay.startIndex, offsetBy: startPoint.x, limitedBy: potentionalWay.endIndex)
            if let index = potentionalWay.lastIndex(of: "#") {
            let test = abs( potentionalWay.distance(from: potentionalWay.endIndex, to: index))
                return .success((0..<test).map { Point(x: startPoint.x - $0, y: startPoint.y) })
            } else {
                let test = abs( potentionalWay.distance(from: potentionalWay.endIndex, to: potentionalWay.startIndex))
                return .failure(GuardLeaveAreaException(lastPoints:(0..<test).map { Point(x: startPoint.x - $0, y: startPoint.y) }))
            }
            
        case .RIGHT:
            
            let FullpotentionalWay = self[startPoint.y]
            let globalStarting = FullpotentionalWay.index(FullpotentionalWay.startIndex, offsetBy: startPoint.x)
            let potentionalWay = FullpotentionalWay.substring(from: globalStarting)
//            let startIndex = potentionalWay.index(potentionalWay.startIndex, offsetBy: startPoint.x, limitedBy: potentionalWay.endIndex)
            if let index = potentionalWay.firstIndex(of: "#") {
                let test = abs( potentionalWay.distance(from: potentionalWay.startIndex, to: index))
                return .success((0..<test).map { Point(x: startPoint.x + $0, y: startPoint.y) })
            } else {
                let test = abs( potentionalWay.distance(from: potentionalWay.startIndex, to: potentionalWay.endIndex))
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
        XCTAssertEqual( Day6(example: example).resultPartOne, "42")
    }
    
    func testPartOnePuzzleExample() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        XCTAssertEqual( Day6(example: nil).resultPartOne, "4559")
    }
    
}
