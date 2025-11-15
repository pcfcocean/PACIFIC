//
//  ArrayTest.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 1.03.24.
//

import Foundation

class ArrayTest {
    struct Item {
        let name: String
        var value: Bool
    }
    var array: [Item] = []

    let queue = DispatchQueue(label: "arrayQueue", attributes: .concurrent)
    init() {
        (0 ... 1000).forEach { [weak self] int in
            queue.async { [weak self] in
                self?.array.append(Item(name: "\(int)", value: true))
            }
        }


        (0 ... 1000).forEach { int in
            queue.async { [weak self] in
                self?.array[int].value = false
            }
        }

        array.forEach { item in
            print(item)
        }
    }
}
