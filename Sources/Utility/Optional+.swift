//
//  Optional+.swift
//  
//
//  Created by Yue Cai on 2021/12/22.
//

import Foundation

public protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}
