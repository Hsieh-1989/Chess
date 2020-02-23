//
//  Board.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public struct Board {
    
    public struct Size {
        let width: Int
        let height: Int
    }
    
    public let size: Size
    private var data: [[PositionStatus]]
    
    public init(width: Int, height: Int) {
        self.size = Size(width: width, height: height)
        self.data = Array(
            repeating: Array(repeating: .empty, count: width),
            count: height
        )
    }
    
    public init(width: Int, height: Int, data: [Position: Chess]) {
        self.init(width: width, height: height)
        data.forEach { self[$0.0] = .occupied($0.1) }
    }
    
    public subscript(x: Int, y: Int) -> PositionStatus {
        get {
            data[y][x]
        }
        mutating set {
            let position = Position(x: x, y: y)
            guard isValid(on: position) else { return }
            data[y][x] = newValue
        }
    }
    
    public subscript(index: Position) -> PositionStatus {
        get {
            data[index.y][index.x]
        }
        mutating set {
            guard isValid(on: index) else { return }
            data[index.y][index.x] = newValue
        }
    }
    
    private func isValid(on position: Position) -> Bool {
        position.x >= 0 && position.x < size.width && position.y >= 0 && position.y < size.height
    }
}

extension Board: Sequence {
    public __consuming func makeIterator() -> AnyIterator<(Position, PositionStatus)> {
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

extension Board: CustomStringConvertible {
    public var description: String {
        data.reduce(into: "") { result, line in
            defer { result += "\n" }
            result += line.reduce(into: "") { currentLine, chess in
                guard case let .occupied(chess) = chess else {
                    currentLine += "・"
                    return
                }
                result += chess.description
            }
        }
    }
}
