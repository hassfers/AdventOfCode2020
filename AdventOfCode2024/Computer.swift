//
//  Computer.swift
//  AdventOfCode2020
//
//  Created by Stefan Haßferter on 08.12.20.
//

import Foundation

class Computer: Codable {
    let backupInstructions: [Instruction]
    var instructions: [Instruction]
    var accumulator = 0
    var stackPointer = 0

    init(inputString:[String]) {
        instructions = inputString.map{Instruction(string: $0)}
        backupInstructions = instructions
    }
    func reset() {
        instructions = backupInstructions
        accumulator = 0
        stackPointer = 0
    }


    func run(){
        var instruction: Instruction
        while stackPointer < instructions.count  {
            instruction = instructions[stackPointer]

            guard !instruction.runned  else {
                break
            }

            instruction.runned = true
            switch instruction.operation {
            case .acc:
                accumulator += instruction.argument
                stackPointer += 1
            case .nop:
                stackPointer += 1
            case .jmp:
                stackPointer += instruction.argument
            }
        }
    }

    func runFailure() throws {
        var instruction: Instruction
        while stackPointer < instructions.count  {
            instruction = instructions[stackPointer]

            guard !instruction.runned  else {
                throw Computererror.repairFailed
            }

            instruction.runned = true
            switch instruction.operation {
            case .acc:
                accumulator += instruction.argument
                stackPointer += 1
            case .nop:
                stackPointer += 1
            case .jmp:
                stackPointer += instruction.argument
            }
        }
    }


}
extension Computer {
    class Instruction: Codable {
        enum Operation: String, Codable {
            case nop, acc, jmp
        }
        let argument: Int
        let operation: Operation
        var runned:Bool = false

        init(string: String) {
            let array = string.split(separator: " ")
            operation = Operation(rawValue: String(array[0]))!
            argument = Int(array[1])!
        }

        init (operation:Operation,argument: Int){
            self.operation = operation
            self.argument = argument
        }
    }
}

extension Computer {
    enum Computererror: Error {
        case repairFailed
    }
}
