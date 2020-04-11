//
//  WinningConditions.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public struct WinningConditions<Board: BoardProtocol> {
    public let verify: (Board) -> Board.Chess.Player?
}
