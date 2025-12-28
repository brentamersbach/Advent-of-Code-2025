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
        super.init(num: 7, input: input)
    }

    func printNodes(_ nodes: [[Node]]) {
        for row in nodes {
            var rowString: String = ""
            for node in row {
                switch node {
                case .start:
                    rowString.append("S")
                case .empty:
                    rowString.append(".")
                case .beam:
                    rowString.append("|")
                case .splitter:
                    rowString.append("^")
                }
            }
            print(rowString)
        }
        print("")
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

    func solvePartA(_ nodes: [[Node]]) {
        // Goal: How many times is the beam split?
        var outputNodes = nodes
        var splitCount: Int = 0
        for row in 1..<outputNodes.count {
            for node in 0..<outputNodes[row].count {
                let aboveNode = outputNodes[row - 1][node]
                if aboveNode == .beam || aboveNode == .start {
                    switch outputNodes[row][node] {
                    case .empty:
                            outputNodes[row][node] = .beam
                    case .splitter:
                        splitCount += 1
                        if node > 0 {
                            outputNodes[row][node - 1] = .beam
                        }
                        if node < outputNodes[row].count - 1 {
                            outputNodes[row][node + 1] = .beam
                        }
                    default:
                        continue
                    }
                }
            }
        }
        printNodes(outputNodes)
        print("Split total: \(splitCount)")
    }

    func solvePartB(_ nodes: [[Node]]) {
        // Goal: How many possible paths are there from top to bottom?
        var outputNodes = nodes

        // Rebuild the diagram as in Part A
        var columnTotals: [Int] = Array(repeating: 0, count: outputNodes[0].count)
        for row in 1..<outputNodes.count {
            for node in 0..<outputNodes[row].count {
                let aboveNode = outputNodes[row - 1][node]
                switch aboveNode {
                case .start:
                    if outputNodes[row][node] == .empty {
                        outputNodes[row][node] = .beam
                        columnTotals[node] += 1
                    }
                case .beam:
                    if outputNodes[row][node] == .empty {
                        outputNodes[row][node] = .beam
                    } else if outputNodes[row][node] == .splitter {
                        outputNodes[row][node - 1] = .beam
                        columnTotals[node - 1] += columnTotals[node]
                        outputNodes[row][node + 1] = .beam
                        columnTotals[node + 1] += columnTotals[node]
                        columnTotals[node] = 0
                    }
                default:
                    continue
                }
            }
        }
        let timelines = columnTotals.reduce(0, +)

        print("Timelines: \(timelines)")
    }

    override func run() {
        let fileContent = loadInputFile(from: input)
        let nodes = parseInput(from: fileContent)
        solvePartA(nodes)
        solvePartB(nodes)
    }
}
