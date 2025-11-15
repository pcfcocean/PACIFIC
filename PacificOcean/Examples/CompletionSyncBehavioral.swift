//
//  CompletionSyncBehavioral.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 10.10.24.
//

import Foundation

struct CompletionSyncBehavioral {
    init() {
        test()
    }

    func test() {
        var value: Int = 4
        delayedFunc(value: value, increment: 0, completion: { newValue in
            print("new value is: \(newValue)")
            value = newValue
            print("after: value is: \(value)")
        })
        value += 1
        print("before: value is: \(value)")
    }

    private func delayedFunc(value: Int, increment: Int, completion: @escaping (Int) -> Void) {
        guard increment > .zero else { return completion(value - 1) }
        DispatchQueue.global(qos: .userInitiated).async {
            completion(value + increment)
        }
    }
}
