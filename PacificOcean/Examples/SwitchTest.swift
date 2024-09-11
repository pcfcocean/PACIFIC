//
//  SwitchTest.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 8.02.24.
//

import Foundation

struct SwitchTest {
    func свитч() {
        let bool: Bool = true
        switch bool {
        case true:
            print("--- case \(bool)")
            return print("--- выполнение")
            print("--- выполнение2")
        case false:
            print("--- case \(bool)")
            guard bool else { return }
        }
        print("--- выход из функции свитч()")
    }
}
