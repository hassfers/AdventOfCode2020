// https://adventofcode.com/2020/day/6

enum Day_6:Day {
  static var day: Input.Day = .Day_6

    static func solvePart1(input: [String]) -> String {
        let array = input.split(separator: "").map{Array($0)}
        let questions = array.map{Questions(input: $0).positiveQuestions}
        return "\(questions.reduce(0, +))"
    }

    static func solvePart2(input: [String]) -> String {
        return "add some code here"
    }

    struct Questions {
        let groupSize: Int
        let positiveQuestions: Int
//        let questionStrings : [String]

        init(input: [String]) {
            groupSize = input.count
            let string = input.joined(separator: "")
            positiveQuestions = Set(string).count
        }
    }
}
