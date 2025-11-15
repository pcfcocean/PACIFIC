//
//  URLTest.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 22.02.24.
//

import Foundation

struct URLTest {
    init() {
        let url: URL? = URL(string: "")
        guard let url: URL = url else {
            print("--- nil")
            return
        }
        print("--- \(url)")
    }
}
