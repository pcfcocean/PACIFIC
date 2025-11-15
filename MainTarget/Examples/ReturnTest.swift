//
//  ReturnTest.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 5.03.24.
//

import Foundation

struct ReturnTest {
    init() {
        guard false else { apple(); return }
    }

    func apple() {
        print("--- яблочко ---")
    }

    func switchProxyParamReturn(bool: Bool) -> String {
        var stringVar: String
        switch bool {
        case true:
            stringVar = "PRAVDA"
        case false:
            stringVar = "NE PRAVDA"
        }
        return stringVar
    }

    func switchDirectReturn(bool: Bool) -> String {
        switch bool {
        case true:
            return "PRAVDA"
        case false:
            return "NE PRAVDA"
        }
    }
}
