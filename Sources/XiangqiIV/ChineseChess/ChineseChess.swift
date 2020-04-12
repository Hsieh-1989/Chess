//
//  ChineseChess.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public struct ChineseChess: ChessProtocol {
    
    public enum Player: String, PlayerProtocol {
        case red
        case black
    }
    
    public enum Kind: Equatable {
        case king
        case assistant
        case elephant
        case horse
        case chariot
        case cannon
        case soldier
    }
    
    // MARK: - Property
    public var id: Kind
    public var owner: Player
    
    // MARK: - Initializer
    public init(owner: Player, kind: Kind) {
        self.owner = owner
        self.id = kind
    }
    
    public static func red(_ kind: Kind) -> ChineseChess {
        return .init(owner: .red, kind: kind)
    }
    
    public static func black(_ kind: Kind) -> ChineseChess {
        return .init(owner: .black, kind: kind)
    }
}

extension ChineseChess: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

extension ChineseChess: RawRepresentable {
    public init?(rawValue: String) {
        if let kind = Kind.red(rawValue) {
            self = .red(kind)
        } else if let kind = Kind.black(rawValue) {
            self = .black(kind)
        } else {
            return nil
        }
    }
    
    public var rawValue: String {
        switch owner {
        case .red: return id.redName
        case .black: return id.blackName
        }
    }
}

// MARK: - Private Helper
extension ChineseChess.Kind {

    fileprivate static func red(_ value: String) -> ChineseChess.Kind? {
        switch value {
        case self.king.redName: return .king
        case self.assistant.redName: return.assistant
        case self.elephant.redName: return .elephant
        case self.horse.redName: return .horse
        case self.chariot.redName: return .chariot
        case self.cannon.redName: return .cannon
        case self.soldier.redName: return .soldier
        default: return nil
        }
    }
    
    fileprivate static func black(_ value: String) -> ChineseChess.Kind? {
        switch value {
        case self.king.blackName: return .king
        case self.assistant.blackName: return.assistant
        case self.elephant.blackName: return .elephant
        case self.horse.blackName: return .horse
        case self.chariot.blackName: return .chariot
        case self.cannon.blackName: return .cannon
        case self.soldier.blackName: return .soldier
        default: return nil
        }
    }
    
    fileprivate var redName: String {
        switch self {
        case .king: return "帥"
        case .assistant: return "仕"
        case .elephant: return "相"
        case .horse: return "傌"
        case .chariot: return "俥"
        case .cannon: return "炮"
        case .soldier: return "兵"
        }
    }
    
    fileprivate var blackName: String {
        switch self {
        case .king: return "將"
        case .assistant: return "士"
        case .elephant: return "象"
        case .horse: return "馬"
        case .chariot: return "車"
        case .cannon: return "包"
        case .soldier: return "卒"
        }
    }
}
