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
            .init(x: 0, y: 0): .black,
            .init(x: 1, y: 1): .black,
            .init(x: 2, y: 2): .black,
            .init(x: 0, y: 2): .red,
            .init(x: 2, y: 0): .red
        ])
        
        XCTAssertEqual(
            board.data,
            [
                [.occupied(.black), .empty, .occupied(.red)],
                [.empty, .occupied(.black), .empty],
                [.occupied(.red), .empty, .occupied(.black)]
            ]
        )
    }
    
    // MARK: Mock Chess
    private struct Chess: ChessProtocol, Equatable, CustomStringConvertible {
        
        let owner: Player
        let moveValidator = AnyMoveValidator<Self>(validator: { _, _, _, _ in false })
        
        static let red = Chess(owner: .red)
        static let black = Chess(owner: .black)
        
        static func == (lhs: BoardTest.Chess, rhs: BoardTest.Chess) -> Bool {
            return lhs.owner == rhs.owner
        }
        
        var description: String {
            switch owner {
            case .red: return "@"
            case .black: return "#"
            }
        }
    }
}
