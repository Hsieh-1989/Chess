//
//  MockChess.swift
//  XiangqiIVTests
//
//  Created by Hsieh Min Che on 2020/4/12.
//

import XiangqiIV

struct MockChess: ChessProtocol, Equatable, CustomStringConvertible {
    
    enum Player: String, PlayerProtocol, CaseIterable {
        case X
        case O
    }

    var id: Player { owner }
    let owner: Player
    
    static let X = MockChess(owner: .X)
    static let O = MockChess(owner: .O)
    
    static func == (lhs: MockChess, rhs: MockChess) -> Bool {
        return lhs.owner == rhs.owner
    }
    
    var description: String {
        switch owner {
        case .X: return "Ｘ"
        case .O: return "Ｏ"
        }
    }
}

extension MockChess: RawRepresentable {
    init?(rawValue: String) {
        switch rawValue {
        case MockChess.X.rawValue:
            self = .X
        case MockChess.O.rawValue:
            self = .O
        default:
            return nil
        }
    }
    
    var rawValue: String {
        return description
    }
}
