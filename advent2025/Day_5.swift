//
//  Day_5.swift
//  advent2025
//
//  Created by Brent Amersbach on 12/18/25.
//

import Foundation
import Darwin

func parseInput(for content: String) -> ([(Int, Int)], [Int]) {
    print("Parsing input for: \(content)")
    let lines = content.components(separatedBy: "\n")
    guard let breakIndex = lines.firstIndex(where: { $0 == "" }) else { exit(EXIT_FAILURE) }
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

func markIndexForRemoval(for range: (Int, Int), in set: [(Int, Int)], with existingRanges: RangeSet<Array<(Int, Int)>.Index>) -> RangeSet<Array<(Int, Int)>.Index> {
    var rangesToReturn: RangeSet<Array<(Int, Int)>.Index> = existingRanges
    guard let indexToRemove = set.lastIndex(where: {
        $0 == range
    }) else { return rangesToReturn }
    let rangeSet = RangeSet(indexToRemove...indexToRemove, within: set)
    rangesToReturn.formUnion(rangeSet)
    return rangesToReturn
}

func sortRanges(for rangeSet: [(Int, Int)]) -> [(Int, Int)] {
    return rangeSet.sorted(by: {
        if $0.0 < $1.0 {
            print("\($0) is less than \($1)")
            return true
        } else { return false }
    })
}

func solvePartA(forRanges freshIDRanges: [(Int, Int)], forIDs availableIDs: [Int]) {
    var result: Int = 0
    
    for id in availableIDs {
        for range in freshIDRanges {
            if id >= range.0 && id <= range.1 {
                result += 1
                break
            }
        }
    }
    print("Count of available fresh IDs: \(result)\n")
}

func solvePartB(for freshIDRanges: [(Int, Int)]) {
    var sortedRanges: [(Int, Int)] = sortRanges(for: freshIDRanges)
    
    while true {
        // Filter out duplicate ranges and correct overlaps
        var indexesToRemove: RangeSet<Array<(Int, Int)>.Index> = RangeSet()
        var didMakeChange = false
        sortedRanges = sortRanges(for: sortedRanges)
        print("Sorted ranges: \(sortedRanges)")
        
        for i in 0..<sortedRanges.count - 1 {
            let left = sortedRanges[i]
            let right = sortedRanges[i+1]
            
            if left.0 <= right.0 && left.1 >= right.1 {
                // Duplicate range, add to list for removal
                print("Duplicate: \(left) \(right)\n")
                indexesToRemove = markIndexForRemoval(for: right, in: sortedRanges, with: indexesToRemove)
                continue
            }
            if left.0 <= right.0 && left.1 >= right.0 {
                // Overlap
                print("Overlap:     \(left) \(right)")
                // Is this a single value range?
                if right.0 == right.1 {
                    print("Overlap with single value range")
                    indexesToRemove = markIndexForRemoval(for: right, in: sortedRanges, with: indexesToRemove)
                    continue
                }
                // Does this overlap on both sides?
                if left.0 <= right.0 && left.1 >= right.1 {
                    indexesToRemove = markIndexForRemoval(for: right, in: sortedRanges, with: indexesToRemove)
                }
                sortedRanges[i+1].0 = left.1 + 1
                print("Resolved to: \(sortedRanges[i]) \(sortedRanges[i+1])\n")
                didMakeChange = true
                continue
            }
        }
        if indexesToRemove.ranges.count > 0 {
            sortedRanges.removeSubranges(indexesToRemove)
            didMakeChange = true
        }
        
        if !didMakeChange { break }
        
    }
    
    
    var total: Int = 0
    for range in sortedRanges {
//        for i in range.0...range.1 {
//            print(i)
//        }
        total += range.1 - range.0 + 1
    }
    print("\nCount of all fresh IDs: \(total)")
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
