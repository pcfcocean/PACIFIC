//
//  Reversed.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 28.02.24.
//

import Foundation

struct Reversed {
    init() {
        var array: [Int] = [3, 2, 1]
        print("--- reverseD() ---")
        array.reversed().forEach { int in
            print("---")
            print(int)
            print("---")
        }
        print("---")
        print(array)
        print("--- reversE() ---")
        print(array.reverse())
    }
}
