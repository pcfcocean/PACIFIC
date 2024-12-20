//
//  Unit11.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 22.06.24.
//

import Foundation


struct DispatchSemaphoreTest {
    init() {
//        f1()
        f2()
    }

    func f1() {
        let queue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)

        let semaphore = DispatchSemaphore(value: 1)

        queue.async {
            semaphore.wait() // -1
            print("method 1")
            sleep(1)
            semaphore.signal() // +1
        }
        queue.async {
            semaphore.wait() // -1
            print("method 2")
            sleep(1)
            semaphore.signal() // +1
        }
        queue.async {
            semaphore.wait() // -1
            print("method 3")
            sleep(1)
            semaphore.signal() // +1
        }
        queue.async {
            semaphore.wait() // -1
            print("method 4")
            sleep(1)
            semaphore.signal() // +1
        }
    }

    func f2() {
        let semaphore = DispatchSemaphore(value: 1)
        DispatchQueue.concurrentPerform(iterations: 10) { id in
            semaphore.wait() // -1
            print("Block", id, Thread.current)
            sleep(1)
            semaphore.signal() // +1
        }
    }
}
