//
//  Day_7.swift
//  advent2025
//
//  Created by Brent Amersbach on 12/26/25.
//

import Foundation

class Day_7: Day {
    enum Node {
        case start
        case empty
        case beam
        case splitter
    }

    init(input: String) {
        super.init(num: 6, input: input)
    }

    func solvePartA(_ nodes: [[Node]]) {
        
    }

    func parseInput(from fileContent: String) -> [[Node]]{
        let lines = fileContent.split(separator: "\n")
        var nodes: [[Node]] = []
        for line in lines {
            var row: [Node] = []
            for char in line {
                switch char {
                case "S":
                    row.append(.start)
                case ".":
                    row.append(.empty)
                case "|":
                    row.append(.beam)
                case "^":
                    row.append(.splitter)
                default:
                    fatalError("Unexpected character: \(char)")
                }
            }
            nodes.append(row)
        }
        return nodes
    }

    override func run() {
        let fileContent = loadInputFile(from: input)
        let nodes = parseInput(from: fileContent)
        solvePartA(nodes)
    }
}
