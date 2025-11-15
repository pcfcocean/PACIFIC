//
//  TrashFile.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 27.12.23.
//

import Foundation

struct Trash {
    enum ExecuteMode{
        case async
        case sync
    }

    private enum Constants {
        static let mainScreenItemId = UUID()
    }

    let queue1 = DispatchQueue(label: "com.example.queue.first", attributes: .concurrent)
    let queue2 = DispatchQueue(label: "com.example.queue.second", attributes: .concurrent)


    func start() {
        queue1.sync(flags: .barrier) {
            let content: String = "SYNC"
            self.write(content: content)
        }
        queue2.sync(flags: .barrier) {
            let content: String = "ASYNC"
            self.write(content: content)
        }
        (0...20).forEach { integer in
            queue1.async {
                let content: String = self.read()
                self.write(content: content)
            }
            queue2.sync {
                let content: String = String(integer)
                self.write(content: content)
            }
        }

        (0...20).forEach { integer in
            execute(mode: .async, completion: { print("\(integer)") })
        }

    }

    private func read() -> String {
        if let filePath = Bundle.main.path(forResource: "test", ofType: "txt") {
            do {
                let contents: String = try String(contentsOfFile: filePath)
                return contents
            } catch {
                print("Error reading file: \(error)")
            }
        } else {
            print("File not found")
        }
        return ""
    }

    private func write(content: String) {
        guard
            let dir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return }
        let fileUrl: URL = dir.appendingPathComponent("TEST.log")
        if !FileManager.default.fileExists(atPath: fileUrl.path) {
            FileManager.default.createFile(atPath: fileUrl.path, contents: nil)
        }
        guard
            let data: Data = "--- \n\(content)\n".data(using: .utf8),
            let file: FileHandle = try? FileHandle(forUpdating: fileUrl)
        else { return }
        file.seekToEndOfFile()
        file.write(data)
        file.closeFile()
    }

    private func execute(mode: ExecuteMode, completion: @escaping () -> Void) {
        var semaphore: DispatchSemaphore?
        switch mode {
        case .sync:
            semaphore = DispatchSemaphore(value: 0)
        case .async:
            semaphore = nil
        }

        queue1.async {
            completion()
            semaphore?.signal()
        }
        semaphore?.wait()
    }
}

