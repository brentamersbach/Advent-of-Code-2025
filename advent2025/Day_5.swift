//
//  Day_5.swift
//  advent2025
//
//  Created by Brent Amersbach on 12/18/25.
//

import Foundation
import Darwin

func parseInput(for content: String) {
    
}

func solvePartA(with input: String) {
    
}

class Day_5: Day {
    init(input: String) {
        super.init(num: 5, input: input)
    }
    
    override func run() {
        print("---Day 5---\n")
        var fileContent: String = ""
        
        do {
            try fileContent = String(contentsOfFile: inputFilePath, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        } catch {
            print("Error reading file content: \(error)")
            exit(EXIT_FAILURE)
        }
        
        solvePartA(with: fileContent)
    }
}
