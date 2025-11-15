//
//  IfNeededComplexTest.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 10.10.24.
//

import Foundation
import Combine

class COMbine {

    @Published
    private var changedValue: Int = 0

    init() {
        test()
        test2()
    }

    private var cancellable: Set<AnyCancellable> = []

    private func test() {
        print("TIMER")
        Timer.publish(every: 1, on: .main, in: .tracking)
            .autoconnect()
            .sink(
                receiveCompletion: { receiveCompletion in
                    print("receiveCompletion")
                },
                receiveValue: { receiveValue in
                    print("receiveValue")
                }
            )
            .store(in: &cancellable)
    }

    func test2() {
        var cancellable: [AnyCancellable] = []
        let arrayPublisher: Publishers.Sequence<[Int], Never> = [1, 2, 3].publisher
        arrayPublisher
            .map { initialValue in
                String("\(initialValue)---")
            }
            .sink { transformedValue in
                print(transformedValue)
            }
            .store(in: &cancellable)
    }
}
