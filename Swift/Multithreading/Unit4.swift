//
//  Unit4.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 24.12.23.
//

import Foundation

// MARK: - Multithreading в swift с нуля: урок 4 - NSRecursiveLock & Mutex Recursive lock 4
// https://www.youtube.com/watch?v=dX4BQXUknF4

// Проблемы многопоточности в Swift
// https://ios-interview.ru/multithreading-problems/
// https://medium.com/@alexey_nenastev/всё-о-многопоточности-в-swift-часть-1-настоящее-f0b4d5718877

// Условия гонки [Race condition]: С несколькими потоками, при работе с одними данными, в результате чего сами данные становятся непредсказуемыми и зависят от порядка выполнения потоков.
// Конкуренция за ресурс [Resource contention]: Несколько потоков, выполняющих разные задачи, пытаются получить доступ к одному ресурсу, тем самым увеличивая время необходимое для безопасного получения ресурса. Эта задержка может привести к непредвиденному поведению.
// Вечная блокировка [Deadlock]: Несколько потоков блокируют друг друга.
// Голодание [Starvation] : Поток не может получить доступ к ресурсу и безуспешно пытается сделать это снова и снова.
// Инверсия приоритетов [Priority Inversion]: Поток с низким приоритетом удерживает ресурс, которые требуется другому потоку с более высоким приоритетом.
// Неопределенность и справедливость [Non-deterministic and Fairness]: Мы не можем делать предположений, когда и в каком порядке поток сможет получить ресурс, эта задержка не может быть определена априори и в значительной степени зависит от количества конфликтов. Однако, примитивы синхронизации могут обеспечивать справедливость, гарантируя доступ всем потокам которые ожидают, также учитываю порядок.

// NSLock Нельзя использовать этот класс для реализации рекурсивной блокировки. Вызов lock метода дважды в том же потоке блокирует поток навсегда. Вместо этого нужно использовать класс для реализации рекурсивных локов. NSRecursiveLock - Возникает голодание

// NSRecursiveLock

class RecursiveMutexExapmle {
    private var mutex: pthread_mutex_t = pthread_mutex_t()
    private var attribute: pthread_mutexattr_t = pthread_mutexattr_t()

    init() {
        pthread_mutexattr_init(&attribute)
        pthread_mutexattr_settype(&attribute, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attribute)
    }

    func firstTask() {
        defer {
            pthread_mutex_unlock(&mutex)
        }
        pthread_mutex_lock(&mutex)
        twoTask()
    }

    func twoTask() {
        defer {
            pthread_mutex_unlock(&mutex)
        }
        pthread_mutex_lock(&mutex)
        print("finish")
    }
}

struct Utils4Test {
    let recursive = RecursiveMutexExapmle()
    init() {
        recursive.firstTask()
    }
}

class RecursiveThredExample: Thread {
    let recursiveLock: NSRecursiveLock = NSRecursiveLock()

    override func main() {
        defer {
            recursiveLock.unlock()
        }
        recursiveLock.lock()
        print("Данные заблокированы для изменений из других потоков")
        callMe()
        print("Выходим из func main")
    }

    func callMe() {
        defer {
            recursiveLock.unlock()
        }
        recursiveLock.lock()
        print("Данные заблокированы для изменений из других потоков")
        print("Return из func callMe()")
    }
}


struct Utils4RecursiveThredExampleTest {
    let thread = RecursiveThredExample()
    init() {
        thread.start()
    }
}
