//
//  String+Ext.swift
//  AdventOfCode2020
//
//  Created by Stefan Haßferter on 02.12.20.
//

import Foundation
extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
//    var toDict: [String:String] {
//        let array = self.split(separator: ":")
//        return [String(array[0]):String(array[1])]
//    }

    var trimmedStaringAndEndingWhiteSpaces: String {
        var buffer = self
        while buffer.starts(with: " ") {
            buffer.removeFirst()
        }
        while buffer.last == " " {
            buffer.removeLast()
        }
        return buffer
    }
}
