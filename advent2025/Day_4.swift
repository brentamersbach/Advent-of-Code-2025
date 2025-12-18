//
//  Day_4.swift
//  advent2025
//
//  Created by Brent Amersbach on 12/12/25.
//

import Foundation
import Darwin

struct Roll: Identifiable {
    let id = UUID()
}

enum Direction {
    case up
    case down
    case left
    case right
    case upleft
    case upright
    case downleft
    case downright
}
extension Direction: CaseIterable {}

class Day_4: Day {
    let inputFilePath: String
    var fileContent = ""
    
    init(input: String) {
        self.inputFilePath = input
        super.init(num: 4)
    }
    
    func generateGrid(from data: [String.SubSequence]) -> [[Roll?]] {
        var grid: [[Roll?]] = []
        var rows: [String] = []
        for line in data {
            rows.append(String(line))
        }
        for i in 0...(rows.count - 1) {
            let rowSring = rows[i]
            var rowArray: [Roll?] = []
            for char in rowSring {
                if char == "@" {
                    rowArray.append(Roll())
                } else {
                    rowArray.append(nil)
                }
                
            }
            grid.append(rowArray)
        }
        return grid
    }
    
    func getRoll(at coordinate: (x: Int, y: Int), in grid: [[Roll?]]) -> Roll? {
        return grid[coordinate.y][coordinate.x]
    }
    
    func checkNeighbor(toward direction: Direction, for coordinate: (x: Int, y: Int), in grid: [[Roll?]]) -> Bool {
        switch direction {
        case .up:
            let target = (x: coordinate.x, y: coordinate.y - 1)
            if target.y < 0 {
                return false
            } else { return getRoll(at: target, in: grid) != nil }
        case .down:
            let target = (x: coordinate.x, y: coordinate.y + 1)
            if target.y >= grid.count {
                return false
            } else { return getRoll(at: target, in: grid) != nil }
        case .left:
            let target = (x: coordinate.x - 1, y: coordinate.y)
            if target.x < 0 {
                return false
            } else { return getRoll(at: target, in: grid) != nil }
        case .right:
            let target = (x: coordinate.x + 1, y: coordinate.y)
            if target.x >= grid[target.y].count {
                return false
            } else { return getRoll(at: target, in: grid) != nil }
        case .upleft:
            let target = (x: coordinate.x - 1, y: coordinate.y - 1)
            if target.x < 0 || target.y < 0 {
                return false
            } else { return getRoll(at: target, in: grid) != nil }
        case .upright:
            let target = (x: coordinate.x + 1, y: coordinate.y - 1)
            if target.y < 0 || target.x >= grid[coordinate.y].count {
                return false
            } else { return getRoll(at: target, in: grid) != nil }
        case .downleft:
            let target = (x: coordinate.x - 1, y: coordinate.y + 1)
            if target.y >= grid.count || target.x < 0 {
                return false
            } else { return getRoll(at: target, in: grid) != nil }
        case .downright:
            let target = (x: coordinate.x + 1, y: coordinate.y + 1)
            if target.y >= grid.count || target.x >= grid[coordinate.y].count {
                return false
            } else { return getRoll(at: target, in: grid) != nil }
        }        
    }
    
    func canBeAccessed(for coordinate: (x: Int, y: Int), in grid: [[Roll?]]) -> Bool {
        var result: Bool = false
        var total: Int = 0
        Direction.allCases.forEach {
            let direction = $0
            if checkNeighbor(toward: direction, for: coordinate, in: grid) { total += 1 }
        }
        if total < 4 { result = true }
        return result
    }
    
    func solvePartA(with fileContent: String) {
        let lines = fileContent.split(separator: "\n")
        let grid = generateGrid(from: lines)
        var total = 0
        
        for y in 0..<grid.count {
            let row = grid[y]
            for x in 0..<row.count {
                let coordinate = (x: x, y: y)
                if getRoll(at: coordinate, in: grid) != nil {
                    if canBeAccessed(for: coordinate, in: grid) { total += 1 }
                }
            }
        }
        print("Total Part A: \(total)\n")
    }
    
    func solvePartB(with fileContent: String) {
        let lines = fileContent.split(separator: "\n")
        var grid = generateGrid(from: lines)
        var finalTotal: Int = 0
        
        var lastRemovalCount: Int = 1
        while lastRemovalCount > 0 {
            var removalCount: Int = 0
            
            for y in 0..<grid.count {
                let row = grid[y]
                for x in 0..<row.count {
                    let coordinate = (x: x, y: y)
                    if getRoll(at: coordinate, in: grid) != nil {
                        if canBeAccessed(for: coordinate, in: grid) {
                            grid[y][x] = nil
                            removalCount += 1
                            finalTotal += 1
                        }
                    }
                }
            }
            lastRemovalCount = removalCount
        }
        
        for y in 0..<grid.count {
            let row = grid[y]
            for x in 0..<row.count {
                let coordinate = (x: x, y: y)
                if getRoll(at: coordinate, in: grid) != nil {
                    print("@", terminator: "")
                } else {
                    print(".", terminator: "")
                }
            }
            print("")
        }
        print("\nTotal Part B: \(finalTotal)")
    }
    
    override func run() {
        print("---Day 4---\n")
        let filePath = self.inputFilePath
        
        do {
            try fileContent = String(contentsOfFile: filePath, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        } catch {
            print("Error reading file content: \(error)")
            exit(EXIT_FAILURE)
        }
        
        solvePartA(with: fileContent)
        solvePartB(with: fileContent)
    }
}
