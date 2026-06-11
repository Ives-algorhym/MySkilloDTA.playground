# MySkilloDTA — Data Structures & Algorithms in Swift

A structured Swift playground covering core DSA patterns used in technical interviews, built from first principles with explicit time/space complexity analysis on every operation.

---

## What's Inside

Each page follows a deliberate progression: **brute force first, then optimized**. Every solution includes a mental model, loop invariants, per-line complexity annotations, constraints, and edge cases.

| Page | Topic | Problems Covered |
|------|-------|-----------------|
| 01 | Array Basics | Find Max, Reverse, Count Occurrences, Has Duplicates, Is Sorted, Second Largest, Most Frequent, Find Missing |
| 02 | String Problems | Is Palindrome, Longest Word, Designer PDF Viewer |
| 03 | Pair & Window | Two Sum, Count Pairs, Max Pair Sum, Rotate Left (brute → O(n)) |
| 04 | K-Problems | K Largest, Kth Smallest, Top K Frequent, Closest K Numbers |
| 05 | Two-Scan Problems | Trapping Rain Water, Largest Rectangle in Histogram |
| 06 | Sorting | Bubble Sort (with early exit), Selection Sort |
| 07 | Data Structures | Stack, Queue, Min Heap (bubble up/down), Grid Layout |
| 08 | Trees | DFS (recursive + iterative), BFS, Count Nodes, Tree Height, Count Leaves, Pascal's Triangle |
| 09 | Graphs | DFS (recursive + iterative), BFS, Cycle Detection |
| 10 | Dynamic Programming | Longest Increasing Subsequence |
| 11 | Templates | Reusable problem scaffolding |

---

## Approach

Each solution is written to be **read like documentation**, not just code:

```swift
// MENTAL MODEL:
// Walk through the array keeping track of the largest seen so far.
// Each element challenges the current champion.

func findMax(_ nums: [Int]) -> Int {
    var max = nums[0]

    // time: O(n) — visits every element once
    // space: O(1) — no allocation per iteration
    // INVARIANT: max holds the largest value seen so far
    for num in nums {
        if num > max { max = num }
    }
    return max
}
```

Every function includes:
- **Mental model** — how to think about the problem
- **Complexity** — time and space at the function level and per-line
- **Loop invariants** — what is guaranteed true at each iteration
- **Constraints & edge cases** — what the function assumes and where it can break
- **Test cases** — concrete examples with expected output

---

## How to Open

1. Clone the repo
2. Open `MySkilloDTA.playground` in Xcode
3. Navigate pages using the left sidebar

Requires **Xcode 15+** and **Swift 5.9+**.

---

## Topics by Complexity Pattern

| Pattern | Examples |
|---------|----------|
| O(n) single pass | Find Max, Count Occurrences, Is Sorted |
| O(n²) nested loops | Has Duplicates, Two Sum, Bubble Sort |
| O(n × k) repeated selection | K Largest, Top K Frequent, Closest K |
| O(log n) per operation | Min Heap insert/remove |
| O(n + e) graph traversal | DFS, BFS, Cycle Detection |
| O(n²) DP table | Longest Increasing Subsequence |
