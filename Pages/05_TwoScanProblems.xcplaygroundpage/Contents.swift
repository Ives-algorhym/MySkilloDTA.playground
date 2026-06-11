// ============================================================
// CATEGORY: Two-Scan Problems — Brute Force
// Pattern: for each index i, scan left (0...i) and scan right (i...n-1)
// Use when the answer at position i depends on BOTH sides of the array.
// TIME: O(n²) | SPACE: O(1)
// ============================================================


// ============================================================
// PROBLEM 1: Trapping Rain Water
// LEVEL: Hard
// Given bar heights, compute how much water is trapped after rain.
// Water above bar i = min(tallestLeft, tallestRight) - height[i]
// TIME: O(n²) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// For each bar, imagine filling water above it.
// Water level is limited by the SHORTER of the tallest wall on each side.
// water above bar i = min(tallestLeft, tallestRight) - height[i]
// If bar is taller than a wall, no water sits above it — use max(0, ...).

// CONSTRAINTS: array has at least 1 element, heights are non-negative
// EDGE CASES: single bar (no water), strictly increasing/decreasing array

func trapRainWater(_ heights: [Int]) -> Int {

    // time: O(1) — single integer
    // space: O(1) — no allocation
    var total = 0

    // time: O(n²) — for each bar, two full scans left and right
    // space: O(1) — no extra allocation
    // INVARIANT: total holds the sum of water trapped above all bars processed so far
    for i in 0..<heights.count {

        // find tallest wall to the LEFT (including current bar)
        // time: O(n) — scans from 0 to i (range 0...i)
        // space: O(1)
        var leftMaxH = 0
        for leftIndex in 0...i {
            if heights[leftIndex] > leftMaxH {
                leftMaxH = heights[leftIndex]
            }
        }
        // INVARIANT: leftMaxH = tallest bar from index 0 to i

        // find tallest wall to the RIGHT (including current bar)
        // time: O(n) — scans from i to end (range i..<count)
        // space: O(1)
        var rightMaxH = 0
        for rightIndex in i..<heights.count {
            if heights[rightIndex] > rightMaxH {
                rightMaxH = heights[rightIndex]
            }
        }
        // INVARIANT: rightMaxH = tallest bar from index i to end

        // water above this bar = shorter wall - bar height
        // max(0, ...) prevents negative water on tall bars or edges
        // time: O(1) — arithmetic
        // space: O(1)
        let water = max(0, min(leftMaxH, rightMaxH) - heights[i])
        total += water
    }
    // INVARIANT: total holds the sum of water trapped above every bar

    return total
}

// TEST CASES:
// trapRainWater([0,1,0,2,1,0,1,3,2,1,2,1]) → 6
// trapRainWater([4,2,0,3,2,5])              → 9
// trapRainWater([1,2,3])                    → 0  (no water trapped)


// ============================================================
// PROBLEM 2: Largest Rectangle in Histogram
// LEVEL: Hard
// Find the area of the largest rectangle that fits in the histogram.
// Rectangle height = shortest bar in the span.
// TIME: O(n²) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Try every possible left boundary i.
// For each i, expand right with j tracking the minimum height in [i...j].
// Rectangle height = shortest bar in span (limits the whole rectangle).
// Rectangle width  = j - i + 1  (inclusive range needs +1).
// Area = minHeight × width — keep the best seen.

// CONSTRAINTS: all heights are non-negative
// EDGE CASES: single bar, all bars same height, strictly increasing/decreasing

func largestRectangle(_ heights: [Int]) -> Int {

    // time: O(1) — single integer
    // space: O(1) — no allocation
    var best = 0

    // time: O(n²) — outer × inner loops
    // space: O(1) — no extra allocation
    // INVARIANT: best holds the largest rectangle area found so far
    for i in 0..<heights.count {

        // start minHeight at bar i — it is the only bar in span so far
        // time: O(1) — single assignment
        // space: O(1) — single integer
        // INVARIANT: minHeight = shortest bar in span [i...j]
        var minHeight = heights[i]

        // expand right boundary from i to end
        // time: O(n) per outer iteration → O(n²) total
        // space: O(1) — only j, minHeight, width, area used
        // INVARIANT: at each j, minHeight is the shortest bar in [i...j]
        for j in i..<heights.count {

            // update min — rectangle height is limited by shortest bar in span
            // time: O(1) — single comparison
            if heights[j] < minHeight {
                minHeight = heights[j]
            }

            // width = number of bars in span [i...j]
            // +1 because both endpoints are inclusive
            // time: O(1) — arithmetic
            let width = j - i + 1
            let area = minHeight * width

            // time: O(1) — single comparison
            if area > best {
                best = area
            }
        }
        // INVARIANT: after inner loop, best includes all rectangles
        // starting at left boundary i
    }
    // INVARIANT: best holds the area of the largest rectangle in the histogram

    return best
}

// TEST CASES:
// largestRectangle([2,1,5,6,2,3]) → 10  (bars 5,6 → height=5, width=2)
// largestRectangle([2,4])          → 4   (single bar height=4, width=1)
// largestRectangle([1,1,1,1])      → 4   (all bars → height=1, width=4)
