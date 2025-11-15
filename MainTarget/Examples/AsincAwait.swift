//
//  AsincAwait.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 24.08.24.
//

import Foundation

struct AsincAwait {
    init() {
        test()
    }

    private func test() {
        (0 ... 20).forEach { index in
            Task {
                print("Task # \(index) - START")
                print(Thread().description)
                sleep(UInt32(10))
                print("Task # \(index) - FINISH")
            }
        }
    }
}
