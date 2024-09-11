//
//  QueueTest.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 4.01.24.
//

import Foundation

struct QueueTest {
    let queue = DispatchQueue(label: "QueueTest", qos: .userInitiated)
    let concurrentQueue = DispatchQueue(label: String(describing: Self.self), attributes: .concurrent)

    let userInitiatedQueue = DispatchQueue(label: "UserInitiatedQueue", qos: .userInitiated)
    let userInteractiveQueue = DispatchQueue(label: "UserInteractiveQueue", qos: .userInteractive)

    init() {
        print("--- start init")
//        executeStruct()
        print("--- stop init")
    }

    private func executeStruct() {
        print("--- start Method")
        queue.async {
            print("--- start Thread.sleep(forTimeInterval: 3)")
            Thread.sleep(forTimeInterval: 3)
            print("--- stop Thread.sleep(forTimeInterval: 3)")
        }
        print("--- stop Method")
    }

    private func log(int: Int) {
        concurrentQueue.async(flags: .barrier) {
            print("--- \(int)")
        }
    }

    func test() {
        userInitiatedQueue.sync {
            (1...100).forEach { int in
                log(int: int)
            }
            (101...200).forEach { int in
                log(int: int)
            }
            (201...300).forEach { int in
                log(int: int)
            }
        }
        userInteractiveQueue.async {
            (301...400).forEach { int in
                log(int: int)
            }
            (401...500).forEach { int in
                log(int: int)
            }
        }
    }

}
