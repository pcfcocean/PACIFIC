//
//  LetVarTest.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 4.03.24.
//

import Foundation

struct LetVarTest {
    private enum Constants {
        static let constant1: Int = 1
        static var constant2: Int {
            print("---")
            return Int(Date().timeIntervalSince1970)
        }
    }
    init() {}
    func execute1() {
        print(Constants.constant1)
        print(Constants.constant2)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.execute2()
        }
    }

    func execute2() {
        print(Constants.constant1)
        print(Constants.constant2)
    }
}
