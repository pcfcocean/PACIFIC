//
//  Unit2.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 24.12.23.
//

import Foundation

// MARK: - Multithreading в swift с нуля: урок 2 - Quality of service (QoS) Приоритеты потока
// https://www.youtube.com/watch?v=EfOB8KJo-yg

// Quality of Service

// QOS_CLASS_USER_INTERACTIVE - пользователь взаимодействует с UI. Юзер ждет результата выполенения прямо сейчас

// QOS_CLASS_USER_INITIATED - нужно сделать: но не внутри интерактивного события, но не затягивая

// QOS_CLASS_DEFAULT - среднее между QOS_CLASS_USER_INTERACTIVE и QOS_CLASS_USER_INITIATED

// QOS_CLASS_UTILITY - задачи в фоновом режиме с более длительны временем исполнения (пример очистка БД, кеша)

// QOS_CLASS_BACKGROUND - Нет точного времени выполнения потока (фоновый режим по доступности ресурсов системы)

// QOS_CLASS_UNSPECIFIED - отсутствие QOS

struct QualityOfService {

    // Unix - POSIX
    func createThreadPOSIX() {
        // Создаем поток с использованием языковых структур C (в язфке С есть только структуры)
        var thread: pthread_t? = pthread_t(bitPattern: 0)

        // Создаем атрибут - настройка потока
        var attribut: pthread_attr_t = pthread_attr_t()

        // Инициализируем атрибут
        pthread_attr_init(&attribut)

        // Настройка QOS для атрибута
        pthread_attr_set_qos_class_np(&attribut, QOS_CLASS_USER_INITIATED, 0)

        // Добавляем поток в систему на исполнение
        pthread_create(
            &thread,
            &attribut,
            { pointer in
                print("Quality of Service - example")

                // Смена QOS приоритета self потока
                pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0)

                return nil
            },
            nil
        )
    }

    // Thread
    func createThreadObjCWarapped() {
        // Создаем поток с использованием оболочки написанной на языке ObjectiveC
        let nsThread: Thread = Thread {
            print("Thread - пример")
            print(qos_class_self())
        }

        // Настройка QOS для потока
        nsThread.qualityOfService = .userInteractive

        // Добавляем поток в систему на исполнение
        nsThread.start()

        // Принтуем qos main потока
        print(qos_class_main())
    }
}


// Не путаем очередь и поток, сейчас идет речь про потоки. Очередь - это структура данных
