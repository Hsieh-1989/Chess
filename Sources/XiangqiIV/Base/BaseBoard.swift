//
//  BaseBoard.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public struct BaseBoard<Chess: ChessProtocol>: BoardProtocol {
    
    public struct Size: Equatable {
        public let width: Int
        public let height: Int
        
        public init(width: Int, height: Int) {
            self.width = width
            self.height = height
        }
    }
    
    // MARK: - Property
    public let size: Size
    private(set) var data: [[PositionStatus<Chess>]]
    
    public init(width: Int, height: Int) {
        self.size = Size(width: width, height: height)
        self.data = Array(
            repeating: Array(repeating: .empty, count: width),
            count: height
        )
    }
    
    // MARK: - Initializer
    public init(width: Int, height: Int, data: [Position: Chess]) {
        self.init(width: width, height: height)
        data.forEach { self[$0.0] = .occupied($0.1) }
    }
    
    // MARK: - Convenient Subscript
    public func get(position: Position) -> PositionStatus<Chess> {
        return data[position.y][position.x]
    }
    
    public mutating func set(_ status: PositionStatus<Chess>, at position: Position) {
        guard isValid(on: position) else { return }
        data[position.y][position.x] = status
    }
    
    // MARK: Private Helper
    public func isValid(on position: Position) -> Bool {
        position.x >= 0 && position.x < size.width && position.y >= 0 && position.y < size.height
    }
}

// MARK: - Equatable
extension BaseBoard: Equatable where Chess: Equatable {}

// MARK: - CustomStringConvertible
extension BaseBoard: CustomStringConvertible where Chess: CustomStringConvertible {
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
