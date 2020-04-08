//
//  AnyMoveValidator.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public struct AnyMoveValidator: MoveValidator {
    
    public typealias Validator = (
        _ player: Player,
        _ original: Position,
        _ destination: Position,
        _ board: Board
    ) -> Bool
    
    private let validator: Validator
    
    public static func &&(_ lhs: AnyMoveValidator, _ rhs: AnyMoveValidator) -> AnyMoveValidator {
        AnyMoveValidator { player, original, destination, board in
            lhs.validate(player: player, from: original, to: destination, on: board) &&
            rhs.validate(player: player, from: original, to: destination, on: board)
        }
    }
    
    public init(validator: @escaping Validator) {
        self.validator = validator
    }

    // MARK: ChessMoveValidation
    public func validate(
        player: Player,
        from original: Position,
        to destination: Position,
        on board: Board
    ) -> Bool {
        validator(player, original, destination, board)
    }
}

