//
//  GuardTest.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 27.03.24.
//

import Foundation

struct GuardTest {
    init() {
        handle()
    }

    func guardTest() {
        guard false else { return printer() }
        print("--- aftre guard")
    }

    private func printer() {
        print("--- private func print")
    }

    private func handle() {
        let boolean = true
        switch boolean {
        case true:
            guard true else {
                print("--- 1")
                return
            }
            guard false else { break }
            return print("--- TRUE")
        case false:
            print("--- FALSE")
        }
        print("--- Apple")
    }

    func guardContinueTest() {
        if true {
            guard false else {
                print("--- 2")
                // continue /// continue' is only allowed inside a loop
                return
            }
            print("--- 1")
        }
        print("--- 3")
    }
}
