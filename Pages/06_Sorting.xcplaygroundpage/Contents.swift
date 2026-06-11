// ============================================================
// CATEGORY: Sorting Algorithms — Brute Force
// ============================================================


// ============================================================
// PROBLEM 1: Bubble Sort
// LEVEL: Medium
// Sort array in ascending order by repeatedly swapping adjacent elements.
// TIME: O(n²) worst case, O(n) best case (early exit) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Each pass bubbles the largest unsorted element to its correct position.
// After pass k, the last k elements are in their final position.
// If no swaps occurred in a full pass, the array is already sorted — exit early.
// Outer loop shrinks the window from the right each round.

// CONSTRAINTS: array has at least 2 elements
// EDGE CASES: already sorted (best case O(n)), reverse sorted (worst case O(n²))

func bubbleSort(_ array: inout [Int]) {

    // time: O(1) — single comparison
    // space: O(1) — no allocation
    if array.count < 2 { return }

    // outer loop counts down from last index to 1
    // end = right boundary of unsorted region
    // time: O(n) outer iterations
    // INVARIANT: elements after index `end` are in their final sorted position
    var end = array.count - 1
    while end > 0 {

        // time: O(1) — single boolean assignment
        // space: O(1) — no allocation
        var swapped = false

        // inner loop compares adjacent pairs within unsorted region [0...end]
        // time: O(end) — shrinks by 1 each outer iteration → O(n²) total
        // space: O(1) — only current and temp used
        // INVARIANT: array[maxSoFar] is the largest in [0...current]
        var current = 0
        while current < end {

            if array[current] > array[current + 1] {
                // classic temp swap — C-style
                // time: O(1) — three assignments
                let temp = array[current]
                array[current] = array[current + 1]
                array[current + 1] = temp
                swapped = true
            }
            current += 1
        }
        // INVARIANT: after inner loop, array[end] holds the largest element
        // in the unsorted region [0...end]

        // early exit — if no swaps, array is already sorted
        if !swapped { return }

        end -= 1
    }
}

// TEST CASES:
// var a = [5, 8, 3, 4, 7, 9]; bubbleSort(&a) → [3, 4, 5, 7, 8, 9]
// var b = [1, 2, 3];           bubbleSort(&b) → [1, 2, 3] (1 pass only)
// var c = [3, 2, 1];           bubbleSort(&c) → [1, 2, 3]


// ============================================================
// PROBLEM 2: Selection Sort
// LEVEL: Medium
// Sort array by repeatedly finding the minimum and placing it at the front.
// TIME: O(n²) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Each pass selects the smallest element from the unsorted region
// and swaps it into its correct position at the left boundary.
// After pass k, the first k elements are in their final sorted position.
// Outer loop stops at count-2 — when only one element remains,
// it is already in place (nothing to compare against).

// CONSTRAINTS: array has at least 2 elements
// EDGE CASES: already sorted still takes O(n²), reverse sorted same cost

func selectionSort(_ array: inout [Int]) {

    // time: O(1) — single comparison
    // space: O(1) — no allocation
    if array.count < 2 { return }

    // outer loop places minimum into position i, one by one
    // stop at count-2 — last element is automatically in place
    // time: O(n) outer iterations
    // INVARIANT: array[0..<i] is sorted and contains the i smallest elements
    var i = 0
    while i < array.count - 1 {

        // assume current position i holds the minimum
        // time: O(1) — single assignment
        // space: O(1) — single integer
        // INVARIANT: lowest holds the index of smallest element seen so far in [i...j]
        var lowest = i

        // scan the unsorted region [i+1...end] to find the true minimum
        // time: O(n-i) per outer iteration → O(n²) total
        // space: O(1) — only j used
        var j = i + 1
        while j < array.count {
            // time: O(1) — single comparison
            if array[j] < array[lowest] {
                lowest = j   // found a smaller element
            }
            j += 1
        }
        // INVARIANT: after inner loop, lowest = index of minimum in [i...end]

        // swap minimum into position i (only if needed)
        // time: O(1) — three assignments
        // space: O(1) — single integer temp
        if lowest != i {
            let temp = array[i]
            array[i] = array[lowest]
            array[lowest] = temp
        }

        i += 1
    }
    // INVARIANT: entire array is sorted
}

// TEST CASES:
// var a = [5, 8, 3, 4, 7, 9]; selectionSort(&a) → [3, 4, 5, 7, 8, 9]
// var b = [1, 2, 3];           selectionSort(&b) → [1, 2, 3]
// var c = [3, 2, 1];           selectionSort(&c) → [1, 2, 3]
