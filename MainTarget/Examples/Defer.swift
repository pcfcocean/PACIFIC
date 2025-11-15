//
//  Defer.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 12.01.24.
//

import Foundation

struct DeferTest {
    func test() -> String {
        var currentString: String = ""

        currentString.append("a")
        print(currentString)

        defer {
            currentString.append("b")
            print(currentString)
        }

        if true {
            defer {
                currentString.append("c")
                print(currentString)
            }

            defer {
                currentString.append("d")
                print(currentString)
            }

            currentString.append("e")
            print(currentString)
        }

            currentString.append("f")
            print(currentString)

        defer {
            currentString.append("g")
            print(currentString)
        }

        print(currentString)
        return currentString
    }
}
