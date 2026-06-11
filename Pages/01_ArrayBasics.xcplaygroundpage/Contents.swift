// ============================================================
// CATEGORY: Array Basics — Single Loop Problems
// All solutions: Brute Force
// ============================================================


// ============================================================
// PROBLEM 1: Find Max
// LEVEL: Easy
// TIME: O(n) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Walk through the array keeping track of the largest seen so far.
// Each element challenges the current champion.

// CONSTRAINTS: array has at least 1 element
// EDGE CASES: single element, all same values, negative numbers

func findMax(_ nums: [Int]) -> Int {
    // time: O(1) — first element is initial champion
    // space: O(1) — single integer
    var max = nums[0]

    // time: O(n) — visits every element once
    // space: O(1) — no allocation per iteration
    // INVARIANT: max holds the largest value seen so far
    for num in nums {
        if num > max { max = num }
    }
    return max
}

// TEST CASES:
// findMax([3, 1, 7, 2, 9]) → 9
// findMax([-5, -1, -3])    → -1
// findMax([42])             → 42


// ============================================================
// PROBLEM 2: Reverse Array
// LEVEL: Easy
// TIME: O(n) | SPACE: O(n)
// ============================================================

// MENTAL MODEL:
// Start from the last index, walk backward, append each element to result.
// Stop when i goes below 0.

// CONSTRAINTS: array has at least 1 element
// EDGE CASES: single element

func reverseArray(_ nums: [Int]) -> [Int] {
    // time: O(1) — empty array creation
    // space: O(n) — result holds all n elements
    var result: [Int] = []

    // time: O(n) — visits every element once in reverse
    // space: O(1) — single integer per iteration
    // INVARIANT: result contains the reversed elements from index n-1 down to i+1
    var i = nums.count - 1
    while i >= 0 {
        result.append(nums[i])
        i -= 1
    }
    return result
}

// TEST CASES:
// reverseArray([1, 2, 3, 4]) → [4, 3, 2, 1]
// reverseArray([42])          → [42]


// ============================================================
// PROBLEM 3: Count Occurrences
// LEVEL: Easy
// TIME: O(n) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Walk through every element, increment counter when it matches target.

// CONSTRAINTS: none
// EDGE CASES: target not present (returns 0)

func countOccurrences(_ nums: [Int], _ target: Int) -> Int {
    // time: O(1) — single integer
    // space: O(1) — no allocation
    var count = 0

    // time: O(n) — visits every element
    // space: O(1) — no allocation per iteration
    // INVARIANT: count holds the number of times target appeared so far
    for num in nums {
        if num == target { count += 1 }
    }
    return count
}

// TEST CASES:
// countOccurrences([1, 2, 2, 3, 2], 2) → 3
// countOccurrences([1, 2, 3], 9)        → 0


// ============================================================
// PROBLEM 4: Has Duplicates
// LEVEL: Easy
// TIME: O(n²) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Compare every pair (i, j) where j > i.
// If any pair has equal values, return true immediately.

// CONSTRAINTS: none
// EDGE CASES: single element (no duplicates possible), all same values

func hasDuplicates(_ nums: [Int]) -> Bool {
    // time: O(n²) — every pair compared
    // space: O(1) — no extra allocation
    // INVARIANT: no duplicate found among elements 0..<i so far
    for i in 0..<nums.count {
        for j in i + 1..<nums.count {
            // time: O(1) — single comparison
            if nums[i] == nums[j] { return true }
        }
    }
    return false
}

// TEST CASES:
// hasDuplicates([1, 2, 3, 1]) → true
// hasDuplicates([1, 2, 3, 4]) → false


// ============================================================
// PROBLEM 5: Is Sorted
// LEVEL: Easy
// TIME: O(n) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Compare each element with its right neighbor.
// If any element is greater than the next, it is not sorted.
// Stop at count-2 to safely access i+1.

// CONSTRAINTS: array has at least 2 elements
// EDGE CASES: single element (trivially sorted)

func isSorted(_ nums: [Int]) -> Bool {
    // time: O(n) — visits every adjacent pair
    // space: O(1) — no allocation
    // INVARIANT: all elements 0..<i are in ascending order
    for i in 0..<nums.count - 1 {
        if nums[i] > nums[i + 1] { return false }
    }
    return true
}

// TEST CASES:
// isSorted([1, 2, 3, 4]) → true
// isSorted([1, 3, 2, 4]) → false


// ============================================================
// PROBLEM 6: Second Largest
// LEVEL: Medium
// TIME: O(n) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Keep track of first and second place simultaneously.
// When a new champion is found, old first becomes second.
// When a value beats second but not first, update second.

// CONSTRAINTS: array has at least 2 distinct values
// EDGE CASES: duplicates of the max value

func secondLargest(_ nums: [Int]) -> Int {
    // time: O(1) — two integer assignments
    // space: O(1) — two integers
    var first = Int.min
    var second = Int.min

    // time: O(n) — single pass
    // space: O(1) — no allocation
    // INVARIANT: first = largest seen, second = second largest seen
    for num in nums {
        if num > first {
            second = first   // old champion drops to second
            first = num      // new champion
        } else if num > second && num != first {
            second = num     // beats second but not first
        }
    }
    return second
}

// TEST CASES:
// secondLargest([3, 1, 7, 2, 9]) → 7
// secondLargest([5, 5, 3])        → 3


// ============================================================
// PROBLEM 7: Most Frequent Element
// LEVEL: Medium
// TIME: O(n²) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// For each element, count how many times it appears (inner loop).
// Keep track of the element with the highest count seen so far.

// CONSTRAINTS: array has at least 1 element
// EDGE CASES: tie in frequency (returns first one found)

func mostFrequent(_ nums: [Int]) -> Int {
    // time: O(1) — two integer assignments
    // space: O(1) — two integers
    var maxCount = 0
    var result = nums[0]

    // time: O(n²) — for each element, full scan to count occurrences
    // space: O(1) — only count used, no extra allocation
    // INVARIANT: result holds the most frequent element seen among nums[0..<i]
    for i in 0..<nums.count {
        var count = 0
        for j in 0..<nums.count {
            // time: O(1) — single comparison
            if nums[j] == nums[i] { count += 1 }
        }
        if count > maxCount {
            maxCount = count
            result = nums[i]
        }
    }
    return result
}

// TEST CASES:
// mostFrequent([1, 3, 3, 2, 3, 1]) → 3
// mostFrequent([1, 1, 2, 2, 2])     → 2


// ============================================================
// PROBLEM 8: Find Missing Number
// LEVEL: Medium
// TIME: O(n²) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Check each number from 1 to n.
// For each candidate, scan the whole array.
// If not found anywhere, that is the missing number.
// n is always nums.count + 1 — no need to pass it as parameter.

// CONSTRAINTS: exactly one number missing, values are 1..n, no duplicates
// EDGE CASES: missing first (1), missing last (n)

func findMissing(_ nums: [Int]) -> Int {
    // time: O(1) — single arithmetic
    // space: O(1) — single integer
    let n = nums.count + 1   // nums has n-1 elements, range is 1...n

    // time: O(n²) — outer loop n times, inner loop n times each
    // space: O(1) — only found used, no extra allocation
    // INVARIANT: all numbers 1..<i have been confirmed present in nums
    for i in 1...n {
        var found = false

        // time: O(n) — scan entire array for i
        // space: O(1) — single boolean
        for num in nums {
            if num == i { found = true }
        }
        // INVARIANT: found = true if i exists in nums
        if !found { return i }
    }
    return -1
}

// TEST CASES:
// findMissing([1, 2, 4, 5]) → 3
// findMissing([2, 3, 4, 5]) → 1
// findMissing([1, 2, 3, 4]) → 5
