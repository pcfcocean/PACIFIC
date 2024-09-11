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
}
