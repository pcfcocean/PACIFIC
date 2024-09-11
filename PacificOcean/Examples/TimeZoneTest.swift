//
//  TimeZoneTest.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 2.03.24.
//

import Foundation

struct TimeZoneTest {
    init() {
        print(TimeZone.current.secondsFromGMT())
        let timeZome: Int = TimeZone.current.secondsFromGMT() / 3600
        print("+\(timeZome)")
        print(TimeZone.current)

        let timeZone = TimeZone.current
        let gmtOffset = timeZone.secondsFromGMT() / 3600

        if gmtOffset >= 0 {
            print("GMT+\(String(format: "%02d", gmtOffset))")
        } else {
            print("GMT\(String(format: "%02d", gmtOffset))")
        }
    }
}
