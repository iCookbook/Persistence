//
//  Optional.swift
//  Expense
//
//  Created by Егор Бадмаев on 30.07.2022.
//

import Foundation

/// Allows to match for optionals with generics that are defined as non-optional.
protocol AnyOptional {
    /// Returns `true` if `nil`, otherwise `false`.
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}
