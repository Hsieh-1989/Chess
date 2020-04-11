//
//  MoveValidator+ChineseChess.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

// MARK: Default Chinese Chess Validation
struct ChinessChessMoveValidator<Board: BoardProtocol>: MoveValidator where Board.Chess == ChineseChess {
    
    func validate(from original: Position, to destination: Position, on board: Board) -> Bool {
        guard let chess = board[original].chess else {
            assertionFailure("original position should have chess")
            return false
        }
        let validator: AnyMoveValidator<Board> = {
            switch chess.id {
            case .king: return .king
            case .assistant: return .assistant
            case .elephant: return .elephant
            case .horse: return .horse
            case .chariot: return .chariot
            case .cannon: return .cannon
            case .soldier: return .soldier
            }
        }()
        return validator.validate(from: original, to: destination, on: board)
    }
}

extension AnyMoveValidator {
    
    internal static var king: AnyMoveValidator {
        path {
            $0.isLinear && ($0.x.magnitude == 1 || $0.y.magnitude == 1)
        }
    }
    
    internal static var assistant: AnyMoveValidator {
        path {
            $0.x.magnitude == 1 && $0.y.magnitude == 1
        }
    }
    
    internal static var elephant: AnyMoveValidator {
        path {
            $0.x.magnitude == 2 && $0.y.magnitude == 2
        }
    }
    
    internal static var horse: AnyMoveValidator {
        path {
            ($0.x.magnitude == 2 && $0.y.magnitude == 1) || ($0.x.magnitude == 1 && $0.y.magnitude == 2)
        }
    }
    
    internal static var chariot: AnyMoveValidator {
        linear {
            $0.dropLast().allSatisfy { $0.isEmpty }
        }
    }
    
    internal static var cannon: AnyMoveValidator {
        linear { data in
            guard let destination = data.last else {
                // ideally this is impossible status
                assertionFailure()
                return false
            }
            return destination.isEmpty
                ? data.allSatisfy { $0.isEmpty }
                : data.dropLast().reduce(0) { $0 + ($1.isEmpty ? 0 : 1) } == 1
        }
    }
    
    internal static var soldier: AnyMoveValidator {
        path {
            $0.isLinear && ($0.x.magnitude == 1 || $0.y.magnitude == 1)
        }
    }
}


// MARK: Base Validation Helpers
extension AnyMoveValidator {
    
    internal static var base: AnyMoveValidator {
        AnyMoveValidator { original, destination, board in
            board[destination].owner != board[original].owner
        }
    }
    
    internal static var linear: AnyMoveValidator {
        path { $0.isLinear }
    }
    
    internal static func path(_ pathValidator: @escaping (Vector) -> Bool) -> AnyMoveValidator {
        base && AnyMoveValidator { original, destination, _  in
            pathValidator(destination - original)
        }
    }
    
    internal static func linear(_ blockValidator: @escaping ([PositionStatus<Board.Chess>]) -> Bool) -> AnyMoveValidator {
        linear && AnyMoveValidator { original, destination, board  in
            let status = original.linearSteps(to: destination).map { board[$0] }
            return blockValidator(status)
        }
    }
}
