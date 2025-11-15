//
//  Locked.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 29.05.25.
//

import Foundation

@propertyWrapper
public struct Atomic<Value> {
    private var value: Value
    private let lock = NSLock()

    public init(wrappedValue: Value) {
        self.value = wrappedValue
    }

    public var wrappedValue: Value {
        get { lock.withLock { value } }
        set { lock.withLock { value = newValue } }
    }
}

class LockedTest {
    @Atomic var isActive = false

    func changeLockedValue() {
        isActive = true
    }
}
