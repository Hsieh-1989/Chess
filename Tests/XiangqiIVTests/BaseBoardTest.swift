//
//  BaseBoardTest.swift
//  XiangqiIVTests
//
//  Created by Hsieh Min Che on 2020/4/8.
//

import XCTest
@testable import XiangqiIV

class BaseBoardTest: XCTestCase {
    
    func testBoardInitialState() {
        let board = BaseBoard<MockChess>(width: 3, height: 4)
        XCTAssertEqual(board.size, BaseBoard.Size(width: 3, height: 4))
        XCTAssertEqual(
            board.data,
            [
                [.empty, .empty, .empty],
                [.empty, .empty, .empty],
                [.empty, .empty, .empty],
                [.empty, .empty, .empty]
            ]
        )
    }
    
    func testBoardInitialWithoutData() {
        
        let board = BaseBoard<MockChess>(width: 3, height: 4)
        
        XCTAssertEqual(board.size, BaseBoard.Size(width: 3, height: 4))
        XCTAssertEqual(
            board.data,
            [
                [.empty, .empty, .empty],
                [.empty, .empty, .empty],
                [.empty, .empty, .empty],
                [.empty, .empty, .empty]
            ]
        )
    }
    
    func testBoardInitialWithData() {
        
        let board = BaseBoard<MockChess>(width: 3, height: 3, data: [
            .init(x: 0, y: 0): .X,
            .init(x: 1, y: 1): .X,
            .init(x: 2, y: 2): .X,
            .init(x: 0, y: 2): .O,
            .init(x: 2, y: 0): .O
        ])
        
        XCTAssertEqual(
            board.data,
            [
                [.occupied(.X), .empty, .occupied(.O)],
                [.empty, .occupied(.X), .empty],
                [.occupied(.O), .empty, .occupied(.X)]
            ]
        )
    }
}
