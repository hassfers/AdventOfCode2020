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
}
