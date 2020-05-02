//
//  AnyRule.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public struct AnyRule<Board: BoardProtocol, Result>: Rule {
    
    private let _verify: (Board) -> Result

    public init(_ verify: @escaping (Board) -> Result) {
        self._verify = verify
    }
    
    public init<R: Rule>(rule: R) where R.Board == Board, R.Result == Result {
        self._verify = { rule.verify($0) }
    }

    public func verify(_ board: Board) -> Result {
        _verify(board)
    }
}
