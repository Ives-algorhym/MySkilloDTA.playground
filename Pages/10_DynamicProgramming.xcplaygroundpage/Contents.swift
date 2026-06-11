// ============================================================
// CATEGORY: Dynamic Programming — Build answer from sub-answers
// KEY INSIGHT: instead of recomputing from scratch each time,
// store results of subproblems and reuse them.
// ============================================================


// ============================================================
// PROBLEM 1: Longest Increasing Subsequence (length)
// LEVEL: Hard
// Find the length of the longest subsequence whose values are strictly increasing.
// A subsequence keeps the original order but can skip elements.
// TIME: O(n²) | SPACE: O(n)
// ============================================================

// MENTAL MODEL — dynamic programming:
// lengths[i] = length of the longest increasing subsequence ending at index i.
// For each i, look back at every j < i:
//   if nums[j] < nums[i] → i can extend the subsequence ending at j
//   update lengths[i] = max(lengths[i], lengths[j] + 1)
// Answer = max value in lengths[].
//
// Key question at each step:
// "If I already know the LIS ending at every j before me,
//  what is the LIS ending at me?"

// CONSTRAINTS: array has at least 1 element
// EDGE CASES: all same values (LIS = 1), already sorted (LIS = n)

func longestIncreasing(_ nums: [Int]) -> Int {

    // time: O(n) — fills array with 1s
    // space: O(n) — one entry per element, each starts at 1 (just itself)
    // INVARIANT: lengths[i] >= 1 always (every element is a subsequence of length 1)
    var lengths = Array(repeating: 1, count: nums.count)

    // time: O(n²) — outer × inner loops
    // space: O(1) — no extra allocation per iteration
    // INVARIANT: after processing index i,
    // lengths[i] holds the longest increasing subsequence ending at i
    for i in 0..<nums.count {

        // look back at every j before i
        // time: O(n) per outer iteration → O(n²) total
        // space: O(1)
        for j in 0..<i {

            // can i extend the subsequence that ends at j?
            // time: O(1) — single comparison
            if nums[j] < nums[i] {

                // lengths[j] + 1 = extend j's subsequence by adding i
                // only update if it gives a longer subsequence than current best
                // time: O(1) — comparison and assignment
                if lengths[j] + 1 > lengths[i] {
                    lengths[i] = lengths[j] + 1
                }
            }
        }
        // INVARIANT: lengths[i] = longest increasing subsequence ending exactly at i
    }

    // scan lengths[] to find the global best
    // time: O(n) — one pass through lengths array
    // space: O(1) — single integer
    // INVARIANT: best holds the longest subsequence length seen so far
    var best = 0
    for length in lengths {
        if length > best { best = length }
    }
    // INVARIANT: best = length of the longest increasing subsequence in nums

    return best
}

// TRACE with [2, 1, 5, 3, 6]:
// i=0: lengths = [1, 1, 1, 1, 1]   (2 alone)
// i=1: no j < 1 with nums[j] < 1   lengths = [1, 1, 1, 1, 1]
// i=2: j=0: 2<5 → lengths[2]=2    lengths = [1, 1, 2, 1, 1]
//       j=1: 1<5 → lengths[2]=2    (no change, same length)
// i=3: j=0: 2<3 → lengths[3]=2    lengths = [1, 1, 2, 2, 1]
//       j=1: 1<3 → lengths[3]=2    (no change)
// i=4: j=0: 2<6 → lengths[4]=2
//       j=2: 5<6 → lengths[4]=3    lengths = [1, 1, 2, 2, 3]
// best = 3  (subsequence: 2, 5, 6 or 1, 5, 6 or 1, 3, 6)

// TEST CASES:
// longestIncreasing([2, 1, 5, 3, 6])       → 3
// longestIncreasing([10, 9, 2, 5, 3, 7])   → 3  (2, 3, 7)
// longestIncreasing([1, 2, 3, 4, 5])       → 5  (entire array)
// longestIncreasing([5, 4, 3, 2, 1])       → 1  (no increasing pair)
