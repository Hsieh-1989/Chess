//
//  Game.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/4/12.
//

public struct Game<Board: BoardProtocol> {
    
    private typealias Player = Board.Chess.Player
    
    // MARK: - Property
    private var currentPlayer: Player
    private var board: Board
    private var winningValidator: BaseWinningRule<Board>
}
