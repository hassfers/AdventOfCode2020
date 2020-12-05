// https://adventofcode.com/2020/day/5

enum Day_5:Day {
  static var day: Input.Day = .Day_5

    static func solvePart1(input: [String]) -> String {
        return String(input.map{BoardingPass(string: $0).id}.max()!)
    }

    static func solvePart2(input: [String]) -> String {
        let passes = Set(input.map{BoardingPass(string: $0).id})
        var numbers = Set(passes.min()!...passes.max()!)
        numbers.subtract(passes)
        return  numbers.count == 1 ? "\(numbers.first!)" : "error"
    }

    struct BoardingPass {
        let row: Int
        let column: Int

        var id: Int {
            return row * 8 + column
        }

        init(string: String) {
            let rowString = String(string.prefix(7))
            let columString = String(string.suffix(3))
            row = Day_5.BoardingPass.decode(string: rowString, max: 127, min: 0, highPattern: "B", lowPattern: "F")
            column = Day_5.BoardingPass.decode(string: columString, max: 7, min: 0, highPattern: "R", lowPattern: "L")
        }

        private static func decode(string:String, max: Int, min: Int, highPattern:String, lowPattern: String ) -> Int {
            var min = min
            var max = max
            string.forEach{
                if String($0) == lowPattern {
                    max = max - ((max - min) / 2) - 1
                } else {
                    min = min + ((max - min) / 2) + 1
                }
            }
            return min
        }
    }

    
}
