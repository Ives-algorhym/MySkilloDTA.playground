// ============================================================
// CATEGORY: Pair & Window Problems — Brute Force
// ============================================================


// ============================================================
// PROBLEM 1: Two Sum
// LEVEL: Easy
// TIME: O(n²) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Try every possible pair (i, j) where j > i.
// If their sum equals the target, return immediately.

// CONSTRAINTS: exactly one solution exists
//              cannot use the same element twice
// EDGE CASES: negative numbers, target is negative

func twoSum(_ nums: [Int], _ target: Int) -> (Int, Int)? {
    // time: O(n²) — every pair compared
    // space: O(1) — no extra allocation
    // INVARIANT: no valid pair found among elements 0..<i so far
    for i in 0..<nums.count {
        for j in i + 1..<nums.count {
            // time: O(1) — single addition and comparison
            if nums[i] + nums[j] == target { return (i, j) }
        }
    }
    return nil
}

// TEST CASES:
// twoSum([2, 7, 11, 15], 9)  → (0, 1)
// twoSum([3, 2, 4], 6)       → (1, 2)
// twoSum([-1, -2, -3], -5)   → (1, 2)


// ============================================================
// PROBLEM 2: Count Pairs That Sum to Target
// LEVEL: Easy
// TIME: O(n²) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Try every pair (i, j) where j > i.
// Increment counter each time the pair sums to target.

// CONSTRAINTS: none
// EDGE CASES: no valid pairs (returns 0), duplicate values

func countPairs(_ nums: [Int], _ target: Int) -> Int {
    // time: O(1) — single integer
    // space: O(1) — no allocation
    var count = 0

    // time: O(n²) — every pair checked
    // space: O(1) — no allocation per iteration
    // INVARIANT: count holds number of valid pairs found so far
    for i in 0..<nums.count {
        for j in i + 1..<nums.count {
            // time: O(1) — single addition and comparison
            if nums[i] + nums[j] == target { count += 1 }
        }
    }
    return count
}

// TEST CASES:
// countPairs([1, 5, 3, 3, 4], 6) → 3  (1+5, 3+3, 2+4)
// countPairs([1, 2, 3], 10)       → 0


// ============================================================
// PROBLEM 3: Max Pair Sum
// LEVEL: Easy
// TIME: O(n) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Walk through every adjacent pair (i, i+1).
// Track the maximum sum seen.
// Stop at count-2 to safely access i+1.

// CONSTRAINTS: array has at least 2 elements
// EDGE CASES: all negative numbers

func maxPairSum(_ nums: [Int]) -> Int {
    // time: O(1) — first pair is initial champion
    // space: O(1) — single integer
    var maxSum = nums[0] + nums[1]

    // time: O(n) — visits every adjacent pair
    // space: O(1) — only sum used, no extra allocation
    // INVARIANT: maxSum holds the largest adjacent pair sum seen so far
    for i in 0..<nums.count - 1 {
        // time: O(1) — single addition and comparison
        let sum = nums[i] + nums[i + 1]
        if sum > maxSum { maxSum = sum }
    }
    return maxSum
}

// TEST CASES:
// maxPairSum([1, 4, 2, 9, 3]) → 11  (2+9)
// maxPairSum([-1, -2, -3])     → -3  (-1+-2)


// ============================================================
// PROBLEM 4: Rotate Left (Brute Force)
// LEVEL: Medium
// TIME: O(n × d) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Rotate one step at a time, d times.
// One step = save first element, shift everything left, place saved at end.

// CONSTRAINTS: 0 ≤ d < array.count
// EDGE CASES: d = 0 (no rotation), d = count-1

func rotLeftBrute(_ a: [Int], _ d: Int) -> [Int] {
    // time: O(n) — copies all n elements
    // space: O(n) — full copy of input
    var result = a

    // time: O(d) outer iterations
    // INVARIANT: after each iteration, one left rotation has been applied
    for _ in 0..<d {
        // time: O(1) — save first element
        // space: O(1) — single integer
        let first = result[0]

        // time: O(n) — shifts every element one position left
        // space: O(1) — in-place, no extra allocation
        // INVARIANT: after inner loop, elements 0..<n-1 are shifted left by 1
        for i in 0..<result.count - 1 {
            result[i] = result[i + 1]
        }

        // time: O(1) — place saved element at end
        // space: O(1) — no allocation
        result[result.count - 1] = first
    }
    return result
}

// ─────────────────────────────────────────
// SOLUTION 2 — Optimal O(n) time O(n) space
// ─────────────────────────────────────────

// MENTAL MODEL:
// Elements from index d to end come first, then elements from 0 to d-1.
// Build result in one pass — no need to rotate step by step.

func rotLeft(_ a: [Int], _ d: Int) -> [Int] {
    // time: O(n) — two loops total visit all n elements once
    // space: O(n) — result array of size n
    var result: [Int] = []

    // time: O(n-d) — append elements from d to end
    for i in d..<a.count {
        result.append(a[i])
    }

    // time: O(d) — append elements from 0 to d-1
    for i in 0..<d {
        result.append(a[i])
    }

    return result
}

// TEST CASES:
// rotLeft([1, 2, 3, 4, 5], 2)  → [3, 4, 5, 1, 2]
// rotLeft([1, 2, 3, 4, 5], 0)  → [1, 2, 3, 4, 5]
// rotLeftBrute([1, 2, 3, 4, 5], 2) → [3, 4, 5, 1, 2]


// ============================================================
// PROBLEM 5: Longest Substring Without Repeating Characters
// LEVEL: Hard
// TIME: O(n³) brute force → O(n) optimal (sliding window)
// ============================================================

// DESCRIPTION:
// Given a string, find the length of the longest contiguous substring
// where no character appears more than once.

// Input:  "abcabcbb" → 3   ("abc")
// Input:  "bbbbb"    → 1   ("b" — all repeats, best is single char)
// Input:  "pwwkew"   → 3   ("wke")
// Input:  "a"        → 1   (single character)

// MENTAL MODEL (brute force):
// Try every possible substring using two pointers i and j.
// For each substring, check if it contains any duplicate characters.
// Track the length of the longest valid substring found.

// CONSTRAINTS: string has at least 1 character
// EDGE CASES: all same characters (answer is 1), all unique (answer is n)

func lengthOfLongestSubstringBrute(_ s: String) -> Int {
    // time: O(n) — converts string to character array
    // space: O(n) — array of n characters
    let chars = Array(s)

    // time: O(1) | space: O(1)
    var best = 0

    // outer loop: try every starting index i
    // time: O(n) outer iterations
    // INVARIANT: best holds the longest valid substring starting before i
    for i in 0..<chars.count {

        // inner loop: expand window rightward from i to j
        // time: O(n) per outer iteration → O(n²) pairs
        // INVARIANT: window = chars[i...j]
        for j in i..<chars.count {

            // check current window chars[i...j] for duplicates
            // time: O(n) — scan window for each pair → O(n³) total
            // space: O(n) — seen array grows with window size
            var seen: [Character] = []
            var hasDuplicate = false

            for k in i...j {
                if seen.contains(chars[k]) {
                    hasDuplicate = true
                    break
                }
                seen.append(chars[k])
            }

            // update best if window is valid and longer than current best
            if !hasDuplicate {
                let length = j - i + 1
                best = max(best, length)
            }
        }
    }
    return best
}

// TEST CASES:
// lengthOfLongestSubstringBrute("abcabcbb") → 3
// lengthOfLongestSubstring("abcabcbb")      → 3
// lengthOfLongestSubstring("bbbbb")         → 1
// lengthOfLongestSubstring("pwwkew")        → 3
// lengthOfLongestSubstring("a")             → 1
