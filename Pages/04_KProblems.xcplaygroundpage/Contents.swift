// ============================================================
// CATEGORY: K-Problems — Repeated Selection Pattern
// All solutions: Brute Force O(n × k)
// ============================================================

// GENERAL PATTERN — repeated selection:
// 1. copy original so we can remove from it
// 2. outer loop runs k times — one result per round
// 3. inner loop finds the best candidate (core operation changes per problem)
// 4. append best to result, remove from copy so it won't be picked again

// The only thing that changes between problems is the CORE OPERATION:
// kLargest      → find max value
// kthSmallest   → find min value
// topKFrequent  → find most frequent
// closestK      → find closest to target


// ============================================================
// PROBLEM 1: K Largest Elements
// LEVEL: Medium
// Return the k largest values in descending order.
// TIME: O(n × k) | SPACE: O(n + k)
// ============================================================

// MENTAL MODEL:
// Repeat k times: find the largest element, grab it, remove it.
// Each round the copy shrinks by 1.

// CONSTRAINTS: k ≤ array.count
// EDGE CASES: k = 1 (just the max), k = count (sorted descending)

func kLargest(_ num: [Int], _ k: Int) -> [Int] {

    // time: O(1) — single comparison regardless of input size
    // space: O(1) — no extra memory allocated
    guard num.count >= k else { return [] }

    // time: O(1) — empty array creation
    // space: O(k) — grows to hold k elements by the end
    var result: [Int] = []

    // time: O(n) — copies all n elements
    // space: O(n) — extra array of size n allocated here
    var copy = num

    // time: runs exactly k times → O(k) outer iterations
    // space: O(1) — no extra memory per iteration
    // INVARIANT: at the start of each iteration,
    // result contains the i largest elements found so far
    // and copy no longer contains those elements
    for _ in 0..<k {

        // time: O(1) — single assignment
        // space: O(1) — single integer
        // INVARIANT: maxIndex always points to the largest element seen so far
        var maxIndex = 0

        // time: O(n) first round, shrinks by 1 each round → O(n×k) total
        // space: O(1) — only i and maxIndex used, no extra allocation
        for i in 1..<copy.count {   // start at 1 — index 0 is already champion
            // time: O(1) — single comparison
            // space: O(1) — no allocation
            if copy[i] > copy[maxIndex] {
                maxIndex = i        // new champion found
            }
        }
        // INVARIANT: after inner loop, maxIndex holds
        // the index of the largest remaining element in copy

        // time: O(1) — append to end
        // space: O(1) — one element added to result
        result.append(copy[maxIndex])

        // time: O(n) — shifts all elements after maxIndex left
        // space: O(1) — no extra allocation, modifies in place
        copy.remove(at: maxIndex)
    }
    // INVARIANT: result now contains exactly k elements,
    // sorted from largest to next largest

    return result
}

// TEST CASES:
// kLargest([3, 1, 7, 2, 9, 5], 3) → [9, 7, 5]
// kLargest([1, 2, 3], 1)           → [3]


// ============================================================
// PROBLEM 2: Kth Smallest Element
// LEVEL: Medium
// Return the element at position k if the array were sorted ascending (1-indexed).
// TIME: O(n × k) | SPACE: O(n)
// ============================================================

// MENTAL MODEL:
// Repeat k times: find the smallest element, grab it, remove it.
// After k rounds, the last element grabbed is at position k.

// CONSTRAINTS: k ≤ array.count, k is 1-indexed
// EDGE CASES: k = 1 (the minimum), k = count (the maximum)

func kthSmallest(_ nums: [Int], _ k: Int) -> Int {

    // time: O(n) — copies all n elements
    // space: O(n) — extra array of size n allocated here
    var copy = nums

    // time: O(1) — single assignment
    // space: O(1) — single integer
    var result = 0

    // time: runs exactly k times → O(k) outer iterations
    // space: O(1) — no extra memory per iteration
    // INVARIANT: at the start of each iteration,
    // the i smallest elements have been removed from copy
    for _ in 0..<k {

        // time: O(1) — single assignment
        // space: O(1) — single integer
        // INVARIANT: minIndex always points to the smallest element seen so far
        var minIndex = 0

        // time: O(n) first round, shrinks by 1 each round → O(n×k) total
        // space: O(1) — only i and minIndex used, no extra allocation
        for i in 1..<copy.count {   // start at 1 — index 0 is already champion
            // time: O(1) — single comparison
            // space: O(1) — no allocation
            if copy[i] < copy[minIndex] {
                minIndex = i        // new smallest found
            }
        }
        // INVARIANT: after inner loop, minIndex holds
        // the index of the smallest remaining element in copy

        // time: O(1) — single assignment
        // space: O(1) — no allocation
        result = copy[minIndex]

        // time: O(n) — shifts all elements after minIndex left
        // space: O(1) — no extra allocation, modifies in place
        copy.remove(at: minIndex)
    }
    // INVARIANT: result holds the kth smallest element

    return result
}

// TEST CASES:
// kthSmallest([3, 1, 7, 2, 9], 2) → 2   (1st=1, 2nd=2)
// kthSmallest([3, 1, 7, 2, 9], 1) → 1   (smallest)


// ============================================================
// PROBLEM 3: Top K Frequent Elements
// LEVEL: Medium
// Return the k values that appear most often.
// TIME: O(n × u + k × u) | SPACE: O(u + k)  where u = unique values
// ============================================================

// MENTAL MODEL:
// Phase 1 — build frequency table: walk the array, for each element
//           find its index in values[] and increment counts[].
//           If not found, add it as a new unique value.
// Phase 2 — repeated selection: pick the most frequent k times,
//           marking each picked element with Int.min so it won't be repicked.

// CONSTRAINTS: k ≤ number of unique values
// EDGE CASES: all elements the same, all elements unique

func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {

    // time: O(1) — empty array creation
    // space: O(u) — grows to hold u unique values (u ≤ n)
    var values: [Int] = []

    // time: O(1) — empty array creation
    // space: O(u) — one count per unique value
    var counts: [Int] = []

    // time: O(n × u) — for each of n elements, scan up to u unique values
    // space: O(1) — no extra allocation per iteration
    // INVARIANT: values[i] and counts[i] always stay in sync —
    // counts[i] is the frequency of values[i] seen so far
    for num in nums {

        // time: O(1) — single assignment
        // space: O(1) — single integer, -1 means not found yet
        var found = -1

        // time: O(u) — scan all unique values seen so far
        // space: O(1) — only i used, no extra allocation
        for i in 0..<values.count {
            // time: O(1) — single comparison
            if values[i] == num {
                found = i   // record index of matching value
            }
        }
        // INVARIANT: after inner loop, found = index of num in values,
        // or -1 if num has never been seen before

        if found == -1 {
            // time: O(1) — append to end of both arrays
            // space: O(1) — one element added to each array
            values.append(num)  // new unique value
            counts.append(1)    // seen once so far
        } else {
            // time: O(1) — single increment
            // space: O(1) — no allocation
            counts[found] += 1  // increment existing count
        }
    }

    // time: O(1) — empty array creation
    // space: O(k) — grows to hold k results
    var result: [Int] = []

    // time: O(k × u) — k rounds, each scans u unique values
    // space: O(1) — no extra allocation per iteration
    // INVARIANT: at the start of each iteration,
    // result contains the i most frequent elements found so far
    // and their counts are set to Int.min so they won't be picked again
    for _ in 0..<k {

        // time: O(1) — single assignment
        // space: O(1) — single integer
        // INVARIANT: maxIndex points to the highest count seen so far
        var maxIndex = 0

        // time: O(u) — scan all unique values
        // space: O(1) — only i used
        for i in 0..<counts.count {
            // time: O(1) — single comparison
            if counts[i] > counts[maxIndex] {
                maxIndex = i    // new most frequent found
            }
        }
        // INVARIANT: after inner loop, maxIndex holds
        // the index of the most frequent remaining element

        // time: O(1) — append to end
        // space: O(1) — one element added to result
        result.append(values[maxIndex])

        // time: O(1) — single assignment
        // space: O(1) — no allocation
        // mark as used so it won't be picked again in next round
        counts[maxIndex] = Int.min
    }
    // INVARIANT: result contains exactly k most frequent elements

    return result
}

// TEST CASES:
// topKFrequent([1, 1, 1, 2, 2, 3], 2) → [1, 2]
// topKFrequent([1], 1)                  → [1]


// ============================================================
// PROBLEM 4: Closest K Numbers to a Target
// LEVEL: Medium
// Return the k values closest to the target (by absolute difference).
// TIME: O(n × k) | SPACE: O(n + k)
// ============================================================

// MENTAL MODEL:
// Repeat k times: find the element with the smallest distance to target,
// grab it, remove it from copy.
// Distance = abs(value - target).

// CONSTRAINTS: k ≤ array.count
// EDGE CASES: ties in distance (returns leftmost), negative numbers

func closestKNumbers(_ nums: [Int], _ target: Int, _ k: Int) -> [Int] {

    // time: O(n) — copies all n elements
    // space: O(n) — extra array of size n
    var copy = nums

    // time: O(1) — empty array creation
    // space: O(k) — grows to hold k results
    var result: [Int] = []

    // time: O(k) outer iterations
    // space: O(1) — no extra allocation per iteration
    // INVARIANT: at start of each iteration,
    // result contains the i closest elements found so far
    // and copy no longer contains those elements
    for _ in 0..<k {

        // track index of closest element seen so far
        // time: O(1) — single assignment
        // space: O(1) — single integer
        var closestIndex = 0

        // CORE OPERATION: find element with smallest distance to target
        // time: O(n) first round, shrinks by 1 each round → O(n×k) total
        // space: O(1) — only index used, no extra allocation
        for index in 1..<copy.count {   // start at 1 — index 0 is current best
            // time: O(1) — two subtractions and a comparison
            let closestDistance = abs(copy[closestIndex] - target)
            let currentDistance = abs(copy[index] - target)

            if currentDistance < closestDistance {
                closestIndex = index    // found a closer element
            }
        }
        // INVARIANT: after inner loop, closestIndex holds
        // the index of the element closest to target in copy

        // time: O(1) — append to end
        // space: O(1) — one element added to result
        result.append(copy[closestIndex])

        // time: O(n) — shifts all elements after closestIndex left
        // space: O(1) — modifies in place
        copy.remove(at: closestIndex)
    }
    // INVARIANT: result contains exactly k elements closest to target

    return result
}

// TEST CASES:
// closestKNumbers([1, 3, 7, 9, 2], 5, 3) → [3, 7, 2]  (distances: 4,2,2,4,3)
// closestKNumbers([1, 2, 3], 2, 2)        → [2, 1]


// ============================================================
// PROBLEM 5: K Closest Points to Origin
// LEVEL: Medium
// Return the k points closest to (0, 0).
// TIME: O(n × k) | SPACE: O(n + k)
// ============================================================

// DESCRIPTION:
// Given an array of 2D points, return the k points closest to the origin.
// Order of result does not matter.

// Input:  [(1,3), (-2,2), (5,8), (0,1)], k=2  → [(-2,2), (0,1)]
// Input:  [(3,3), (5,-1), (-2,4)],        k=1  → [(3,3)]

// MENTAL MODEL:
// Repeat k times: find the point with the smallest squared distance to origin,
// grab it, remove it from copy.
// Use x² + y² instead of √(x² + y²) — square root is not needed for comparison.

// CONSTRAINTS: k ≤ points.count
// EDGE CASES: k = 1 (just the closest), multiple points at equal distance

func kClosestsPoints(points: [(Int, Int)], k: Int) -> [(Int, Int)] {
    var result: [(Int, Int)] = []
    var copy = points

    for _ in 0..<k {

        var closestPointIndex = 0
        var closestDistance = (copy[closestPointIndex].0 * copy[closestPointIndex].0) + (
            copy[closestPointIndex].1 * copy[closestPointIndex].1
        )

        for i in 0..<copy.count {

            let currentPDistance = (copy[i].0 * copy[i].0) + (
                copy[i].1 * copy[i].1
            )

            if currentPDistance < closestDistance {
                closestDistance = currentPDistance
                closestPointIndex = i
            }

        }

        result.append(copy[closestPointIndex])
        copy.remove(at: closestPointIndex)

    }


    return result
}

// TEST CASES:
// kClosestPoints([(1,3),(-2,2),(5,8),(0,1)], 2) → [(-2,2),(0,1)]
// kClosestPoints([(3,3),(5,-1),(-2,4)], 1)       → [(3,3)]
