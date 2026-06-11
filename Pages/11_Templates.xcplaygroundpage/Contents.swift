// ============================================================
// INTERVIEW REFERENCE — Patterns, Templates, Checklist
// ============================================================


// ============================================================
// INTERVIEW CHECKLIST
// ============================================================

// 1. UNDERSTAND
//    □ Read the problem twice
//    □ Ask about constraints (size, negatives, empty, duplicates)
//    □ Ask about edge cases
//    □ Restate in your own words

// 2. PLAN
//    □ State brute force first — even if slow
//    □ Identify which pattern fits (see table below)
//    □ State time and space complexity before coding

// 3. CODE
//    □ Start with happy path
//    □ Name variables clearly
//    □ Talk through what you are doing

// 4. VERIFY
//    □ Trace through a simple example by hand
//    □ Test edge cases (empty, single element, duplicates)
//    □ State final time and space complexity
//    □ Ask "can I do better?"

// COMPLEXITY TARGETS:
// Brute force:  O(n²)     — mention it, then improve
// Good:         O(n log n)
// Optimal:      O(n) or O(log n)


// ============================================================
// PATTERN RECOGNITION TABLE
// ============================================================

// | Pattern          | When to use                                      |
// |------------------|--------------------------------------------------|
// | Brute Force      | Nested loops, try all combinations               |
// | Two Pointers     | Sorted array, find pair, palindrome              |
// | Sliding Window   | Subarray/substring, consecutive elements         |
// | Binary Search    | Sorted array, find position, minimize/maximize   |
// | Hash Map         | Fast lookup, count frequency, find complement    |
// | Stack            | Matching brackets, next greater element, DFS    |
// | Queue / BFS      | Shortest path, level order, nearest neighbor    |
// | Recursion / DFS  | Tree/graph traversal, subsets, permutations     |
// | Dynamic Prog.    | Overlapping subproblems, count ways, min/max    |
// | Greedy           | Local best choice leads to global best          |
// | Repeated Select  | Find k-largest, k-smallest, k-closest           |
// | Two Scan         | Answer at i depends on both left and right side  |


// ============================================================
// TEMPLATE 1: Brute Force (nested loops)
// ============================================================
func bruteForceTemplate(_ arr: [Int]) {
    for i in 0..<arr.count {
        for j in i + 1..<arr.count {
            // compare arr[i] and arr[j]
        }
    }
}


// ============================================================
// TEMPLATE 2: Two Pointers
// ============================================================
// MENTAL MODEL: two people walking toward each other.
// Move the pointer that needs to change based on current result.
func twoPointersTemplate(_ arr: [Int], _ target: Int) {
    var left = 0
    var right = arr.count - 1
    while left < right {
        let sum = arr[left] + arr[right]
        if sum == target {
            // found
            return
        } else if sum < target {
            left += 1     // need bigger → move left forward
        } else {
            right -= 1    // need smaller → move right back
        }
    }
}


// ============================================================
// TEMPLATE 3: Sliding Window — Fixed Size
// ============================================================
// MENTAL MODEL: a frame of size k sliding across the array.
// Drop leftmost, add new right — no need to recompute whole sum.
func slidingWindowFixed(_ arr: [Int], _ k: Int) {
    var windowSum = 0
    for i in 0..<k { windowSum += arr[i] }  // build first window
    var best = windowSum

    for i in k..<arr.count {
        windowSum += arr[i]         // add new right element
        windowSum -= arr[i - k]    // remove old left element
        best = max(best, windowSum)
    }
}


// ============================================================
// TEMPLATE 4: Sliding Window — Variable Size
// ============================================================
// MENTAL MODEL: rubber band stretching (right) and shrinking (left).
// Expand until condition met, shrink until condition lost.
func slidingWindowVariable(_ arr: [Int], _ target: Int) {
    var left = 0
    var windowSum = 0
    for right in 0..<arr.count {
        windowSum += arr[right]           // expand right
        while windowSum > target {        // condition broken — shrink left
            windowSum -= arr[left]
            left += 1
        }
        // window [left...right] is valid here
    }
}


// ============================================================
// TEMPLATE 5: Binary Search
// ============================================================
// MENTAL MODEL: guess the middle, throw away half that can't contain answer.
func binarySearchTemplate(_ arr: [Int], _ target: Int) -> Int {
    var left = 0
    var right = arr.count - 1
    while left <= right {
        let mid = left + (right - left) / 2   // avoid overflow
        if arr[mid] == target { return mid }
        else if arr[mid] < target { left = mid + 1 }
        else { right = mid - 1 }
    }
    return -1
}


// ============================================================
// TEMPLATE 6: Hash Map (frequency / complement lookup)
// ============================================================
// MENTAL MODEL: as you walk, store what you've seen in a notebook.
// For each new element, check if its complement is already noted.
func hashMapTemplate(_ arr: [Int], _ target: Int) {
    var map: [Int: Int] = [:]    // value → index
    for (i, num) in arr.enumerated() {
        let complement = target - num
        if map[complement] != nil {
            // found pair
        }
        map[num] = i
    }
}


// ============================================================
// TEMPLATE 7: Stack
// ============================================================
// MENTAL MODEL: plates — add and remove from the top only.
func stackTemplate(_ arr: [Int]) {
    var stack: [Int] = []
    for num in arr {
        while !stack.isEmpty && stack.last! > num {
            let top = stack.removeLast()   // process top
            _ = top
        }
        stack.append(num)
    }
}


// ============================================================
// TEMPLATE 8: BFS
// ============================================================
// MENTAL MODEL: ripples in water — visit nearest nodes first.
func bfsTemplate(_ graph: [[Int]], _ start: Int) {
    var visited = Array(repeating: false, count: graph.count)
    var queue = [start]
    visited[start] = true
    while !queue.isEmpty {
        let node = queue.removeFirst()
        _ = node   // process node
        for neighbor in graph[node] {
            if !visited[neighbor] {
                visited[neighbor] = true
                queue.append(neighbor)
            }
        }
    }
}


// ============================================================
// TEMPLATE 9: DFS
// ============================================================
// MENTAL MODEL: go as deep as possible, backtrack when stuck.
func dfsTemplate(_ graph: [[Int]], _ node: Int, _ visited: inout [Bool]) {
    visited[node] = true
    _ = node   // process node
    for neighbor in graph[node] {
        if !visited[neighbor] {
            dfsTemplate(graph, neighbor, &visited)
        }
    }
}


// ============================================================
// TEMPLATE 10: Repeated Selection (K-Problems)
// ============================================================
// MENTAL MODEL: repeat k times — find best, grab it, remove it.
// Core operation changes per problem (max/min/most frequent/closest).
func repeatedSelectionTemplate(_ nums: [Int], _ k: Int) -> [Int] {
    var copy = nums
    var result: [Int] = []
    for _ in 0..<k {
        var bestIndex = 0
        for i in 1..<copy.count {
            if copy[i] > copy[bestIndex] {   // change condition per problem
                bestIndex = i
            }
        }
        result.append(copy[bestIndex])
        copy.remove(at: bestIndex)
    }
    return result
}


// ============================================================
// TEMPLATE 11: Two Scan (Left + Right)
// ============================================================
// MENTAL MODEL: for each position, scan left then scan right.
// Use when the answer at index i depends on BOTH sides.
func twoScanTemplate(_ arr: [Int]) {
    for i in 0..<arr.count {
        var leftResult = 0
        for leftIndex in 0...i {          // scan left (0 to i)
            leftResult = max(leftResult, arr[leftIndex])
        }

        var rightResult = 0
        for rightIndex in i..<arr.count { // scan right (i to end)
            rightResult = max(rightResult, arr[rightIndex])
        }

        // combine left and right results
        _ = min(leftResult, rightResult)
    }
}


// ============================================================
// TEMPLATE 12: Dynamic Programming
// ============================================================
// MENTAL MODEL: at each position, ask "if I knew the answer for all
// previous positions, what is the answer for me?"
func dpTemplate(_ arr: [Int]) -> Int {
    var dp = Array(repeating: 0, count: arr.count)
    dp[0] = arr[0]   // base case

    for i in 1..<arr.count {
        dp[i] = max(arr[i], dp[i - 1] + arr[i])   // recurrence — changes per problem
    }

    return dp.max() ?? 0
}
