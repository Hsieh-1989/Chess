//
//  MoveValidation+ChineseChess.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

// MARK: Default Chinese Chess Validation
extension BaseMoveValidation {
    
    internal static var king: BaseMoveValidation {
        path {
            $0.isLinear && ($0.x.magnitude == 1 || $0.y.magnitude == 1)
        }
    }
    
    internal static var assistant: BaseMoveValidation {
        path {
            $0.x.magnitude == 1 && $0.y.magnitude == 1
        }
    }
    
    internal static var elephant: BaseMoveValidation {
        path {
            $0.x.magnitude == 2 && $0.y.magnitude == 2
        }
    }
    
    internal static var horse: BaseMoveValidation {
        path {
            ($0.x.magnitude == 2 && $0.y.magnitude == 1) || ($0.x.magnitude == 1 && $0.y.magnitude == 2)
        }
    }
    
    internal static var chariot: BaseMoveValidation {
        linear {
            $0.dropLast().allSatisfy { $0.isEmpty }
        }
    }
    
    internal static var cannon: BaseMoveValidation {
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
    
    internal static var soldier: BaseMoveValidation {
        path {
            $0.isLinear && ($0.x.magnitude == 1 || $0.y.magnitude == 1)
        }
    }
}


// MARK: Base Validation Helpers
extension BaseMoveValidation {
    
    internal static var base: BaseMoveValidation {
        BaseMoveValidation { player, _, destination, board in
            board[destination].owner != player
        }
    }
    
    internal static var linear: BaseMoveValidation {
        path { $0.isLinear }
    }
    
    internal static func path(_ pathValidator: @escaping (Vector) -> Bool) -> BaseMoveValidation {
        base && BaseMoveValidation { _, original, destination, _  in
            pathValidator(destination - original)
        }
    }
    
    internal static func linear(_ blockValidator: @escaping ([PositionStatus]) -> Bool) -> BaseMoveValidation {
        linear && BaseMoveValidation { _, original, destination, board  in
            let status = original.linearSteps(to: destination).map { board[$0] }
            return blockValidator(status)
        }
    }
}
