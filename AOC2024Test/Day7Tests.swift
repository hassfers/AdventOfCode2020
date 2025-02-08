//
//  AOC2024Test.swift
//  AOC2024Test
//
//  Created by Stefan Haßferter on 14.12.24.
//

import XCTest
import AOC2024



class Day7: Day {
    
    
    var example: [String]?
    
    var day: Input.Day = .Day_6
    func solvePart1(input: [String]) -> String {
        let results = input.map { Int($0.split(separator: ":").first!)! }
        let operators = input.map { $0.split(separator: ":").last!.split(separator: " ").map({ Int($0)! }) }
        
        let calculations = zip(results, operators).filter { result,operators in
            createAllResults(operators: operators)
            
            
            
            
            return true
        }
        
        return ""
    }
    
    func createAllResults(operators:[Int]) -> [Int]{
        var ops = operators
        
        let allsum = operators.sum //        11 + 6 + 16 + 20
        
        let allprod = operators //           11 * 6 * 16 * 20
            .reduce(1) { partialResult, Number in
                partialResult * Number
            }
        
        var allElements = [[Int]]()
        
//        while(!ops.isEmpty) {
//            let lastTwo =  ops.suffix(2)
//            
//        }
        let lastTwo = ops.suffix(2)
        let buff = createAllResults(first: lastTwo.first!, seconds: lastTwo.last!)
        
        var buff2 = ops.prefix(ops.count - 2)
        allElements.append(contentsOf: buff2 + buff)
      
        

//        11 + 6 + 16 + 20 m
//        11 + 6 + 16 * 20 m
//
//        11 + 6 * 16 + 20
//        11 + 6 * 16 * 20
//        
//        11 * 6 + 16 + 20
//        11 * 6 + 16 * 20
//        
//        11 * 6 * 16 + 20 m
//        11 * 6 * 16 * 20 m
        
        
        
        return []
    }
    
    func createAllResults(first: Int, seconds: Int) -> [Int]{
        return [first + seconds,first * seconds]
    }
    
    
    
    
    func solvePart2(input: [String]) -> String {
        return ""
    }
    
    init(example:[String]?){
        self.example = example
    }
    
}




class Day7Tests: XCTestCase {
    let example = Array(arrayLiteral:
                            "190: 10 19",
                        "3267: 81 40 27",
                        "83: 17 5",
                        "156: 15 6",
                        "7290: 6 8 6 15",
                        "161011: 16 10 13",
                        "192: 17 8 14",
                        "21037: 9 7 18 13",
                        "292: 11 6 16 20")
    
    
    func testPartOneExample() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        XCTAssertEqual( Day7(example: example).resultPartOne, "42")
    }
    
    func testPartOnePuzzleExample() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        XCTAssertEqual( Day7(example: nil).resultPartOne, "4559")
    }
    func testPartTwoExample() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        XCTAssertEqual( Day7(example: example).resultPartTwo, "42")
    }
    
    func testPartTwoPuzzleExample() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        XCTAssertEqual( Day7(example: nil).resultPartTwo, "4559")
    }
    
}
