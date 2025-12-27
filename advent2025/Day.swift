//
//  Untitled.swift
//  advent2025
//
//  Created by Brent Amersbach on 12/4/25.
//
import Foundation

class Day {
    let num: Int
    var input: String = ""
    
    init(num: Int) {
        self.num = num
    }
    
    init(num: Int, input: String) {
        self.num = num
        self.input = input
    }

    func loadInputFile(from filePath: String) -> String {
        var fileContent: String = ""
        do {
            try fileContent = String(contentsOfFile: filePath, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        } catch {
            print("Error reading file content: \(error)")
            exit(EXIT_FAILURE)
        }
        return fileContent
    }

    func run() {
        return
    }
}
