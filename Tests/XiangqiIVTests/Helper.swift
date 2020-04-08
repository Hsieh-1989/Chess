//
//  Helper.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

import XCTest
@testable import XiangqiIV

extension String: Error {}

extension Board {
    init(string: String) {
        let array = string
            .split(separator: "\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        let width = array.first?.count ?? 0
        let height = array.count
        
        let data = array
            .joined()
            .enumerated()
            .reduce(into: [Position: Chess]()) { result, current in
                let (index, character) = current
                guard let chess = ChineseChess(rawValue: String(character)) else { return }
                let position = Position(x: index % width, y: index / width)
                result[position] = chess
        }
        self = Board(width: width, height: height, data: data)
    }
}

func assertEqual(
    _ expression1: @autoclosure () throws -> [Position],
    _ expression2: @autoclosure () throws -> [(Int, Int)],
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) {
    XCTAssertEqual(
        try expression1(),
        try expression2().map(Position.init),
        message(),
        file: file,
        line: line
    )
}

