//
//  Unit1.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 24.12.23.
//

import Foundation

// MARK: - Multithreading в swift с нуля: урок 1 - Thread & Pthread
// https://www.youtube.com/watch?v=JtDf-S1uLLs

// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Multithreading/Introduction/Introduction.html#//apple_ref/doc/uid/10000057i-CH1-SW1
// https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008091-CH1-SW1

//Thread
//Operations

//GCD

// Парллельная очередь (параллельные потоки)
// Thread1---------------
// Thread2---------------

// Последовательная очередь (последовательные потоки)
// Thread1-------       ------------
// Thread2       -------

// Асинхронная очередь (асинхронные потоки)
// Main thread ---------------
// Thread1          -------
// Thread2            ----

struct ThreadsExample {

    // Unix - POSIX
    func createThread() {
        // Создаем поток с использованием языковых структур C (в языке С есть только структуры)
        var thread: pthread_t? = pthread_t(bitPattern: 0)
        // Создаем атрибут
        var attribut: pthread_attr_t = pthread_attr_t()
        // Инициализируем атрибут
        pthread_attr_init(&attribut)

        let threadStackSize: Int = 0 // Размер стека потока в байтах
        // Определяем размер потока в байтах
        pthread_attr_setstacksize(&attribut, threadStackSize)

        // Добавляем поток в систему на исполнение
        pthread_create(
            &thread,
            &attribut,
            { pointer in
                print("Поток добавлен на выполнение")
                return nil
            },
            nil
        )
    }

    // Thread
    func createThreadObjCWarapped() {
        // Создаем поток с использованием оболочки написанной на языке ObjectiveC
        let nsThread: Thread = Thread {
            print("Поток добавлен на выполнение")
        }
        // Добавляем поток в систему на исполнение
        nsThread.start()

        // Задаем размер стека потока в байтах
        nsThread.stackSize = 1024 * 1024

        // Останавливаем выполенние потока
//        nsThread.cancel()

        // Добавляем данные в поток, чтобы потом достать из потока в нужном месте
        nsThread.setValue("StringData", forKey: "customThreadKey")

        // Задаем приоритет, чем выше тем быстрее он выполняется в системе
        Thread.setThreadPriority(2)
    }

}
