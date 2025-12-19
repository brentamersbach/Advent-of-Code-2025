//
//  Advent2025.swift
//  advent2025
//
//  Created by Brent Amersbach on 12/4/25.
//
import Darwin

@main struct Advent2025 {
    static func getDayFromCLI(from days:[Day]) -> Int? {
        // Check for selected day on the command line
        if CommandLine.arguments.count > 1 {
            let dayString = CommandLine.arguments[1]
            if let dayInt = dayString.first?.wholeNumberValue {
                return dayInt
            }
        }
        return nil
    }
    
    static func getInputFilePath() -> String {
        if CommandLine.arguments.count > 2 {
            return CommandLine.arguments[2]
        } else { return "" }
    }
    
    static func getDayFromUser(from days:[Day]) -> Int {

        // Ask user for day
        print("Which day would you like to run?")
        for day in days {
            print("Day \(day.num)")
        }
        let response = readLine()
        if let dayString = response {
            return Int(dayString) ?? 0
        } else {
            return 0
        }
    }
    
    static let inputFilePath = getInputFilePath()
    
    static func main() throws {
        var days: [Day] = [Day_1(), Day_2(), Day_3(), Day_4(input: self.inputFilePath), Day_5(input: self.inputFilePath)]
        
        var selectedDay: Int
        if let dayFromCLI = getDayFromCLI(from: days) {
            selectedDay = dayFromCLI
        } else {
            selectedDay = getDayFromUser(from: days)
        }
        
//        while true {
            if let day = days.first(where: { day in
                if day.num == selectedDay {
                    return true
                } else {
                    return false
                }
            }) {
                day.run()
                print("\n------------\n")
//                selectedDay = getDayFromUser(from: days)
            } else { exit(EXIT_SUCCESS) }
//        }
    }
}
