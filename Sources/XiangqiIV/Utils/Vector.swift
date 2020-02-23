//
//  Vector.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public struct Vector: Equatable, Hashable {
    public var x: Int
    public var y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

extension Vector: CustomStringConvertible {
    public var description: String {
        "(\(x),\(y))"
    }
}

// MARK: - Public Method
extension Vector {
    
    var isLinear: Bool {
        isVertical || isHorizontal
    }
    
    var isVertical: Bool {
        x == 0 && y != 0
    }
    
    var isHorizontal: Bool {
        x != 0 && y == 0
    }
    
    static func +(lhs: Vector, rhs: Vector) -> Vector {
        return Vector(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func - (lhs: Vector, rhs: Vector) -> Vector {
        return Vector(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func += (lhs: inout Vector, rhs: Vector) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
    
    static func -= (lhs: inout Vector, rhs: Vector) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
    }
    
    static prefix func - (rhs: Vector) -> Vector {
        return Vector(x: -rhs.x, y: -rhs.y)
    }
}

// MARK: - Internal Helper

extension Vector {
    internal func linearSteps(to destination: Vector) -> [Vector] {
        let vector = destination - self
        guard self != destination, vector.isLinear else { return [] }
        if vector.y > 0 {
            let range = (y + 1)...destination.y
            return range.map { Vector(x: x, y: $0) }
        } else if vector.y < 0 {
            let range = (destination.y)...(y - 1)
            return range.map { Vector(x: x, y: $0) }.reversed()
        } else if vector.x > 0 {
            let range = (x + 1)...(destination.x)
            return range.map { Vector(x: $0, y: x) }
        } else {
            let range = (destination.x)...(x - 1)
            return range.map { Vector(x: $0, y: y) }.reversed()
        }
    }
}

