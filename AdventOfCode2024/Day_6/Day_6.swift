// https://adventofcode.com/2020/day/6

enum Day_6:Day {
  static var day: Input.Day = .Day_6

    static func solvePart1(input: [[String]]) -> String {
        "\(input.map{Questions(input: $0).positiveQuestions}.sum)"
    }

    static func solvePart2(input: [[String]]) -> String {
        "\(input.map{Questions(input2: $0).positiveQuestions}.sum)"
    }

    struct Questions {
        let groupSize: Int
        let positiveQuestions: Int

        init(input: [String]) {
            groupSize = input.count
            let string = input.joined(separator: "")
            positiveQuestions = Set(string).count
        }

        init(input2: [String]) {
            groupSize = input2.count
            let array = input2.map{Set($0)}
            var workingSet = array.first!
            array.forEach { (element) in
                workingSet = workingSet.intersection(element)
            }
            positiveQuestions = workingSet.count
        }
    }
}
