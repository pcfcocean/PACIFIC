//
//  Unit3.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 24.12.23.
//

import Foundation

// MARK: - Multithreading в swift с нуля: урок 3 - Synchronisation & Mutex
// https://www.youtube.com/watch?v=mqv1fcpt2dI

// блокирует доступ к ресурсу из других потоков, разрешено только из текущего (только один поток может владеть о объектом). Если другому потоку
// понадобится получить доступ к ресурсу то он будет как-бы засыпать, пока предыдущий не отпустит (unlock) объект

// быстрый процесс относительно GCD Semaphore
class SaveThread {
    // Создаем объект mutex С
    private var mutex: pthread_mutex_t = pthread_mutex_t()

    init() {
    // Инициализируем Mutex
     pthread_mutex_init(&mutex, nil)
    }


    func saveOperation(completion: () -> Void) {
        // unlock в defer нужен для того чтобы если что-то пойдет не так в completion поток освободил объект
        defer {
            // Разблокирует объект занятый данным потоком (после проведения операции или в случае досрочного выхода из функции)
            pthread_mutex_unlock(&mutex)
        }
        // Блокирует объект занятый данным потоком для изменений из других потоков
        pthread_mutex_lock(&mutex)
        completion()
    }
}

class SaveThreadObjC {
    private let lockMutex: NSLock = NSLock()

    func saveOperation(completion: () -> Void) {
        defer {
            lockMutex.unlock()
        }
        lockMutex.lock()
        completion()
    }
}
