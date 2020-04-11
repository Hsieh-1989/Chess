//
//  AnyMoveValidator.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public struct AnyMoveValidator<Board: BoardProtocol>: MoveValidator {
    
    public typealias Validator = (_ original: Position, _ destination: Position, _ board: Board) -> Bool
    
    private let validator: Validator
    
    public static func &&(_ lhs: AnyMoveValidator, _ rhs: AnyMoveValidator) -> AnyMoveValidator {
        AnyMoveValidator { original, destination, board in
            lhs.validate(from: original, to: destination, on: board) &&
            rhs.validate(from: original, to: destination, on: board)
        }
    }
    
    public init(validator: @escaping Validator) {
        self.validator = validator
    }

    // MARK: ChessMoveValidation
    public func validate(from original: Position, to destination: Position, on board: Board) -> Bool {
        validator(original, destination, board)
    }
}

