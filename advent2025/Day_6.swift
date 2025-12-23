//
//  Day_6.swift
//  advent2025
//
//  Created by Brent Amersbach on 12/20/25.
//

import Foundation
import Darwin

class Day_6: Day {
    init(input: String) {
        super.init(num: 6, input: input)
    }

    private func transpose2DMatrix<T>(_ matrix: [[T]]) -> [[T]] {
        guard !matrix.isEmpty else { return [] }
        var result: [[T]] = []
        var iterators = matrix.map { $0.makeIterator() }
        let maxLen = matrix.max(by: { $0.count > $1.count })?.count ?? matrix[0].count
        
        while true {
            var tuple: [T] = []
            for i in 0..<iterators.count {
                /* This works because iterators save their position. The function calls iterator[0].next(), iterator[1].next(), etc and gets the 0th value from
                 each. The next loop when it calls next on each iterator, it will get value 1 as each iterator is maintaining its own state. */
                guard let next = iterators[i].next() else { break }
                tuple.append(next)
            }
            // At this point, the tuple contains the first value from each array in the original set
            result.append(tuple)
            if result.count == maxLen { return result }
        }
    }

    func parseInput(for filePath: String) -> (operands: [String], operators: String) {
        var fileContent: String = ""
        do {
            try fileContent = String(contentsOfFile: filePath, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        } catch {
            print("Error reading file content: \(error)")
            exit(EXIT_FAILURE)
        }
        print("Parsing input for: \(filePath)")
        let lines = fileContent.components(separatedBy: "\n")
        let operands = Array(lines.prefix(lines.count-1))
        guard let operators = lines.last else { fputs("Parsing failure\n", stderr) ; exit(EXIT_FAILURE) }
        return (operands, operators)
    }

    func processInputPartA(for operandLines: [String], using operatorLine: String) -> (operandArray: [[Int]], operatorArray: [String]) {
        var operandMatrix: [[Int]] = []
        for line in operandLines {
            let splitLine = line.split(separator: " ", maxSplits: Int.max, omittingEmptySubsequences: true)
            var intArray: [Int] = []
            for element in splitLine {
                guard let int = Int(element) else { print("Invalid number in input: \(element)") ; exit(EXIT_FAILURE) }
                intArray.append(int)
            }
            operandMatrix.append(intArray)
        }
        let operandsHorizontal = transpose2DMatrix(operandMatrix)

        let operatorSubstringArray = operatorLine.split(separator: " ", maxSplits: Int.max, omittingEmptySubsequences: true)
        var operatorArray: [String] = []
        for element in operatorSubstringArray {
            operatorArray.append(String(element))
        }

        guard operandsHorizontal.count == operatorArray.count else {
            fatalError("Number of operands does not match number of operators")
        }
        return (operandsHorizontal, operatorArray)
    }

    func processInputPartB(for operandLines: [String], using operatorLine: String) -> (operandArray: [[String]], operatorArray: [String]) {
        var operandMatrix: [[String]] = []
        for line in operandLines {
            let splitLine = line.split(separator: " ", maxSplits: Int.max, omittingEmptySubsequences: true).map(String.init)

            operandMatrix.append(splitLine)
        }
        let operandsHorizontal = transpose2DMatrix(operandMatrix)

        let operatorSubstringArray = operatorLine.split(separator: " ", maxSplits: Int.max, omittingEmptySubsequences: true)
        var operatorArray: [String] = []
        for element in operatorSubstringArray {
            operatorArray.append(String(element))
        }

        guard operandsHorizontal.count == operatorArray.count else {
            fatalError("Number of operands does not match number of operators")
        }
        return (operandsHorizontal, operatorArray)
    }

    func solvePartA(for operandLines: [String], using operatorLine: String) {
        let (operandMatrix, operatorArray) = processInputPartA(for: operandLines, using: operatorLine)
        var results: [Int] = []
        for index in operandMatrix.indices {
            if operatorArray[index] == "+" {
                results.append(operandMatrix[index].reduce(0, +))
            } else if operatorArray[index] == "*" {
                results.append(operandMatrix[index].reduce(1, *))
            }
        }
        print("Part A Total: \(results.reduce(0, +))")
    }

    func solvePartB(for operandLines: [String], using operatorLine: String) {
        var (operandMatrix, operatorArray) = processInputPartB(for: operandLines, using: operatorLine)

        for matrixIndex in operandMatrix.indices {
            guard let max = operandMatrix[matrixIndex].max(by: { $1.count > $0.count }) else { fatalError("Unable to determine longest string in row") }
            for operandIndex in operandMatrix.indices {
                if operandMatrix[operandIndex].count < max.count {
                    let neededBytes = max.count - operandMatrix[operandIndex].count
                    for _ in 1...neededBytes {
                        operandMatrix[matrixIndex][operandIndex].insert(contentsOf: "0", at: operandMatrix[matrixIndex][operandIndex].startIndex)
                    }
                }
            }
        }
        print(operandMatrix)
    }

    override func run() {
        let (operandLines, operatorLine) = parseInput(for: self.input)
        solvePartA(for: operandLines, using: operatorLine)
        solvePartB(for: operandLines, using: operatorLine)
    }


}

