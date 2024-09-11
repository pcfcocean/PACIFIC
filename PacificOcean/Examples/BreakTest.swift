//
//  BreakTest.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 1.02.24.
//

import Foundation

struct BreakTest {
    init() {
        let ex = true
        switch ex {
        case false:
            print("false")
        case true:
            print("true")
            break
        }
        print("ex\(ex)")
    }
}
