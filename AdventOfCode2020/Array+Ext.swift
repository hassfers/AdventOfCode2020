//
//  Array+Ext.swift
//  AdventOfCode2020
//
//  Created by Stefan Haßferter on 06.12.20.
//

import Foundation
extension Array where Element == Substring {
    var toDict: [String:String] {
        var dict = [String:String]()
        self.forEach{
            let array =  $0.split(separator: ":")
            dict[String(array[0])]=String(array[1])
        }
        return dict
    }
}

extension Array where Element == String {
    func splitToSubArrays(with pattern: String) -> [[String]] {
        self.split(separator: pattern).map{Array($0)}
    }
}

extension Array where Element == Int {
    var sum: Int {
        reduce(0, +)
    }
}
