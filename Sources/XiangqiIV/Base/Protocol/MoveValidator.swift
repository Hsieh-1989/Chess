//
//  MoveValidator.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public protocol MoveValidator {
    
    associatedtype Board: BoardProtocol

    func validate(from original: Position, to destination: Position, on board: Board) -> Bool
}
