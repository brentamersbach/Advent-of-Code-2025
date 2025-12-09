//
//  Advent2025.swift
//  advent2025
//
//  Created by Brent Amersbach on 12/4/25.
//

@main struct Advent2025 {
    static func main() throws {
        var days: [Day] = []
        
        let day1=Day_1()
        days.append(day1)
        
//        let day2=Day_2()
//        days.append(day2)
        
        for day in days {
            print("Day \(day.num)\n")
            day.run()
            print("\n------------\n")
        }
    }
}
