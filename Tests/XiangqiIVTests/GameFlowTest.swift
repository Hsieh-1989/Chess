//
//  GameFlowTest.swift
//  XiangqiIVTests
//
//  Created by Hsieh Min Che on 2020/5/2.
//

import XCTest
@testable import XiangqiIV

class GameFlowTest: XCTestCase {
    
    typealias Board = BaseBoard<MockChess>
    
    func testInitialGameState() {
        let sut = makeSUT(board: .init(width: 3, height: 3), rule: .init { _ in nil })
        XCTAssertEqual(sut.currentPlayer, .X)
        XCTAssertEqual(sut.board, BaseBoard(string: "・・・\n・・・\n・・・"))
        XCTAssertNil(sut.currentResult())
    }
    
    func testGameStateAfterMove() {
        
        let sut = makeSUT(board: .init(width: 3, height: 3), rule: .init { _ in nil })
        let result = sut.move(by: .init(x: 0, y: 0))
        
        XCTAssertNil(result)
        XCTAssertEqual(sut.currentPlayer, .O)
        XCTAssertEqual(sut.board, BaseBoard(string: "Ｘ・・\n・・・\n・・・"))
        XCTAssertNil(sut.currentResult())
    }
    
    func testGameStateHasWinnerAfterMove() {
        let sut = makeSUT(board: .init(width: 3, height: 3), rule: .connect(length: 3))
        
        var result = sut.move(by: .init(x: 0, y: 0))
        XCTAssertNil(result)
        
        result = sut.move(by: .init(x: 1, y: 0))
        XCTAssertNil(result)
        
        result = sut.move(by: .init(x: 0, y: 1))
        XCTAssertNil(result)
        
        result = sut.move(by: .init(x: 1, y: 1))
        XCTAssertNil(result)
        
        result = sut.move(by: .init(x: 0, y: 2))
        XCTAssertEqual(result, .X)
        
        XCTAssertEqual(sut.board, BaseBoard(string: "ＸＯ・\nＸＯ・\nＸ・・"))
    }
    
    private func makeSUT(
        board: Board,
        rule: AnyRule<Board, MockChess.Player?>
    ) -> Game<Board, Position, MockChess.Player?> {
        Game(
            board: .init(width: 3, height: 3),
            players: MockChess.Player.allCases,
            rule: rule,
            move: { board, player, position in
                board[position] = .occupied(.init(owner: player))
        })
    }
}
