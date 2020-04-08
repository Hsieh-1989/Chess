//
//  PositionStatus.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public enum PositionStatus<Chess: ChessProtocol> {
    case empty
    case occupied(Chess)
    
    public var isEmpty: Bool {
        switch self {
        case .empty: return true
        case .occupied: return false
        }
    }
    
    public var chess: Chess? {
        guard case let .occupied(chess) = self else { return nil }
        return chess
    }
    
    public var owner: Chess.Player? {
        return chess?.owner
    }
}

// MARK: - Equatable
extension PositionStatus: Equatable where Chess: Equatable {}

// MARK: - CustomStringConvertible
extension PositionStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .empty: return "·"
        case let .occupied(chess): return "\(chess)"
        }
    }
}
