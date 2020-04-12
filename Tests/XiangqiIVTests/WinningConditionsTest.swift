//
//  WinningConditionsTest.swift
//  XiangqiIVTests
//
//  Created by Hsieh Min Che on 2020/4/12.
//

import XCTest

@testable import XiangqiIV

class WinningConditionsTest: XCTestCase {
    
    typealias Board = BaseBoard<MockChess>
    
    func testHasWinnerAtHorizontal() {
        let board = Board(string: """
        ・・・・・・・・
        ・ＯＯＯＯＯ・・
        ・・・・・・・・
        ・・・・・・・・
        ・・・・・・・・
        """
        )
        XCTAssertEqual(makeSUT(length: 4).verify(board), .O)
        XCTAssertEqual(makeSUT(length: 5).verify(board), .O)
        XCTAssertEqual(makeSUT(length: 6).verify(board), nil)
    }
    
    func testHasWinnerAtVertical() {
        let board = Board(string: """
        ・Ｘ・・・・・・
        ・Ｘ・・・・・・
        ・Ｘ・・・・・・
        ・Ｘ・・・・・・
        ・Ｘ・・・・・・
        ・・・・・・・・
        """
        )
        XCTAssertEqual(makeSUT(length: 4).verify(board), .X)
        XCTAssertEqual(makeSUT(length: 5).verify(board), .X)
        XCTAssertEqual(makeSUT(length: 6).verify(board), nil)
    }
    
    func testHasWinnerAtDiagonal() {
        // ↘
        let board = Board(string: """
        ・Ｏ・・・・・・
        ・・Ｏ・・・・・
        ・・・Ｏ・・・・
        ・・・・Ｏ・・・
        ・・・・・Ｏ・・
        ・・・・・・・・
        """
        )
        XCTAssertEqual(makeSUT(length: 4).verify(board), .O)
        XCTAssertEqual(makeSUT(length: 5).verify(board), .O)
        XCTAssertEqual(makeSUT(length: 6).verify(board), nil)
        
        // ↙
        let board2 = Board(string: """
        ・・・・・・Ｘ・
        ・・・・・Ｘ・・
        ・・・・Ｘ・・・
        ・・・Ｘ・・・・
        ・・Ｘ・・・・・
        ・・・・・・・・
        """
        )
        XCTAssertEqual(makeSUT(length: 4).verify(board2), .X)
        XCTAssertEqual(makeSUT(length: 5).verify(board2), .X)
        XCTAssertEqual(makeSUT(length: 6).verify(board2), nil)
    }
    
    func testNoWinner() {
        let board1 = Board(string: """
        ・・・・・・・・
        ・ＯＯＯＯ・ＯＯ
        ・・・・・・・・
        ・・・・・・・・
        ・・・・・・・・
        """
        )
        let board2 = Board(string: """
        ・Ｏ・・・・・・
        ・・Ｘ・・・・・
        ・・・Ｏ・・・・
        ・・・・Ｏ・・・
        ・・・・・Ｏ・・
        ・・・・・・・・
        """
        )
        let board3 = Board(string: """
        ・Ｏ・・・Ｏ・Ｘ
        ・・Ｘ・・ＯＸ・
        ・・ＸＯＸＸＸＸ
        ・・・・ＯＯ・・
        ・・・Ｘ・Ｏ・・
        ・・Ｘ・・ＯＯ・
        """
        )
        XCTAssertNil(makeSUT(length: 5).verify(board1))
        XCTAssertNil(makeSUT(length: 5).verify(board2))
        XCTAssertNil(makeSUT(length: 5).verify(board3))
    }
    
    
    private func makeSUT(length: Int) -> WinningConditions<Board> {
        return WinningConditions<Board>.connect(length: length)
    }
}
