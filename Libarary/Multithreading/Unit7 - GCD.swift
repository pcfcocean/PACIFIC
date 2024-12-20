//
//  Unit7.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 4.01.24.
//

import Foundation

// Multithreading в swift с нуля: урок 7 - GCD,Concurrent queues, Serial queues,sync-async
// https://www.youtube.com/watch?v=_7hc4INA1Yc


class QueueTest1 {
    private let serialQueue: DispatchQueue = DispatchQueue(label: "serial queue")
    private let concurrentQueue: DispatchQueue = DispatchQueue(label: "concurrent queue", attributes: .concurrent)

    private let globalConcurrentQueue: DispatchQueue = DispatchQueue.global()
    private let mainSerialQueue: DispatchQueue = DispatchQueue.main
}

// DEADLOCK

struct DEADLOCK {
    init(){
        let serialQueue = DispatchQueue(label: "serial queue")
        serialQueue.async {
            print("code 1")
            serialQueue.sync {
                print("DEADLOCK")
            }
        }
    }
}

struct DEADLOCKonMAIN {
    init(){
        let serialQueue = DispatchQueue(label: "serial queue")
        serialQueue.async {
            print(Thread.isMainThread)
            DispatchQueue.main.sync {
                print("DEADLOCK")
            }
        }
    }
}
