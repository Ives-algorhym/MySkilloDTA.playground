// ============================================================
// CATEGORY: Data Structures — Array-Based Implementations
// No custom types needed — plain arrays with helper functions.
// ============================================================


// ============================================================
// STRUCTURE 1: Stack
// LEVEL: Easy
// LIFO — Last In, First Out
// ============================================================

// MENTAL MODEL:
// A stack of plates — you can only add or remove from the top.
// append() = push (add to top)
// removeLast() = pop (take from top)

// Operations:
// push   → append()      O(1)
// pop    → popLast()     O(1)  returns nil if empty (safe)
// peek   → last          O(1)
// isEmpty→ isEmpty       O(1)

var stack: [Int] = []

func pushStack(_ value: Int) {
    stack.append(value)         // add to top
}

func popStack() -> Int? {
    return stack.popLast()      // remove from top, nil if empty
}

func peekStack() -> Int? {
    return stack.last           // look at top without removing
}

// TEST CASES:
// pushStack(1); pushStack(2); pushStack(3)
// stack       → [1, 2, 3]
// popStack()  → 3, stack → [1, 2]
// peekStack() → 2


// ============================================================
// STRUCTURE 2: Queue
// LEVEL: Easy
// FIFO — First In, First Out
// ============================================================

// MENTAL MODEL:
// A checkout line — first person in is first person out.
// append()     = enqueue (add to back)
// removeFirst()= dequeue (take from front)

// NOTE: removeFirst() is O(n) — shifts all elements left.
// Acceptable for learning. Use a linked list for O(1) production queue.

// Operations:
// enqueue → append()       O(1)
// dequeue → removeFirst()  O(n)  crashes if empty — check isEmpty first
// peek    → first          O(1)
// isEmpty → isEmpty        O(1)

var queue: [Int] = []

func enqueue(_ value: Int) {
    queue.append(value)             // add to back
}

func dequeue() -> Int? {
    guard !queue.isEmpty else { return nil }
    return queue.removeFirst()      // take from front
}

func peekQueue() -> Int? {
    return queue.first              // look at front without removing
}

// TEST CASES:
// enqueue(1); enqueue(2); enqueue(3)
// queue      → [1, 2, 3]
// dequeue()  → 1, queue → [2, 3]
// peekQueue()→ 2


// ============================================================
// STRUCTURE 3: Min Heap
// LEVEL: Hard
// Always keeps the smallest element at the top.
// ============================================================

// MENTAL MODEL:
// A binary tree stored as an array.
// Parent is always smaller than its children.
// Index math: parent(i) = (i-1)/2, left(i) = 2i+1, right(i) = 2i+2
//
// insert → append to end, bubble UP  → O(log n)
// removeMin → swap top with last, remove last, bubble DOWN → O(log n)
// peek → first element → O(1)

func heapBubbleUp(_ heap: inout [Int], _ i: Int) {
    var i = i
    // time: O(log n) — at most tree-height comparisons
    // INVARIANT: heap[0..<i] satisfies min-heap property
    while i > 0 {
        let parent = (i - 1) / 2
        if heap[i] < heap[parent] {
            heap.swapAt(i, parent)  // child smaller than parent, swap
            i = parent
        } else {
            break   // heap property restored
        }
    }
}

func heapBubbleDown(_ heap: inout [Int], _ i: Int) {
    var i = i
    // time: O(log n) — at most tree-height comparisons
    // INVARIANT: heap[i+1...] satisfies min-heap property
    while true {
        let left  = 2 * i + 1
        let right = 2 * i + 2
        var smallest = i

        if left  < heap.count && heap[left]  < heap[smallest] { smallest = left }
        if right < heap.count && heap[right] < heap[smallest] { smallest = right }

        if smallest == i { break }  // heap property satisfied
        heap.swapAt(i, smallest)
        i = smallest
    }
}

func heapInsert(_ heap: inout [Int], _ val: Int) {
    heap.append(val)                          // add to end
    heapBubbleUp(&heap, heap.count - 1)       // restore heap property
}

func heapRemoveMin(_ heap: inout [Int]) -> Int? {
    guard !heap.isEmpty else { return nil }
    heap.swapAt(0, heap.count - 1)            // move min to end
    let min = heap.removeLast()               // remove it
    heapBubbleDown(&heap, 0)                  // restore heap property
    return min
}

// TEST CASES:
// var h: [Int] = []
// heapInsert(&h, 300); heapInsert(&h, 200); heapInsert(&h, 250)
// h.first       → 200  (min always at top)
// heapRemoveMin(&h) → 200
// h.first       → 250


// ============================================================
// STRUCTURE 4: Grid Layout
// LEVEL: Medium
// Insert pins into columns, always choosing the shortest column first.
// Ties go to the leftmost column.
// TIME: O(n × k) | SPACE: O(n + k)
// ============================================================

// MENTAL MODEL:
// Like filling water jugs — always pour into the shortest jug first.
// Track column heights separately to avoid recalculating from scratch each time.

struct Pin {
    let id: String
    let height: Int
}

func gridLayout(pinList: [Pin], columnCount: Int) -> [[Pin]] {

    // time: O(k) — creates k empty column arrays
    // space: O(n) — grows to hold all n pins across k columns
    var columns = Array(repeating: Array<Pin>(), count: columnCount)

    // time: O(k) — creates k zeros
    // space: O(k) — one height per column
    var heights = Array(repeating: 0, count: columnCount)

    // time: O(n × k) — for each pin, scan all k columns
    // space: O(1) — no extra allocation per iteration
    // INVARIANT: heights[i] = total height of all pins inserted in column i so far
    for pin in pinList {

        // find shortest column — O(k)
        // INVARIANT: shortestIndex = index of column with lowest total height
        // ties go left because < is strict — leftmost tied column is never replaced
        var shortestIndex = 0
        for i in 1..<columnCount {
            if heights[i] < heights[shortestIndex] {
                shortestIndex = i
            }
        }

        // time: O(1) — append to column and update height
        columns[shortestIndex].append(pin)
        heights[shortestIndex] += pin.height
    }

    return columns
}

// TEST CASES:
// let pins = [Pin(id:"1",height:300), Pin(id:"2",height:200),
//             Pin(id:"3",height:250), Pin(id:"4",height:350),
//             Pin(id:"5",height:100)]
// gridLayout(pinList: pins, columnCount: 2)
// → col0: [pin1(300), pin4(350)]  total=650
// → col1: [pin2(200), pin3(250), pin5(100)]  total=550
