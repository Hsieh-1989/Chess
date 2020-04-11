//
//  BoardProtocol.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/4/11.
//

public protocol BoardProtocol: Sequence {
    
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

// MARK: - Sequence
extension BoardProtocol {
    public __consuming func makeIterator() -> AnyIterator<(Position, PositionStatus<Self.Chess>)> {
        var position: Position? = Position(x: 0, y: 0)
        return AnyIterator {
            guard let current = position else { return nil }
            defer {
                let next = current + Position(x: 1, y: 0)
                if self.isValid(on: next) {
                    position = next
                } else {
                    let next = Position(x: 0, y: current.y + 1)
                    position = self.isValid(on: next) ? next : nil
                }
            }
            return (current, self[current])
        }
    }
}
