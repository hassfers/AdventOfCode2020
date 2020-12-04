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
}

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
