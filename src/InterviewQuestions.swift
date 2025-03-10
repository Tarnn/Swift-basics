// InterviewQuestions.swift
// Common coding interview questions and solutions in Swift

import Foundation

// MARK: - String Manipulation

// 1. Reverse a string
func reverseString(_ s: String) -> String {
    return String(s.reversed())
}

// 2. Check if a string is a palindrome
func isPalindrome(_ s: String) -> Bool {
    let cleanString = s.lowercased().filter { $0.isLetter || $0.isNumber }
    return cleanString == String(cleanString.reversed())
}

// 3. Find the first non-repeating character
func firstNonRepeatingCharacter(_ s: String) -> Character? {
    var charCount: [Character: Int] = [:]
    
    // Count occurrences of each character
    for char in s {
        charCount[char, default: 0] += 1
    }
    
    // Find the first character with count 1
    for char in s {
        if charCount[char] == 1 {
            return char
        }
    }
    
    return nil
}

// 4. Check if two strings are anagrams
func areAnagrams(_ s1: String, _ s2: String) -> Bool {
    return s1.sorted() == s2.sorted()
}

// MARK: - Array Problems

// 1. Find the maximum subarray sum (Kadane's algorithm)
func maxSubarraySum(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    
    var currentSum = nums[0]
    var maxSum = nums[0]
    
    for i in 1..<nums.count {
        currentSum = max(nums[i], currentSum + nums[i])
        maxSum = max(maxSum, currentSum)
    }
    
    return maxSum
}

// 2. Two Sum - Find two numbers that add up to a target
func twoSum(_ nums: [Int], _ target: Int) -> [Int]? {
    var numDict: [Int: Int] = [:] // value: index
    
    for (i, num) in nums.enumerated() {
        let complement = target - num
        
        if let complementIndex = numDict[complement] {
            return [complementIndex, i]
        }
        
        numDict[num] = i
    }
    
    return nil
}

// 3. Merge two sorted arrays
func mergeSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var result: [Int] = []
    var i = 0, j = 0
    
    while i < nums1.count && j < nums2.count {
        if nums1[i] < nums2[j] {
            result.append(nums1[i])
            i += 1
        } else {
            result.append(nums2[j])
            j += 1
        }
    }
    
    // Add remaining elements
    while i < nums1.count {
        result.append(nums1[i])
        i += 1
    }
    
    while j < nums2.count {
        result.append(nums2[j])
        j += 1
    }
    
    return result
}

// 4. Find the missing number in an array
func findMissingNumber(_ nums: [Int], _ n: Int) -> Int {
    let expectedSum = n * (n + 1) / 2
    let actualSum = nums.reduce(0, +)
    return expectedSum - actualSum
}

// MARK: - Linked List Problems

// Definition for a singly linked list node
class ListNode {
    var val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// 1. Reverse a linked list
func reverseLinkedList(_ head: ListNode?) -> ListNode? {
    var prev: ListNode? = nil
    var current = head
    
    while current != nil {
        let next = current?.next
        current?.next = prev
        prev = current
        current = next
    }
    
    return prev
}

// 2. Detect a cycle in a linked list (Floyd's Tortoise and Hare algorithm)
func hasCycle(_ head: ListNode?) -> Bool {
    var slow = head
    var fast = head
    
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        
        if slow === fast {
            return true
        }
    }
    
    return false
}

// 3. Find the middle of a linked list
func findMiddleNode(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head
    
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    
    return slow
}

// 4. Merge two sorted linked lists
func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    // Create a dummy head
    let dummy = ListNode(0)
    var current: ListNode? = dummy
    
    var list1 = l1
    var list2 = l2
    
    while list1 != nil && list2 != nil {
        if list1!.val < list2!.val {
            current?.next = list1
            list1 = list1?.next
        } else {
            current?.next = list2
            list2 = list2?.next
        }
        current = current?.next
    }
    
    // Attach remaining nodes
    if list1 != nil {
        current?.next = list1
    } else if list2 != nil {
        current?.next = list2
    }
    
    return dummy.next
}

// MARK: - Tree Problems

// Definition for a binary tree node
class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// 1. Binary tree inorder traversal
func inorderTraversal(_ root: TreeNode?) -> [Int] {
    var result: [Int] = []
    
    func inorder(_ node: TreeNode?) {
        guard let node = node else { return }
        
        inorder(node.left)
        result.append(node.val)
        inorder(node.right)
    }
    
    inorder(root)
    return result
}

// 2. Check if a binary tree is balanced
func isBalanced(_ root: TreeNode?) -> Bool {
    func height(_ node: TreeNode?) -> Int {
        guard let node = node else { return 0 }
        
        let leftHeight = height(node.left)
        if leftHeight == -1 { return -1 }
        
        let rightHeight = height(node.right)
        if rightHeight == -1 { return -1 }
        
        if abs(leftHeight - rightHeight) > 1 {
            return -1
        }
        
        return max(leftHeight, rightHeight) + 1
    }
    
    return height(root) != -1
}

// 3. Find the maximum depth of a binary tree
func maxDepth(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    
    let leftDepth = maxDepth(root.left)
    let rightDepth = maxDepth(root.right)
    
    return max(leftDepth, rightDepth) + 1
}

// 4. Check if a binary tree is a valid BST
func isValidBST(_ root: TreeNode?) -> Bool {
    func isValid(_ node: TreeNode?, _ min: Int?, _ max: Int?) -> Bool {
        guard let node = node else { return true }
        
        if let min = min, node.val <= min {
            return false
        }
        
        if let max = max, node.val >= max {
            return false
        }
        
        return isValid(node.left, min, node.val) && isValid(node.right, node.val, max)
    }
    
    return isValid(root, nil, nil)
}

// MARK: - Dynamic Programming

// 1. Fibonacci sequence
func fibonacci(_ n: Int) -> Int {
    if n <= 1 {
        return n
    }
    
    var dp = [0, 1]
    
    for i in 2...n {
        dp.append(dp[i-1] + dp[i-2])
    }
    
    return dp[n]
}

// 2. Climbing stairs - how many ways to climb n stairs (1 or 2 steps at a time)
func climbStairs(_ n: Int) -> Int {
    if n <= 2 {
        return n
    }
    
    var dp = [0, 1, 2]
    
    for i in 3...n {
        dp.append(dp[i-1] + dp[i-2])
    }
    
    return dp[n]
}

// 3. Longest increasing subsequence
func lengthOfLIS(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    
    var dp = Array(repeating: 1, count: nums.count)
    
    for i in 1..<nums.count {
        for j in 0..<i {
            if nums[i] > nums[j] {
                dp[i] = max(dp[i], dp[j] + 1)
            }
        }
    }
    
    return dp.max() ?? 1
}

// 4. Coin change - minimum number of coins to make a certain amount
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    var dp = Array(repeating: amount + 1, count: amount + 1)
    dp[0] = 0
    
    for coin in coins {
        for i in coin...amount {
            dp[i] = min(dp[i], dp[i - coin] + 1)
        }
    }
    
    return dp[amount] > amount ? -1 : dp[amount]
}

// MARK: - Sorting and Searching

// 1. Implement quicksort
func quickSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }
    
    let pivot = array[array.count / 2]
    let less = array.filter { $0 < pivot }
    let equal = array.filter { $0 == pivot }
    let greater = array.filter { $0 > pivot }
    
    return quickSort(less) + equal + quickSort(greater)
}

// 2. Implement binary search
func binarySearch(_ nums: [Int], _ target: Int) -> Int {
    var left = 0
    var right = nums.count - 1
    
    while left <= right {
        let mid = left + (right - left) / 2
        
        if nums[mid] == target {
            return mid
        } else if nums[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    
    return -1
}

// 3. Find the kth largest element in an array
func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    let sortedNums = nums.sorted(by: >)
    return sortedNums[k - 1]
}

// 4. Search in a rotated sorted array
func searchInRotatedArray(_ nums: [Int], _ target: Int) -> Int {
    var left = 0
    var right = nums.count - 1
    
    while left <= right {
        let mid = left + (right - left) / 2
        
        if nums[mid] == target {
            return mid
        }
        
        // Check if left half is sorted
        if nums[left] <= nums[mid] {
            // Check if target is in left half
            if nums[left] <= target && target < nums[mid] {
                right = mid - 1
            } else {
                left = mid + 1
            }
        } else { // Right half is sorted
            // Check if target is in right half
            if nums[mid] < target && target <= nums[right] {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }
    
    return -1
}

// MARK: - Graph Problems

// 1. Breadth-first search (BFS)
func bfs(graph: [[Int]], start: Int) -> [Int] {
    var visited = Array(repeating: false, count: graph.count)
    var queue = [start]
    var result: [Int] = []
    
    visited[start] = true
    
    while !queue.isEmpty {
        let node = queue.removeFirst()
        result.append(node)
        
        for neighbor in graph[node] {
            if !visited[neighbor] {
                visited[neighbor] = true
                queue.append(neighbor)
            }
        }
    }
    
    return result
}

// 2. Depth-first search (DFS)
func dfs(graph: [[Int]], start: Int) -> [Int] {
    var visited = Array(repeating: false, count: graph.count)
    var result: [Int] = []
    
    func dfsHelper(_ node: Int) {
        visited[node] = true
        result.append(node)
        
        for neighbor in graph[node] {
            if !visited[neighbor] {
                dfsHelper(neighbor)
            }
        }
    }
    
    dfsHelper(start)
    return result
}

// 3. Detect a cycle in a directed graph
func hasCycle(graph: [[Int]]) -> Bool {
    enum State {
        case unvisited, visiting, visited
    }
    
    var states = Array(repeating: State.unvisited, count: graph.count)
    
    func dfsCheckCycle(_ node: Int) -> Bool {
        states[node] = .visiting
        
        for neighbor in graph[node] {
            if states[neighbor] == .visiting {
                return true
            }
            
            if states[neighbor] == .unvisited && dfsCheckCycle(neighbor) {
                return true
            }
        }
        
        states[node] = .visited
        return false
    }
    
    for node in 0..<graph.count {
        if states[node] == .unvisited && dfsCheckCycle(node) {
            return true
        }
    }
    
    return false
}

// 4. Find the shortest path (Dijkstra's algorithm)
func dijkstra(graph: [[(node: Int, weight: Int)]], start: Int) -> [Int] {
    let n = graph.count
    var distances = Array(repeating: Int.max, count: n)
    var visited = Array(repeating: false, count: n)
    
    distances[start] = 0
    
    for _ in 0..<n {
        // Find the unvisited node with the smallest distance
        var minDistance = Int.max
        var minNode = -1
        
        for node in 0..<n {
            if !visited[node] && distances[node] < minDistance {
                minDistance = distances[node]
                minNode = node
            }
        }
        
        if minNode == -1 {
            break
        }
        
        visited[minNode] = true
        
        // Update distances to neighbors
        for (neighbor, weight) in graph[minNode] {
            if !visited[neighbor] {
                let newDistance = distances[minNode] + weight
                if newDistance < distances[neighbor] {
                    distances[neighbor] = newDistance
                }
            }
        }
    }
    
    return distances
}

// MARK: - Main function to demonstrate usage

func main() {
    print("Swift Interview Questions")
    print("-----------------------")
    
    // String manipulation examples
    print("\n--- String Manipulation ---")
    print("Reverse 'Hello': \(reverseString("Hello"))")
    print("Is 'racecar' a palindrome? \(isPalindrome("racecar"))")
    print("Is 'hello' a palindrome? \(isPalindrome("hello"))")
    print("First non-repeating character in 'leetcode': \(String(describing: firstNonRepeatingCharacter("leetcode")))")
    print("Are 'listen' and 'silent' anagrams? \(areAnagrams("listen", "silent"))")
    
    // Array examples
    print("\n--- Array Problems ---")
    print("Max subarray sum of [-2, 1, -3, 4, -1, 2, 1, -5, 4]: \(maxSubarraySum([-2, 1, -3, 4, -1, 2, 1, -5, 4]))")
    print("Two sum indices for [2, 7, 11, 15] with target 9: \(String(describing: twoSum([2, 7, 11, 15], 9)))")
    print("Merged arrays [1, 3, 5] and [2, 4, 6]: \(mergeSortedArrays([1, 3, 5], [2, 4, 6]))")
    print("Missing number in [0, 1, 3, 4, 5] (n=5): \(findMissingNumber([0, 1, 3, 4, 5], 5))")
    
    // Dynamic programming examples
    print("\n--- Dynamic Programming ---")
    print("Fibonacci(10): \(fibonacci(10))")
    print("Ways to climb 5 stairs: \(climbStairs(5))")
    print("Length of longest increasing subsequence in [10, 9, 2, 5, 3, 7, 101, 18]: \(lengthOfLIS([10, 9, 2, 5, 3, 7, 101, 18]))")
    print("Minimum coins to make 11 with [1, 2, 5]: \(coinChange([1, 2, 5], 11))")
    
    // Sorting and searching examples
    print("\n--- Sorting and Searching ---")
    print("Quicksort [3, 1, 4, 1, 5, 9, 2, 6]: \(quickSort([3, 1, 4, 1, 5, 9, 2, 6]))")
    print("Binary search for 7 in [1, 3, 5, 7, 9]: \(binarySearch([1, 3, 5, 7, 9], 7))")
    print("3rd largest element in [3, 2, 1, 5, 6, 4]: \(findKthLargest([3, 2, 1, 5, 6, 4], 3))")
    print("Search for 0 in rotated array [4, 5, 6, 7, 0, 1, 2]: \(searchInRotatedArray([4, 5, 6, 7, 0, 1, 2], 0))")
}

// Call the main function
main() 