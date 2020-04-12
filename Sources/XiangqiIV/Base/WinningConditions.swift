//
//  WinningConditions.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public struct WinningConditions<Board: BoardProtocol> {
    public let verify: (Board) -> Board.Chess.Player?
}

extension WinningConditions {
    public static func connect(length: Int) -> WinningConditions {
        WinningConditions { board in
            for data in board {
                guard let data = data as? (Position, PositionStatus<Board.Chess>), let player = data.1.chess?.owner else {
                    continue
                }
                if isConnected(length, on: board, at: data.0, by: player) {
                    return player
                }
            }
            return nil
        }
    }
}

private func isConnected<Board: BoardProtocol>(
    _ length: Int,
    on board: Board,
    at position: Position,
    by player: Board.Chess.Player
) -> Bool {
    func check(along unit: Vector) -> Bool {
        return stride(from: 1, to: length, by: 1)
            .reduce(into: [position]) { result, _ in result.append(result.last! + unit) }
            .filter(board.isValid(on:))
            .map(board.get(position:))
            .filter { $0.owner == player }
            .count == length
    }
    // → ↘ ↓ ↙
    return check(along: .init(x: 1, y: 0)) ||
        check(along: .init(x: 1, y: 1)) ||
        check(along: .init(x: 0, y: 1)) ||
        check(along: .init(x: -1, y: 1))
}
