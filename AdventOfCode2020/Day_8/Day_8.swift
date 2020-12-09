// https://adventofcode.com/2020/day/8
import Foundation

enum Day_8:Day {
    static var day: Input.Day = .Day_8

    static func solvePart1(input: [String]) -> String {
          let computer = Computer(inputString: input)
//        computer.run()
        return "\(computer.accumulator)"
    }

    static func solvePart2(input: [String]) -> String {
        let example =  [
            "nop +0",
            "acc +1",
            "jmp +4",
            "acc +3",
            "jmp -3",
            "acc -99",
            "acc +1",
            "jmp -4",
            "acc +6"
        ]


        var computer = Computer(inputString: input)
        let indices = computer.instructions.enumerated().map{
            ($0.element.operation == .jmp || $0.element.operation == .nop) ? $0.offset : -1
        }.filter{
            $0 != -1
        }

        for index in indices {
            if computer.instructions[index].operation == .jmp {
                computer.instructions[index] = Computer.Instruction(operation: .nop, argument:computer.instructions[index].argument)

            } else if computer.instructions[index].operation == .nop {
                computer.instructions[index] = Computer.Instruction(operation: .jmp, argument:computer.instructions[index].argument)
            }
            do {
                try computer.runFailure()
                print(computer.accumulator)
                print("computer finished")
                return ""
            } catch {
                computer = Computer(inputString: input)
            }
        }

        return "\(computer.accumulator)"
    }
}
