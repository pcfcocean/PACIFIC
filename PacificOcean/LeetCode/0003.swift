//
//  0003.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 4.05.25.
//

class Solution0003 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        
        var currentSubstring: String = ""
        var longestSubstring: String = ""
        s.forEach { character in
            if !currentSubstring.contains(character) {
                currentSubstring.append(character)
                if currentSubstring.count > longestSubstring.count {
                    longestSubstring = currentSubstring
                }
            } else {
                if let index = currentSubstring.firstIndex(of: character) {
                    currentSubstring = currentSubstring.suffix(from: currentSubstring.index(after: index)) + "\(character)"
                } else {
                    currentSubstring = "\(character)"
                }
            }
        }
        return longestSubstring.count
    }
}
