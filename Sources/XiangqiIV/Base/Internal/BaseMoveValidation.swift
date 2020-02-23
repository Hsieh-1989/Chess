//
//  BaseMoveValidation.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

internal struct BaseMoveValidation: MoveValidation {
    
    internal typealias Validator = (
        _ player: Player,
        _ original: Position,
        _ destination: Position,
        _ board: Board
    ) -> Bool
    
    private let validator: Validator
    
    internal static func &&(_ lhs: BaseMoveValidation, _ rhs: BaseMoveValidation) -> BaseMoveValidation {
        BaseMoveValidation { player, original, destination, board in
            lhs.validate(player: player, from: original, to: destination, on: board) &&
            rhs.validate(player: player, from: original, to: destination, on: board)
        }
    }
    
    internal init(validator: @escaping Validator) {
        self.validator = validator
    }

    // MARK: ChessMoveValidation
    internal func validate(
        player: Player,
        from original: Position,
        to destination: Position,
        on board: Board
    ) -> Bool {
        validator(player, original, destination, board)
    }
}

