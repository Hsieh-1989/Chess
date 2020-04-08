//
//  PositionStatus.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public enum PositionStatus {
    case empty
    case occupied(ChessProtocol)
    
    public var isEmpty: Bool {
        switch self {
        case .empty: return true
        case .occupied: return false
        }
    }
    
    public var owner: Player? {
        guard case let .occupied(chess) = self else { return nil }
        return chess.owner
    }
}
