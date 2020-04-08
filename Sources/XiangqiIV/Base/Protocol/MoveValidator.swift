//
//  MoveValidator.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public protocol MoveValidator {
    associatedtype Chess: ChessProtocol
    func validate(
        player: Player,
        from original: Position,
        to destination: Position,
        on board: Board<Chess>
    ) -> Bool
}