//
//  BoardProtocol.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/4/11.
//

public protocol BoardProtocol {
    
    associatedtype Chess: ChessProtocol
    
    func get(position: Position) -> PositionStatus<Chess>
    mutating func set(_ status: PositionStatus<Chess>, at position: Position)
    
    func isValid(on position: Position) -> Bool
}

extension BoardProtocol {
    
    // MARK: - Convenient Subscript
    public subscript(x: Int, y: Int) -> PositionStatus<Chess> {
        get {
            get(position: .init(x: x, y: y))
        }
        mutating set {
            let position = Position(x: x, y: y)
            guard isValid(on: position) else { return }
            set(newValue, at: position)
        }
    }
    
    public subscript(position: Position) -> PositionStatus<Chess> {
        get {
            get(position: position)
        }
        mutating set {
            guard isValid(on: position) else { return }
            set(newValue, at: position)
        }
    }
}
