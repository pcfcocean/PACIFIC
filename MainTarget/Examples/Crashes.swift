//
//  Crashes.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 17.08.25.
//

import Foundation

class Crashes {

    var array: [Int] = Array(repeating: 1, count: 100)

    init() {
        start()
    }

    func start() {
        array.forEach { value in
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                self.array[1] = 3
                print("iteration", value, "array", self.array)
            }
        }
    }
}
