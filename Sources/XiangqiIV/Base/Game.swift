//
//  Game.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/4/12.
//

open class Game<Board: BoardProtocol, Step, GameResult> {
    
    public typealias Player = Board.Chess.Player
    
    // MARK: - Property
    
    public var currentPlayer: Player { players[currentPlayerIndex] }
    private(set) var currentPlayerIndex: Int
    private(set) var players: [Player]

    public private(set) var board: Board
    private let rule: AnyRule<Board, GameResult>
    private let move: (inout Board, Player, Step) -> Void
    
    // MARK: - Initializer
    
    public init<R: Rule>(
        board: Board,
        players: [Player],
        currentPlayerIndex: Int = 0,
        rule: R,
        move: @escaping (inout Board, Player, Step) -> Void
    ) where R.Board == Board, R.Result == GameResult {
        self.board = board
        self.players = players
        self.currentPlayerIndex = currentPlayerIndex
        self.rule = AnyRule(rule: rule)
        self.move = move
    }
    
    // MARK: - Public Method
    
    public func currentResult() -> GameResult {
        rule.verify(board)
    }
    
    open func move(by step: Step) -> GameResult {
        move(&board, currentPlayer, step)
        let result = rule.verify(board)
        currentPlayerIndex = nextPlayerIndex(currentResult: result)
        return result
    }
    
    open func nextPlayerIndex(currentResult: GameResult) -> Int {
        currentPlayerIndex + 1 < players.count ? currentPlayerIndex + 1 : 0
    }
}
