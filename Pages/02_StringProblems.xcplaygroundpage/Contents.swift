// ============================================================
// CATEGORY: String Problems — Brute Force
// ============================================================


// ============================================================
// PROBLEM 1: Is Palindrome
// LEVEL: Easy
// TIME: O(n) | SPACE: O(n)
// ============================================================

// MENTAL MODEL:
// Brute force: reverse the string manually, then compare to original.
// Build reversed array walking from last index to 0.

// CONSTRAINTS: string has at least 1 character
// EDGE CASES: single character (always palindrome), spaces count as characters

func isPalindrome(_ s: String) -> Bool {
    // time: O(n) — converts string to character array
    // space: O(n) — array of n characters
    let chars = Array(s)

    // time: O(1) — empty array creation
    // space: O(n) — grows to hold all characters in reverse
    var reversed: [Character] = []

    // time: O(n) — walks from last index to 0
    // space: O(1) — single integer i
    // INVARIANT: reversed contains chars[i+1...n-1] in reverse order
    var i = chars.count - 1
    while i >= 0 {
        reversed.append(chars[i])
        i -= 1
    }
    // INVARIANT: reversed = full reverse of chars

    // time: O(n) — compares element by element
    // space: O(1) — no extra allocation
    return chars == reversed
}

// TEST CASES:
// isPalindrome("racecar") → true
// isPalindrome("hello")   → false
// isPalindrome("a")       → true


// ============================================================
// PROBLEM 2: Longest Word
// LEVEL: Easy
// TIME: O(n × m) | SPACE: O(1)  where m = average word length
// ============================================================

// MENTAL MODEL:
// Keep track of the longest word seen so far.
// Each new word challenges the current champion by comparing length.

// CONSTRAINTS: array has at least 1 element
// EDGE CASES: multiple words of same length (returns first found), single word

func longestWord(_ words: [String]) -> String {
    // time: O(1) — first element is initial champion
    // space: O(1) — reference to existing string, no copy
    var longest = words[0]

    // time: O(n × m) — visits each word, .count is O(m)
    // space: O(1) — no allocation per iteration
    // INVARIANT: longest holds the longest word seen so far
    for word in words {
        if word.count > longest.count { longest = word }
    }
    return longest
}

// TEST CASES:
// longestWord(["cat", "elephant", "dog"]) → "elephant"
// longestWord(["hi", "bye"])               → "bye"


// ============================================================
// PROBLEM 3: Designer PDF Viewer
// LEVEL: Easy
// TIME: O(n) | SPACE: O(1)
// ============================================================

// MENTAL MODEL:
// Walk through each character in the word.
// Convert letter to array index using ASCII: 'a'=0, 'b'=1, ..., 'z'=25.
// Track the maximum height found.
// Area = maxHeight × word.count (each letter has width 1).

// CONSTRAINTS: h has exactly 26 elements (one per letter a-z)
//              word contains only lowercase letters
// EDGE CASES: single character word

func designerPdfViewer(_ h: [Int], _ word: String) -> Int {
    // time: O(1) — single integer
    // space: O(1) — no allocation
    var maxHeight = 0

    // time: O(n) — visits each character in word once
    // space: O(1) — only index used per iteration
    // INVARIANT: maxHeight = tallest letter seen so far in word
    for ch in word {
        // time: O(1) — ASCII subtraction, 'a' = 97
        let index = Int(ch.asciiValue!) - 97
        if h[index] > maxHeight { maxHeight = h[index] }
    }
    // INVARIANT: maxHeight = tallest letter in the entire word

    // time: O(1) — single multiplication
    // space: O(1) — no allocation
    return maxHeight * word.count
}

// TEST CASES:
// let h = [1,3,1,3,1,4,1,3,2,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5]
// designerPdfViewer(h, "abc")  → 9   (maxHeight=3 for 'b', length=3)
// designerPdfViewer(h, "a")    → 1   (maxHeight=1, length=1)
