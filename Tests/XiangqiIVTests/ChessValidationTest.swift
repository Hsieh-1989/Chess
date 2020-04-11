//
//  ChessValidationTest.swift
//  XiangqiIVTests
//
//  Created by Hsieh Min Che on 2020/2/24.
//

import XCTest
@testable import XiangqiIV

final class ChessValidationTest: XCTestCase {
    
    func testKingValidation() {
        // test target "將" at (1,1)
        let data = """
            ・・・・・
            ・將士・・
            ・兵・・・
            ・・・・・
            ・・・・・
        """
        assertEqual(
            try validPath(at: Position(x: 1, y: 1), data: data),
            [
                (1, 0),
                (0, 1),
                (1, 2)
            ]
        )
    }
    
    func testAssistantValidation() {
        // test target "士" at (1,1)
        let data = """
            ・・・・・
            ・士・・・
            兵・將・・
            ・・・・・
            ・・・・・
        """
        assertEqual(
            try validPath(at: Position(x: 1, y: 1), data: data),
            [
                (0, 0), (2, 0),
                (0, 2)
            ]
        )
    }
    
    func testElephantValidation() {
        // test target "象" at (2,2)
        let data = """
            ・・・・卒
            ・・・・・
            ・・象・・
            ・・・・・
            兵・・・・
        """
        assertEqual(
            try validPath(at: Position(x: 2, y: 2), data: data),
            [
                (0, 0),
                (0, 4), (4, 4)
            ]
        )
    }
    
    func testHorseValidation() {
        // test target "馬" at (2,2)
        let data = """
            ・・・卒・
            ・・・・・
            ・・馬・・
            ・・・・・
            ・兵・・・
        """
        assertEqual(
            try validPath(at: Position(x: 2, y: 2), data: data),
            [
                (1, 0),
                (0, 1), (4, 1),
                (0, 3), (4, 3),
                (1, 4), (3, 4)
            ]
        )
    }
    
    func testChariotValidation() {
        // test target "車" at (1,1)
        let data = """
            ・兵・・・
            ・車・帥炮
            ・・・・・
            ・兵・・・
            ・・・・・
        """
        assertEqual(
            try validPath(at: Position(x: 1, y: 1), data: data),
            [
                (1, 0),
                (0, 1), (2, 1), (3, 1),
                (1, 2),
                (1, 3)
            ]
        )
    }
    
    func testCannonValidation() {
        // test target "包" at (0,2)
        let data = """
            ・・・・・
            兵・・・・
            包・・卒兵
            ・・・・・
            ・・・・・
        """
        assertEqual(
            try validPath(at: Position(x: 0, y: 2), data: data),
            [
                (1, 2), (2, 2), (4, 2),
                (0, 3),
                (0, 4),
            ]
        )
    }
    
    func testSoldierValidation() {
        // test target "卒" at (1,1)
        let data = """
            ・・・・・
            ・卒士・・
            ・帥・・・
            ・・・・・
            ・・・・・
        """
        assertEqual(
            try validPath(at: Position(x: 1, y: 1), data: data),
            [
                (1, 0),
                (0, 1),
                (1, 2)
            ]
        )
    }
    
    // MARK: - AllTests
    static var allTests = [
        ("testKingValidation", testKingValidation),
        ("testAssistantValidation", testAssistantValidation),
        ("testElephantValidation", testElephantValidation),
        ("testHorseValidation", testHorseValidation),
        ("testChariotValidation", testChariotValidation),
        ("testCannonValidation", testCannonValidation),
        ("testSoldierValidation", testSoldierValidation),
    ]
    
    // MARK: - Private Helper
    private func validPath(at position: Position, data: String) throws -> [Position] {
        let validator = ChinessChessMoveValidator<BaseBoard>()
        let board = BaseBoard<ChineseChess>(string: data)
        return board.compactMap {
            let (destination, _) = $0
            return validator.validate(from: position, to: destination, on: board) ? destination : nil
        }
    }
}
