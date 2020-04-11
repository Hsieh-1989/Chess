//
//  WinningConditions.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public struct WinningConditions<Chess: ChessProtocol> {
    public let verify: (Chess.Board) -> Chess.Player?
}
