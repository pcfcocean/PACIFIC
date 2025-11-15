//
//  0001.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 4.05.25.
//

// https://leetcode.com/problems/two-sum/?envType=problem-list-v2&envId=array


class Solution0001 {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var result: [Int] = []

        nums.enumerated().forEach { index1, value1 in
            nums.enumerated().forEach { index2, value2 in
                if index2 > index1, value1 + value2 == target  {
                    result.append(index1)
                    result.append(index2)
                }
            }
        }

        return result
    }
}
