//
//  ReaderAndWriter.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 27.12.23.
//

import Foundation

struct ReaderAndWriter {
    func read() -> String {
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

    func write(content: String) {
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
}
