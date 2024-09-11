//
//  DispachText.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 1.03.24.
//

import Foundation

struct DispachTest {
    init() {
        print("start")
        let semaphore = DispatchSemaphore(value: 1)
        Thread.sleep(forTimeInterval: 3)
        semaphore.wait()
        print(semaphore.description)
        semaphore.signal()
        print(semaphore.description)
    }

    func cancelWorkItemExample() {
        let workItem = DispatchWorkItem {
            for i in 0...100 {
//                guard isCancelled else {
//                    print("WorkItem is cancelled")
//                    break
//                }
                print(i)
                sleep(1)
            }
        }
        workItem.notify(queue: .main) {
            print("workitem is completed")
        }
        let queue = DispatchQueue.global(qos: .utility)
        queue.async(execute: workItem)
        queue.asyncAfter(deadline: .now() + .seconds(3)) {
            //Do required task asfter 3 seconds
            workItem.cancel()
        }
    }
}
