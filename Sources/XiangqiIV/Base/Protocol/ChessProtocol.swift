//
//  ChessProtocol.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/2/24.
//

public protocol ChessProtocol: Hashable {
    
    associatedtype ID: Hashable
    associatedtype Player: PlayerProtocol
    
    var id: ID { get }
    var owner: Player { get }
}
