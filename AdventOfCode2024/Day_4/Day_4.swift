//
//  Day_4.swift
//  AdventOfCode2020
//
//  Created by Stefan Haßferter on 03.12.20.
//

import Foundation

enum Day_4: Day {
    static var day: Input.Day = .Day_4

    static func solvePart1(input: [String]) -> String {
        var passwordStrings = extractPassportData(input: input)
        let jsonDecoder = JSONDecoder()
        passwordStrings = passwordStrings.filter{
            ((try? jsonDecoder.decode(PassPort.self, from: $0)) != nil)
        }
        return "\(passwordStrings.count)"
    }

    static func solvePart2(input: [String]) -> String {
        let passwordStrings = extractPassportData(input: input)
        let jsonDecoder = JSONDecoder()
        let passports = passwordStrings.map{
            try? jsonDecoder.decode(ValidPassPort.self, from: $0)
        }.filter{
            $0 != nil
        }
        return "\(passports.count)"
    }

    static func extractPassportData(input:[String]) -> [Data] {
        var array = [Data]()
        var working = ""
        input.forEach { (line) in
            if line.isEmpty {
                working = String(working.dropLast())
                array.append(try! JSONSerialization.data(withJSONObject: working.split(separator: " ").toDict, options: .fragmentsAllowed))
                working = ""
            } else{
                working.append(line)
                working.append(" ")
            }

        }
        array.append(try! JSONSerialization.data(withJSONObject: working.split(separator: " ").toDict, options: .fragmentsAllowed))
        return array
    }

    struct PassPort: Codable {
        let byr: String
        let iyr: String
        let eyr: String
        let hgt: String
        let hcl: String
        let ecl: String
        let pid: String
    }

    struct serErr: Error {
    }


    struct ValidPassPort: Codable {
        let byr: Int
        let iyr: Int
        let eyr: Int
        let hgt: String
        let hcl: String
        let ecl: EyeColor
        let pid: String

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            //        byr (Birth Year) - four digits; at least 1920 and at most 2002.
            let stringbyr = try container.decode(String.self, forKey: .byr)
            byr = Int(stringbyr)!
            if !(1920...2002).contains(byr) {
                throw serErr()
            }
            //        iyr (Issue Year) - four digits; at least 2010 and at most 2020.
            let stringIyr = try container.decode(String.self, forKey: .iyr)
            iyr = Int(stringIyr)!
            if !(2010...2020).contains(iyr) {
                throw serErr()
            }
            //        eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
            let stringEyr = try container.decode(String.self, forKey: .eyr)
            eyr = Int(stringEyr)!
            if !(2020...2030).contains(eyr) {
                throw serErr()
            }
            //        hgt (Height) - a number followed by either cm or in:
            //        If cm, the number must be at least 150 and at most 193.
            hgt = try container.decode(String.self, forKey: .hgt)
            if hgt.contains("cm"),
               let value = Int(hgt.dropLast(2)){
                if !(150...193).contains(value) {
                    throw serErr()
                }
                //        If in, the number must be at least 59 and at most 76.
            } else if hgt.contains("in"),
                      let value = Int(hgt.dropLast(2)){
                if !(59...76).contains(value) {
                    throw serErr()
                }
            } else { throw serErr()}

            //        hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
            hcl = try container.decode(String.self, forKey: .hcl)

            if (!hcl.starts(with: "#")) {
                throw serErr()
            }
            if hcl.count != 7 {
                throw serErr()
            }
            if (hcl.range(of: "[a-z0-9]", options: .regularExpression) == nil) {
                throw serErr()
            }

            //        ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
            ecl = try container.decode(EyeColor.self, forKey: .ecl)
            //        pid (Passport ID) - a nine-digit number, including leading zeroes.
            pid = try container.decode(String.self, forKey: .pid)
            if !(pid.count == 9) {
                throw serErr()
            }
            //        cid (Country ID) - ignored, missing or not.
        }

        enum CodingKeys:CodingKey {
            case byr
            case iyr
            case eyr
            case hgt
            case hcl
            case ecl
            case pid
        }


        enum EyeColor:String,Codable {
            case amb, blu, brn, gry, grn, hzl, oth
        }
    }
}

