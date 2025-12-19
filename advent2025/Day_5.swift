//
//  Day_5.swift
//  advent2025
//
//  Created by Brent Amersbach on 12/18/25.
//

import Foundation
import Darwin

func parseInput(for content: String) -> ([(Int, Int)], [Int]) {
    let lines = content.components(separatedBy: "\n")
    guard let breakIndex = lines.firstIndex(where: { $0 == "" }) else { return ([], []) }
    let freshIDStrings = Array(lines[0...breakIndex - 1])
    var freshIDRanges: [(Int, Int)] = []
    
    for idRange in freshIDStrings {
        let splitRange = idRange.components(separatedBy: "-")
        if let firstString = splitRange.first, let lastString = splitRange.last {
            if let firstInt = Int(firstString), let lastInt = Int(lastString) {
                freshIDRanges.append((firstInt, lastInt))
            }
        }
    }
    
    let availableIDStrings = Array(lines[(breakIndex + 1)...])
    var availableIDs: [Int] = []
    for availableID in availableIDStrings {
        if let int = Int(availableID) {
            availableIDs.append(int)
        }
    }
    return (freshIDRanges, availableIDs)
}

func solvePartA(forRanges freshIDRanges: [(Int, Int)], forIDs availableIDs: [Int]) {
//    let (freshIDRanges, availableIDs) = parseInput(for: input)
    var result: Int = 0
    
    for id in availableIDs {
        for range in freshIDRanges {
            if id >= range.0 && id <= range.1 {
//                print("Hit! \(id) is between \(range.0) and \(range.1)")
                result += 1
                break
            }
        }
    }
    print("Count of available fresh IDs: \(result)")
}

func solvePartB(for freshIDRanges: [(Int, Int)]) {
    var expandedIDs: [Int] = []
    var sortedRanges = freshIDRanges.sorted(by: {
        $0.0 < $1.0
    })
    var indexesToRemove: RangeSet<Array<(Int, Int)>.Index> = RangeSet()
    for i in 0..<sortedRanges.count - 1 {
        let left = sortedRanges[i]
        let right = sortedRanges[i+1]
        
        if right.0 <= left.1 && right.0 >= left.0 {
            print("Hit on \(left) and \(right)")
            if right.1 <= left.1 {
                let index = sortedRanges.indices[i+1]
                // How do we append this to the range set?
            } else {
                sortedRanges[i+1].0 = left.1 + 1
            }
        }
        if i + 1 >= sortedRanges.count {
            break
        }
    }
    
    // TODO: Remove all flagged indexes
    sortedRanges.removingSubranges(<#T##subranges: RangeSet<Int>##RangeSet<Int>#>)
    
    var total: Int = 0
    for range in sortedRanges {
        let idsToCount = Array(range.0...range.1)
        total += idsToCount.count
    }
    print("Count of all fresh IDs: \(total)")
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
        let (freshIDRanges, availableIDs) = parseInput(for: fileContent)
        
        solvePartA(forRanges: freshIDRanges, forIDs: availableIDs)
        solvePartB(for: freshIDRanges)
    }
}
