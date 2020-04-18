//
//  BaseWinningRule.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public struct BaseWinningRule<Board: BoardProtocol>: Rule {

    public typealias Result = Board.Chess.Player?

    private let _verify: (Board) -> Result

    public init(_ verify: @escaping (Board) -> Result) {
        self._verify = verify
    }

    public func verify(_ board: Board) -> Result {
        _verify(board)
    }
}
