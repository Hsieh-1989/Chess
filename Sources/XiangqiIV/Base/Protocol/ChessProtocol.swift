//
//  ChessProtocol.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public protocol ChessProtocol {
    
    associatedtype Board: BoardProtocol where Board.Chess == Self
    associatedtype Player: PlayerProtocol
    
    var owner: Player { get }
    var moveValidator: AnyMoveValidator<Self> { get }
}

extension ChessProtocol where Board: Sequence, Board.Element == (Position, PositionStatus<Self>) {
    public func validPath(from original: Position, on board: Board) -> [Position] {
        board.compactMap {
            let (destination, _) = $0
            let valid = moveValidator.validate(player: owner, from: original, to: destination, on: board)
            return valid ? destination : nil
        }
    }
}
