//
//  BoardTest.swift
//  XiangqiIVTests
//
//  Created by Hsieh Min Che on 2020/4/8.
//

import XCTest
@testable import XiangqiIV

class BoardTest: XCTestCase {
    
    func testBoardInitialState() {
        let board = Board<Chess>(width: 3, height: 4)
        XCTAssertEqual(board.size, Board.Size(width: 3, height: 4))
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
        
        let board = Board<Chess>(width: 3, height: 4)
        
        XCTAssertEqual(board.size, Board.Size(width: 3, height: 4))
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
        
        let board = Board<Chess>(width: 3, height: 3, data: [
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
    
    // MARK: Mock Chess
    private struct Chess: ChessProtocol, Equatable, CustomStringConvertible {
        enum Player: String, PlayerProtocol {
            case X
            case O
        }
        
        let owner: Player
        let moveValidator = AnyMoveValidator<Self>(validator: { _, _, _, _ in false })
        
        static let X = Chess(owner: .X)
        static let O = Chess(owner: .O)
        
        static func == (lhs: BoardTest.Chess, rhs: BoardTest.Chess) -> Bool {
            return lhs.owner == rhs.owner
        }
        
        var description: String {
            switch owner {
            case .X: return "X"
            case .O: return "O"
            }
        }
    }
}
