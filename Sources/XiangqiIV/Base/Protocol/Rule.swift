//
//  Rule.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/4/18.
//

public protocol Rule {
    
    associatedtype Board: BoardProtocol
    associatedtype Result
    
    func verify(_ board: Board) -> Result
}
