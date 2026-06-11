// ============================================================
// CATEGORY: Trees — Traversal and Operations
// Two representations: TreeNode class and adjacency array
// ============================================================


// ============================================================
// TREE REPRESENTATION 1: TreeNode class
// ============================================================

// Linked-list queue used for BFS / level-order traversal
class Node<T> {
    var value: T
    var next: Node?
    init(value: T) { self.value = value }
}

public class QueueL<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    private var isEmpty: Bool { return head == nil }

    func enqueue(_ value: T) {
        let newNode = Node(value: value)
        if head == nil {
            head = newNode
            tail = newNode
            return
        }
        tail?.next = newNode
        tail = newNode
    }

    func dequeue() -> T? {
        guard head != nil else { return nil }
        let value = head?.value
        head = head?.next
        return value
    }
}

class TreeNode<T> {
    var value: T
    var children: [TreeNode] = []

    init(_ value: T) { self.value = value }

    func add(_ child: TreeNode) { children.append(child) }
}

extension TreeNode {

    // ─────────────────────────────────────────
    // DFS — Depth First (recursive)
    // LEVEL: Easy
    // Visit node first, then recurse into children.
    // Base case: node with no children — forEach does nothing, returns.
    // TIME: O(n) | SPACE: O(h) where h = tree height (call stack depth)
    // ─────────────────────────────────────────
    func forEachDepthFirst(visit: (TreeNode) -> Void) {
        visit(self)                     // 1. process this node
        children.forEach {              // 2. recurse into each child
            $0.forEachDepthFirst(visit: visit)
        }
    }

    // ─────────────────────────────────────────
    // BFS — Breadth First / Level Order (queue)
    // LEVEL: Easy
    // Visit node, enqueue its children, process queue level by level.
    // TIME: O(n) | SPACE: O(w) where w = max width of tree
    // ─────────────────────────────────────────
    func forEachLevelOrder(visit: (TreeNode) -> Void) {
        visit(self)                     // 1. visit root directly
        var queue = QueueL<TreeNode>()
        children.forEach { queue.enqueue($0) }  // 2. enqueue root's children

        while let node = queue.dequeue() {       // 3. process until queue empty
            visit(node)
            node.children.forEach { queue.enqueue($0) }  // enqueue next level
        }
    }
}

// Build beverages tree
let beverages = TreeNode("Beverages")
let hot = TreeNode("Hot");     let cold = TreeNode("Cold")
let tea = TreeNode("Tea");     let coffee = TreeNode("Coffee");  let chocolate = TreeNode("Chocolate")
let blackTea = TreeNode("black"); let greenTea = TreeNode("green"); let chaiTea = TreeNode("chai")
let soda = TreeNode("soda");   let milk = TreeNode("milk")
let gingerAle = TreeNode("ginger ale"); let bitterLemon = TreeNode("bitter lemon")

beverages.add(hot);   beverages.add(cold)
hot.add(tea);         hot.add(coffee);     hot.add(chocolate)
cold.add(soda);       cold.add(milk)
tea.add(blackTea);    tea.add(greenTea);   tea.add(chaiTea)
soda.add(gingerAle);  soda.add(bitterLemon)

// Usage:
// beverages.forEachDepthFirst { print($0.value) }
// beverages.forEachLevelOrder  { print($0.value) }


// ============================================================
// TREE REPRESENTATION 2: Adjacency Array (no custom types)
// index = node ID, value = list of child IDs
// ============================================================

// MENTAL MODEL:
// tree[i] answers: "who are node i's children?"
// labels[i] answers: "what is node i's name?"
// You only ever call dfs/bfs with node 0 — recursion handles the rest.

var tree: [[Int]] = [
    [1, 2],     // 0: Beverages
    [3, 4, 5],  // 1: Hot
    [9, 10],    // 2: Cold
    [6, 7, 8],  // 3: Tea
    [],         // 4: Coffee
    [],         // 5: Chocolate
    [],         // 6: Black
    [],         // 7: Green
    [],         // 8: Chai
    [11, 12],   // 9: Soda
    [],         // 10: Milk
    [],         // 11: Ginger Ale
    []          // 12: Bitter Lemon
]

let labels = ["Beverages","Hot","Cold","Tea","Coffee","Chocolate",
              "Black","Green","Chai","Soda","Milk","Ginger Ale","Bitter Lemon"]


// ─────────────────────────────────────────
// DFS — Recursive
// LEVEL: Easy
// TIME: O(n) | SPACE: O(h) call stack
// ─────────────────────────────────────────
// MENTAL MODEL: visit current node, recurse into each child.
// Base case is implicit — empty children array means forEach does nothing.

func dfs(_ tree: [[Int]], _ node: Int, _ labels: [String]) {
    print(labels[node])
    for child in tree[node] {
        dfs(tree, child, labels)
    }
}


// ─────────────────────────────────────────
// DFS — Iterative (explicit stack)
// LEVEL: Medium
// TIME: O(n) | SPACE: O(n)
// ─────────────────────────────────────────
// MENTAL MODEL: push children in reverse so left child is processed first.
// Stack is LIFO — reversed push restores left-to-right visit order.

func dfsStack(_ tree: [[Int]], _ start: Int, _ labels: [String]) {
    var stack = [start]
    while !stack.isEmpty {
        let node = stack.removeLast()
        print(labels[node])
        var i = tree[node].count - 1
        while i >= 0 {
            stack.append(tree[node][i])
            i -= 1
        }
    }
}


// ─────────────────────────────────────────
// BFS — Level Order
// LEVEL: Easy
// TIME: O(n) | SPACE: O(w) max width
// ─────────────────────────────────────────
// MENTAL MODEL: use queue array. Enqueue children as you visit each node.
// visited[start] = true before entering loop to avoid revisiting.

func bfs(_ tree: [[Int]], _ start: Int, _ labels: [String]) {
    var queue = [start]
    var i = 0
    while i < queue.count {
        let node = queue[i]
        print(labels[node])
        for child in tree[node] { queue.append(child) }
        i += 1
    }
}


// ─────────────────────────────────────────
// Count All Nodes
// LEVEL: Easy
// TIME: O(n) | SPACE: O(h)
// ─────────────────────────────────────────
// MENTAL MODEL: count = 1 (this node) + sum of counts of all children.

func countNodes(_ tree: [[Int]], _ node: Int) -> Int {
    var count = 1
    for child in tree[node] {
        count += countNodes(tree, child)
    }
    return count
}


// ─────────────────────────────────────────
// Tree Height
// LEVEL: Easy
// TIME: O(n) | SPACE: O(h)
// ─────────────────────────────────────────
// MENTAL MODEL:
// Leaf node (no children) → height 0.
// Any other node → 1 + max height of its children.

func height(_ tree: [[Int]], _ node: Int) -> Int {
    if tree[node].isEmpty { return 0 }  // base case: leaf
    var maxH = 0
    for child in tree[node] {
        let h = height(tree, child)
        if h > maxH { maxH = h }
    }
    return maxH + 1
}


// ─────────────────────────────────────────
// Count Leaves
// LEVEL: Easy
// TIME: O(n) | SPACE: O(h)
// ─────────────────────────────────────────
// MENTAL MODEL: a leaf contributes 1, an internal node contributes
// the sum of leaves in all its subtrees.

func countLeaves(_ tree: [[Int]], _ node: Int) -> Int {
    if tree[node].isEmpty { return 1 }  // leaf
    var count = 0
    for child in tree[node] {
        count += countLeaves(tree, child)
    }
    return count
}


// ─────────────────────────────────────────
// Pascal's Triangle
// LEVEL: Medium
// TIME: O(n²) | SPACE: O(n²)
// ─────────────────────────────────────────
// MENTAL MODEL — building rows from previous rows:
// Each row starts and ends with 1.
// Middle element [col] = previous row[col-1] + previous row[col].
// row + 1 = number of elements in each row (0-indexed).

func pascalTriangle(_ numRows: Int) -> [[Int]] {
    var result: [[Int]] = []
    for row in 0..<numRows {
        var current = Array(repeating: 1, count: row + 1)
        if row > 1 {
            for col in 1..<row {
                current[col] = result[row - 1][col - 1] + result[row - 1][col]
            }
        }
        result.append(current)
    }
    return result
}

// TEST CASES:
// dfs(tree, 0, labels)       → Beverages, Hot, Tea, Black, Green, Chai, Coffee...
// bfs(tree, 0, labels)       → Beverages, Hot, Cold, Tea, Coffee, Chocolate...
// countNodes(tree, 0)        → 13
// height(tree, 0)            → 3
// countLeaves(tree, 0)       → 8
// pascalTriangle(4)          → [[1],[1,1],[1,2,1],[1,3,3,1]]
