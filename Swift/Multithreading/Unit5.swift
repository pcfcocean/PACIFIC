//
//  Unit5.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 24.12.23.
//

import Foundation

// MARK: - Multithreading в swift с нуля: урок 5 - NSCondition,NSLocking, pthread_cond_t
// https://www.youtube.com/watch?v=V0jpPiKHhh8

// https://developer.apple.com/documentation/foundation/nscondition

class ConditionMutexHelper {
    var available: Bool = false
    var condition: pthread_cond_t = pthread_cond_t()
    var mutex: pthread_mutex_t = pthread_mutex_t()

    let nsCondition: NSCondition = NSCondition()
}

class ConditionMutexPrinter: Thread {
    let conditionMutexHelper: ConditionMutexHelper

    init(conditionMutexHelper: ConditionMutexHelper) {
        self.conditionMutexHelper = conditionMutexHelper
        pthread_cond_init(&conditionMutexHelper.condition, nil)
        pthread_mutex_init(&conditionMutexHelper.mutex, nil)
        super.init()
    }

    override func main() {
        printerMethod()
    }

    private func printerMethod() {
        defer {
            pthread_mutex_unlock(&conditionMutexHelper.mutex)
        }
        print("Printer enter")
        pthread_mutex_lock(&conditionMutexHelper.mutex)
        while (!conditionMutexHelper.available) {
            pthread_cond_wait(&conditionMutexHelper.condition, &conditionMutexHelper.mutex)
        }
        conditionMutexHelper.available = false
        print("Printer exit")
    }
}

class ConditionMutexWriter: Thread {
    let conditionMutexHelper: ConditionMutexHelper

    init(conditionMutexHelper: ConditionMutexHelper) {
        self.conditionMutexHelper = conditionMutexHelper
        pthread_cond_init(&conditionMutexHelper.condition, nil)
        pthread_mutex_init(&conditionMutexHelper.mutex, nil)
        super.init()
    }

    override func main() {
        writerMethod()

    }

    private func writerMethod() {
        defer {
            pthread_mutex_unlock(&conditionMutexHelper.mutex)
        }
        print("Writer enter")
        pthread_mutex_lock(&conditionMutexHelper.mutex)
        conditionMutexHelper.available = true
        pthread_cond_signal(&conditionMutexHelper.condition)
        print("Writer exit")
    }
}

class WriterThread: Thread {
    let conditionMutexHelper: ConditionMutexHelper

    init(conditionMutexHelper: ConditionMutexHelper) {
        self.conditionMutexHelper = conditionMutexHelper
        super.init()
    }

    override func main() {
        conditionMutexHelper.nsCondition.lock()
        print("WriterThread enter")
        conditionMutexHelper.available = true
        conditionMutexHelper.nsCondition.signal()
        conditionMutexHelper.nsCondition.unlock()
        print("WriterThread exit")
    }
}

class PrinterThread: Thread {
    let conditionMutexHelper: ConditionMutexHelper

    init(conditionMutexHelper: ConditionMutexHelper) {
        self.conditionMutexHelper = conditionMutexHelper
        super.init()
    }

    override func main() {
        conditionMutexHelper.nsCondition.lock()
        print("PrinterThread enter")
        while !conditionMutexHelper.available {
            conditionMutexHelper.nsCondition.wait()
        }
        conditionMutexHelper.available = false
        conditionMutexHelper.nsCondition.unlock()
        print("PrinterThread exit")
    }
}

struct Unit5MultithreadingTest {
    init() {
        let conditionMutexHelper = ConditionMutexHelper()
        let conditionMutexPrinter = ConditionMutexPrinter(conditionMutexHelper: conditionMutexHelper)
        let conditionMutexWriter = ConditionMutexWriter(conditionMutexHelper: conditionMutexHelper)
//        conditionMutexWriter.start()
//        conditionMutexPrinter.start()


        let printerThread = PrinterThread(conditionMutexHelper: conditionMutexHelper)
        let writerThread = WriterThread(conditionMutexHelper: conditionMutexHelper)
        printerThread.start()
        writerThread.start()
    }
}
