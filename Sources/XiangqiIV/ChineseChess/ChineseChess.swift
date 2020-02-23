//
//  ChineseChess.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public struct ChineseChess: Chess {
    
    public enum Kind: Equatable {
        case king
        case assistant
        case elephant
        case horse
        case chariot
        case cannon
        case soldier
    }
    
    public var kind: Kind
    public var owner: Player
    public var moveValidation: MoveValidation { kind.validation }
    
    public init(owner: Player, kind: Kind) {
        self.owner = owner
        self.kind = kind
    }
}

extension ChineseChess: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

extension ChineseChess: RawRepresentable {
    public init?(rawValue: String) {
        switch rawValue {
        case .redKing:
            self = ChineseChess(owner: .red, kind: .king)
        case .redAssistant:
            self = ChineseChess(owner: .red, kind: .assistant)
        case .redElephant:
            self = ChineseChess(owner: .red, kind: .elephant)
        case .redHorse:
            self = ChineseChess(owner: .red, kind: .horse)
        case .redChariot:
            self = ChineseChess(owner: .red, kind: .chariot)
        case .redCannon:
            self = ChineseChess(owner: .red, kind: .cannon)
        case .redSoldier:
            self = ChineseChess(owner: .red, kind: .soldier)
        case .blackKing:
            self = ChineseChess(owner: .black, kind: .king)
        case .blackAssistant:
            self = ChineseChess(owner: .black, kind: .assistant)
        case .blackElephant:
            self = ChineseChess(owner: .black, kind: .elephant)
        case .blackHorse:
            self = ChineseChess(owner: .black, kind: .horse)
        case .blackChariot:
            self = ChineseChess(owner: .black, kind: .chariot)
        case .blackCannon:
            self = ChineseChess(owner: .black, kind: .cannon)
        case .blackSoldier:
            self = ChineseChess(owner: .black, kind: .soldier)
        default:
            return nil
        }
    }
    
    public var rawValue: String {
        switch owner {
        case .red: return kind.redName
        case .black: return kind.blackName
        }
    }
}

extension ChineseChess.Kind {
    fileprivate var validation: BaseMoveValidation {
        switch self {
        case .king: return .king
        case .assistant: return .assistant
        case .elephant: return .elephant
        case .horse: return .horse
        case .chariot: return .chariot
        case .cannon: return .cannon
        case .soldier: return .soldier
        }
    }
    
    fileprivate var redName: String {
        switch self {
        case .king: return .redKing
        case .assistant: return .redAssistant
        case .elephant: return .redElephant
        case .horse: return .redHorse
        case .chariot: return .redChariot
        case .cannon: return .redCannon
        case .soldier: return .redSoldier
        }
    }
    
    fileprivate var blackName: String {
        switch self {
        case .king: return .blackKing
        case .assistant: return .blackAssistant
        case .elephant: return .blackElephant
        case .horse: return .blackHorse
        case .chariot: return .blackChariot
        case .cannon: return .blackCannon
        case .soldier: return .blackSoldier
        }
    }
}

extension String {
    // red
    fileprivate static let redKing = "帥"
    fileprivate static let redAssistant = "仕"
    fileprivate static let redElephant = "相"
    fileprivate static let redHorse = "傌"
    fileprivate static let redChariot = "俥"
    fileprivate static let redCannon = "炮"
    fileprivate static let redSoldier = "兵"
    // black
    fileprivate static let blackKing = "將"
    fileprivate static let blackAssistant = "士"
    fileprivate static let blackElephant = "象"
    fileprivate static let blackHorse = "馬"
    fileprivate static let blackChariot = "車"
    fileprivate static let blackCannon = "包"
    fileprivate static let blackSoldier = "卒"
}
