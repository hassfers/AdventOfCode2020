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
            let test = example [preambleLenght]
            if !isValidNumber(preamble: pre, number: test){
                return "\(test)"
            }
            example.removeFirst()
        }
        return "add some code here"
    }

    static func solvePart2(input: [Int]) -> String {
        let time = Date()
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

        for (index,_) in example.enumerated(){
            var array = [example[index]]
            var innercount = index + 1
            while array.sum < valid, innercount < example.count {
                array.append(example[innercount])
                innercount += 1
            }
            if array.sum == valid{
                print("found")
                print(array)
                print("\((Date().timeIntervalSinceReferenceDate - time.timeIntervalSinceReferenceDate))")
                return "\(array.min()! + array.max()!)"
            }
        }
        return "add some code here"
    }

    static func isValidNumber(preamble:[Int],number:Int) -> Bool {
        var validNumbers = [Int]()
        for index in 0..<preamble.count{
            let first = preamble[index]
            let innerArray = preamble.dropFirst(index+1)
            validNumbers.append(contentsOf: innerArray.map{
                first != $0 ? first+$0 : -1
            }.filter({
                $0 != -1
            }))
        }

        return validNumbers.contains(number)
    }
}
