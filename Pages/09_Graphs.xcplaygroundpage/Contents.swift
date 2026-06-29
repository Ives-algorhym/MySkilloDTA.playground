// ============================================================
// CATEGORY: Graphs — Adjacency List (plain arrays)
// ============================================================

// REPRESENTATION:
// graph[i] = list of neighbors of node i
// Undirected: if 0 connects to 1, add 1 to graph[0] AND 0 to graph[1]
// Directed:   one-way only, add to source only

// KEY DIFFERENCE FROM TREES:
// Graphs can have CYCLES — you can visit the same node twice.
// Solution: keep a visited[] array to track seen nodes.

// Example graph:
// 0 -- 1
// |    |
// 3 -- 2

var graph: [[Int]] = [
    [1, 3],   // 0 connects to 1 and 3
    [0, 2],   // 1 connects to 0 and 2
    [1, 3],   // 2 connects to 1 and 3
    [0, 2]    // 3 connects to 0 and 2
]

let graphLabels = ["A", "B", "C", "D"]


// ─────────────────────────────────────────
// DFS — Depth First Search (recursive)
// LEVEL: Medium
// TIME: O(n + e) | SPACE: O(n)  where e = edges
// ─────────────────────────────────────────
// MENTAL MODEL:
// Visit node, mark visited, recurse into unvisited neighbors.
// visited[] prevents infinite loops on cycles.

func dfs(_ graph: [[Int]], _ node: Int, _ labels: [String], _ visited: inout [Bool]) {
    visited[node] = true
    print(labels[node])

    for neighbor in graph[node] {
        if !visited[neighbor] {
            dfs(graph, neighbor, labels, &visited)
        }
    }
}

// Usage:
// var visited = Array(repeating: false, count: graph.count)
// dfs(graph, 0, graphLabels, &visited)  → A, B, C, D


// ─────────────────────────────────────────
// DFS — Iterative (explicit stack)
// LEVEL: Medium
// TIME: O(n + e) | SPACE: O(n)
// ─────────────────────────────────────────
// MENTAL MODEL:
// Stack stores (node, parent) tuples.
// Check visited AFTER popping (not before pushing) to handle multiple paths.

func dfsIterative(_ graph: [[Int]], _ start: Int, _ labels: [String]) {
    var visited = Array(repeating: false, count: graph.count)
    var stack = [start]

    while !stack.isEmpty {
        let node = stack.removeLast()
        if visited[node] { continue }
        visited[node] = true
        print(labels[node])

        for neighbor in graph[node] {
            if !visited[neighbor] {
                stack.append(neighbor)
            }
        }
    }
}


// ─────────────────────────────────────────
// BFS — Breadth First Search
// LEVEL: Medium
// TIME: O(n + e) | SPACE: O(n)
// ─────────────────────────────────────────
// MENTAL MODEL:
// Queue ensures we visit level by level (nearest neighbors first).
// Mark visited BEFORE enqueuing to avoid adding the same node twice.

func bfs(_ graph: [[Int]], _ start: Int, _ labels: [String]) {
    var visited = Array(repeating: false, count: graph.count)
    var queue = [start]
    visited[start] = true

    while !queue.isEmpty {
        let node = queue.removeFirst()
        print(labels[node])

        for neighbor in graph[node] {
            if !visited[neighbor] {
                visited[neighbor] = true    // mark before enqueuing
                queue.append(neighbor)
            }
        }
    }
}

// Usage:
// bfs(graph, 0, graphLabels)  → A, B, D, C  (level by level)


// ─────────────────────────────────────────
// Cycle Detection — Undirected Graph
// LEVEL: Hard
// TIME: O(n + e) | SPACE: O(n)
// ─────────────────────────────────────────
// MENTAL MODEL:
// During DFS, if we reach an already-visited node that is NOT the parent
// we came from, we found a back edge = cycle.
// In undirected graphs, every edge appears in both directions.
// We skip the parent to avoid treating the edge we came from as a cycle.

func hasCycle(_ graph: [[Int]]) -> Bool {
    var visited = Array(repeating: false, count: graph.count)

    // handle disconnected graphs — try each unvisited node as start
    for start in 0..<graph.count {
        if visited[start] { continue }

        var stack = [(node: start, parent: -1)]  // -1 = no parent for root

        while !stack.isEmpty {
            let (node, parent) = stack.removeLast()
            if visited[node] { continue }
            visited[node] = true

            for neighbor in graph[node] {
                if !visited[neighbor] {
                    stack.append((node: neighbor, parent: node))
                } else if neighbor != parent {
                    return true   // visited + not parent = cycle found
                }
            }
        }
    }
    return false
}

// TEST CASES:
// hasCycle([[1,3],[0,2],[1,3],[0,2]])  → true  (0-1-2-3-0 is a cycle)
// hasCycle([[1],[0,2],[1]])            → false (0-1-2 is a path, no cycle)


// Build A graph with adjacent list

var adjacentList: [[Int]] = [[], [], [], []]


@MainActor func addEdge(edge: Int, to vertix: Int, indirect: Bool = false) {
    guard edge >= 0, edge < adjacentList.count, vertix >= 0, vertix < adjacentList.count else {
        return
    }

    adjacentList[vertix].append(edge)

    if indirect {
        adjacentList[edge].append(vertix)
    }
}

addEdge(edge: 0, to: 1)
addEdge(edge: 0, to: 2)
addEdge(edge: 1, to: 3)
addEdge(edge: 2, to: 3)
addEdge(edge: 3, to: 4)


@MainActor func bfs(from start: Int) -> [Int] {
    var visited: Set<Int> = [start]
    var queue: [Int] = [start]
    var order: [Int] = []

    while !queue.isEmpty {
        let current = queue.removeFirst()
        order.append(current)

        for neighbor in adjacentList[current] {
            if !visited.contains(neighbor) {
                visited.insert(neighbor)
                queue.append(neighbor)
            }
        }

    }
    return order
}

@MainActor
func dfs(from start: Int) ->  [Int] {
    var  visited: Set<Int> = [start]
    var stack: [Int] = [start]
    var order: [Int] = []

    while !stack.isEmpty {
        let current = stack.removeLast()
        order.append(current)

        for neighbord in adjacentList[current]
        {
            if !visited.contains(neighbord) {
                visited.insert(neighbord)
                stack.append(neighbord)
            }
        }
    }
    return order
}
