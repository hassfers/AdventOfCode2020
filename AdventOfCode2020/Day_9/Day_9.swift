// https://adventofcode.com/2020/day/9
import Foundation
enum Day_9:Day {
    static var day: Input.Day = .Day_9

    static func solvePart1(input: [Int]) -> String {
        var example = [
            35,
            20,
            15,
            25,
            47,
            40,
            62,
            55,
            65,
            95,
            102,
            117,
            150,
            182,
            127,
            219,
            299,
            277,
            309,
            576
        ]

        example = input

        let preambleLenght = 25

        while example.count + 1 > (preambleLenght + 1) {
            let pre = Array(example.prefix(preambleLenght))
            let test = example[preambleLenght]
            if !isValidNumber(preamble: pre, number: test){
                return "\(test)"
            }
            example.removeFirst()
        }
        return "add some code here"
    }

    static func solvePart2(input: [Int]) -> String {
        let valid = 70639851
        var example = [
            35,
            20,
            15,
            25,
            47,
            40,
            62,
            55,
            65,
            95,
            102,
            117,
            150,
            182,
            127,
            219,
            299,
            277,
            309,
            576
        ]

        example = input

        for (index, value) in example.enumerated(){
            var start = value
            var  innercount = index + 1
            while start < valid,
                  innercount < example.count {
                start += example[innercount]
                innercount += 1
            }
            if start == valid{
                let array = example[index...innercount - 1]
              return "\(array.min()! + array.max()!)"
            }
        }
        return "error"
    }

    static func isValidNumber(preamble:[Int],number:Int) -> Bool {
        var validNumbers = [Int]()
        preamble.enumerated().forEach{ element in
            let innerArray = preamble.dropFirst(element.offset+1)
            validNumbers.append(contentsOf: innerArray.map{element.element+$0})
        }

        return validNumbers.contains(number)
    }
}
