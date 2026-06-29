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
    // var i = nums.count - 1
    // while i >= 0 {
    //   result.append(nums[i])
    //   i -= 1
    // }

    for i in stride(from: nums.count - 1, through: 0, by: -1) {
        result.append(nums[i])
    }
    return result
}

func reveredArrayPointer(_ nums: inout[Int]){
    var left = 0
    var right = nums.count - 1

    while left < right {

     //var temp = nums[left]
     //left = nums[right]
     //right = temp
        nums.swapAt(left, right)

        left += 1
        right -= 1
    }
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

func hasDuplicatesSet(_ nums: [Int]) -> Bool {
    var uniques =  Set<Int>()
    for n in nums {
        if uniques.contains(n) {
            return true
        }

        uniques.insert(n)
    }
    return false
}

// TEST CASES:
// hasDuplicatesSet([1, 2, 3, 1]) //→ true
// hasDuplicatesSet([1, 2, 3, 4]) //→ false


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

func mostFrequentDic(_ nums: [Int]) -> Int {
    // time: O(n) - if nums grows take more time to build proportionally
    // space: O(n) - memory allotion grows proportianaly
    var freq: [Int: Int] = [:]
    var result = nums[0]
    var maxCount = 0

    for n in nums {
        freq[n, default: 0] += 1
    }

    for (v, c) in freq {
        if c > maxCount {
            maxCount = c
            result = v
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


// ============================================================
// PROBLEM 9: Max Subarray Sum
// LEVEL: Hard
// TIME: O(n²) brute force → O(n) optimal (Kadane's)
// ============================================================

// DESCRIPTION
// Given an array of integers (positive and negative),
// find the contiguous subarray that has the largest sum and return that sum.

//Input: [-2, 1, -3, 4, -1, 2, 1, -5, 4]
//Output: 6
//Why: The subarray [4, -1, 2, 1] sums to 6 — no other contiguous slice adds up to more.
//
//⸻
//
//Input: [-1, -2, -3]
//Output: -1
//Why: All numbers are negative, so the best you can do is take the least negative one.
//
//⸻
//
//Input: [1]
//Output: 1
//Why: Single element, only one choice.

// MENTAL MODEL (brute force):
// Try every possible subarray starting at i.
// Expand it to the right with j, tracking the running sum.
// Update best whenever current sum beats it.

// CONSTRAINTS: array has at least 1 element
// EDGE CASES: all negative numbers (answer is least negative), single element

func maxSubarrayBrute(_ nums: [Int]) -> Int {

    // first element = smallest valid subarray — not 0, handles all-negative arrays
    // time: O(1) | space: O(1)
    var best = nums[0]

    // outer loop: try every possible starting index i
    // time: O(n) outer iterations
    // INVARIANT: best holds the largest subarray sum starting before index i
    for i in 0..<nums.count {

        // reset current sum for each new starting point
        // time: O(1) | space: O(1)
        var current = 0

        // inner loop: expand subarray rightward from i to j
        // time: O(n) per outer iteration → O(n²) total
        // INVARIANT: current holds the sum of nums[i...j]
        for j in i..<nums.count {

            // extend subarray by one element
            // time: O(1)
            current += nums[j]

            // update best if this subarray beats the previous champion
            // time: O(1)
            best = max(best, current)
        }
        // INVARIANT: best includes the largest sum of any subarray starting at i
    }
    return best
}


// ─────────────────────────────────────────
// SOLUTION 2 — Kadane's Algorithm O(n)
// ─────────────────────────────────────────

// MENTAL MODEL:
// At each element ask: extend the current subarray, or start fresh here?
// If current sum went negative, drop it — a negative prefix only hurts future sums.
// current = max(nums[i], current + nums[i])

func maxSubarray(_ nums: [Int]) -> Int {

    // both start at nums[0] — first element is a valid subarray on its own
    // time: O(1) | space: O(1)
    var best = nums[0]
    var current = nums[0]

    // single pass starting at index 1 — index 0 already seeded above
    // time: O(n) | space: O(1)
    // INVARIANT: current = largest subarray sum ending exactly at i
    //            best    = largest subarray sum seen across all i so far
    for i in 1..<nums.count {

        // extend or restart — whichever gives more
        // if current went negative, nums[i] alone is always better
        // time: O(1)
        current = max(nums[i], current + nums[i])

        // update global best
        // time: O(1)
        best = max(best, current)
    }
    // INVARIANT: best = largest contiguous subarray sum in nums

    return best
}

// TEST CASES:
// maxSubarrayBrute([-2, 1, -3, 4, -1, 2, 1, -5, 4]) → 6
// maxSubarray([-2, 1, -3, 4, -1, 2, 1, -5, 4])      → 6
// maxSubarray([-1, -2, -3])                           → -1
// maxSubarray([1])                                     → 1
