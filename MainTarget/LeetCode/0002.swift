//
//  0002.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 4.05.25.
//


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}



class Solution0002 {
    var rest: Int = 0

    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {

        if l1 == nil, l2 == nil {
            return rest == 1 ? ListNode(1) : nil
        }

        var sum = (l1?.val ?? 0) + (l2?.val ?? 0) + rest

        let isRest = (sum - 10) >= 0

        var node: ListNode?

        if isRest {
            node = ListNode(sum - 10)
            rest = 1
        } else {
            node = ListNode(sum)
            rest = 0
        }
        node?.next = addTwoNumbers(l1?.next, l2?.next)
        return node
    }
}
