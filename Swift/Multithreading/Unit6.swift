//
//  Unit6.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 4.01.24.
//

import Foundation

// MARK: - Multithreading в swift с нуля: урок 6 - ReadWriteLock, SpinLock, UnfairLock, Synchronized in Objc
// https://www.youtube.com/watch?v=XZB8GUUHuLQ

class ReadWriteLock {
    private var lock: pthread_rwlock_t = pthread_rwlock_t()
    private var attribute: pthread_rwlockattr_t = pthread_rwlockattr_t()

    private var gloabalProperty: Int = 0

    init() {
        pthread_rwlock_init(&lock, &attribute)
    }

    public var worldProperty: Int {
        get {
            pthread_rwlock_wrlock(&lock)
            let temp: Int = gloabalProperty
            pthread_rwlock_unlock(&lock)
            return temp
        }

        set {
            pthread_rwlock_wrlock(&lock)
            gloabalProperty = newValue
            pthread_rwlock_unlock(&lock)
        }
    }
}

// deprecated in iOS 10
class SpinLock {
    private var lock: Int32 = OS_SPINLOCK_INIT

    func some() {
        OSSpinLockLock(&lock)
        // something code
        OSSpinLockUnlock(&lock)
    }
}

// c iOS10
class UnfairLock {
    private var lock = os_unfair_lock_s()

    var array: [Int] = []

    func some() {
        os_unfair_lock_lock(&lock)
        array.append(10)
        os_unfair_lock_unlock(&lock)
    }
}

class SynchronizedObjC {
    private let lock = NSObject()

    var array: [Int] = []

    func some() {
        objc_sync_enter(lock)
        array.append(7)
        objc_sync_exit(lock)
    }
}


struct Unit6 {
    init() {

    }
}
