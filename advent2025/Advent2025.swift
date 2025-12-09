//
//  Advent2025.swift
//  advent2025
//
//  Created by Brent Amersbach on 12/4/25.
//
import Darwin

@main struct Advent2025 {
    static func getDay(from days:[Day]) -> Int {
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
    
    static func main() throws {
        var days: [Day] = []
        
        let day1=Day_1()
        days.append(day1)
        
        let day2=Day_2()
        days.append(day2)
        
        while true {
            let selectedDay = getDay(from: days)
            if let day = days.first(where: { day in
                if day.num == selectedDay {
                    return true
                } else {
                    return false
                }
            }) {
                day.run()
            } else { fputs("Invalid day", stderr) }
        }
    }
}
