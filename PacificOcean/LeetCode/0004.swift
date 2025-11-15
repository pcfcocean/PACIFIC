//
//  0004.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 4.05.25.
//

// https://leetcode.com/problems/median-of-two-sorted-arrays/?envType=problem-list-v2&envId=array

class Solution0004 {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {

        let mergedSortedArray: [Int] = (nums1 + nums2).sorted()

        let middleIndex: Int = mergedSortedArray.count / 2

        if mergedSortedArray.count % 2 == 0 {
            return (Double(mergedSortedArray[middleIndex]) + Double(mergedSortedArray[middleIndex - 1])) / 2.0
        }

        return Double(mergedSortedArray[middleIndex])
    }
}
