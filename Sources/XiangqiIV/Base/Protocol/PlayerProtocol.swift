//
//  PlayerProtocol.swift
//  XiangqiIV
//
//  Created by Hsieh Min Che on 2020/4/9.
//

public protocol PlayerProtocol: Hashable {
    var name: String { get }
}

extension PlayerProtocol where Self: RawRepresentable, Self.RawValue == String {
    public var name: String { rawValue }
}
