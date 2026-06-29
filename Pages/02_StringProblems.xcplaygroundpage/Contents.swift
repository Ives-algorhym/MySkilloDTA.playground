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

func isPalindromeTwoPointers(_ s: String) -> Bool {
    var array: [Character] = Array(s)

    var l = 0
    var r = array.count - 1

    while l < r {
        if array[l] != array[r] {
            return false
        }

        l += 1
        r -= 1
    }
    return true
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


// ============================================================
// PROBLEM 4: Is Anagram
// LEVEL: Medium
// TIME: O(n log n) brute force → O(n) optimal
// ============================================================

// DESCRIPTION:
// Given two strings, return true if one is an anagram of the other.
// An anagram uses all the same characters, same counts, any order.

// Input:  "listen", "silent" → true
// Input:  "hello",  "world"  → false
// Input:  "rat",    "car"    → false

// MENTAL MODEL (brute force):
// Convert both strings to character arrays, sort both, compare.
// If sorted arrays are equal, same characters same counts — anagram.

// CONSTRAINTS: strings contain only lowercase letters
// EDGE CASES: different lengths (early exit), single character, identical strings

func isAnagramBrute(_ s: String, _ t: String) -> Bool {
    // early exit — different lengths can't be anagrams
    // time: O(1) | space: O(1)
    guard s.count == t.count else { return false }

    // time: O(n) — converts each string to character array
    // space: O(n) — two arrays of n characters each
    let sortedS = Array(s).sorted()
    let sortedT = Array(t).sorted()

    // time: O(n) — compares element by element
    // space: O(1) — no extra allocation
    return sortedS == sortedT
}

// TEST CASES:
// isAnagramBrute("listen", "silent") → true
// isAnagram("listen", "silent")      → true
// isAnagram("hello", "world")        → false
// isAnagram("rat", "car")            → false
// isAnagram("a", "a")                → true

// ============================================================
// PROBLEM 5: Caesar Cipher
// LEVEL: Medium
// TIME: O(n) | SPACE: O(n)
// ============================================================

// MENTAL MODEL:
// Walk each character. If it's a letter, map it to position 0–25
// by subtracting its base ASCII value (65 uppercase, 97 lowercase).
// Add k, wrap with % 26, add base back to get the shifted character.
// Non-letters pass through unchanged. Case is preserved.

// CONSTRAINTS: k can be any positive integer (% 26 handles values > 25)
// EDGE CASES: non-letter characters unchanged, uppercase and lowercase handled separately

// Input:  "middle-Outz", k=2  → "okffng-Qwvb"
// Input:  "xyz",          k=2  → "zab"
// Input:  "Hello, World!", k=5 → "Mjqqt, Btwqi!"

func caesarCipher(_ s: String, _ k: Int) -> String {

    // time: O(n) — converts string to character array
    // space: O(n) — array of n characters
    let chars = Array(s)

    // time: O(1) — empty array creation
    // space: O(n) — grows to hold all n shifted characters
    var result: [Character] = []

    // time: O(n) — visits every character once
    // space: O(1) — no extra allocation per iteration
    // INVARIANT: result contains the correctly shifted characters for all positions before current
    for ch in chars {

        if ch.isLetter {
            // base = 65 for uppercase, 97 for lowercase
            // time: O(1)
            let base: UInt8 = ch.isUppercase ? 65 : 97

            // map to 0–25, shift, wrap, map back
            // time: O(1) — arithmetic only
            let position  = Int(ch.asciiValue!) - Int(base)
            let shifted   = (position + k) % 26
            let finalASCII = shifted + Int(base)

            // convert back to Character
            // time: O(1)
            result.append(Character(UnicodeScalar(finalASCII)!))

        } else {
            // non-letter passes through unchanged
            // time: O(1)
            result.append(ch)
        }
    }
    // INVARIANT: result contains every character shifted or passed through

    // time: O(n) — builds string from character array
    return String(result)
}

// TEST CASES:
// caesarCipher("middle-Outz", 2)   → "okffng-Qwvb"
// caesarCipher("xyz", 2)            → "zab"
// caesarCipher("Hello, World!", 5)  → "Mjqqt, Btwqi!"
// caesarCipher("abc", 3)            → "def"

// ============================================================
// PROBLEM 6: Valid Bracket Validation
// LEVEL: Medium
// TIME: O(n) | SPACE: O(n)
// ============================================================

// MENTAL MODEL:
// Use a stack. Walk each character.
// Opening bracket → push onto stack.
// Closing bracket → check top of stack matches the expected opener.
//   If match → pop. If mismatch or stack empty → invalid, return false.
// At the end, stack must be empty — leftover openers mean unmatched brackets.

// CONSTRAINTS: string contains only bracket characters
// EDGE CASES: empty string (valid), only openers, only closers, interleaved wrong types

// Input:  "()[]{}"  → true
// Input:  "([{}])"  → true
// Input:  "(]"      → false  (wrong closing bracket type)
// Input:  "([)]"    → false  (interleaved incorrectly)
// Input:  "{[]"     → false  (unclosed opener)

func bracketValidation(_ s: String) -> Bool {

    // map each closer to its expected opener
    // time: O(1) | space: O(1) — fixed 3 entries
    let pairs: [Character: Character] = [
        ")": "(",
        "]": "[",
        "}": "{"
    ]

    // stack holds unmatched openers seen so far
    // time: O(1) | space: O(n) — grows with unmatched openers
    var stack: [Character] = []

    // time: O(n) — visits every character once
    // space: O(1) — no extra allocation per iteration
    // INVARIANT: stack contains all unmatched opening brackets seen so far, in order
    for ch in s {

        if ch == "(" || ch == "[" || ch == "{" {
            // opening bracket — push and wait for its closer
            // time: O(1)
            stack.append(ch)

        } else if let expected = pairs[ch] {
            // closing bracket — top of stack must be the matching opener
            // time: O(1)
            if stack.last == expected {
                stack.removeLast()  // matched — pop the opener
            } else {
                return false        // mismatch or empty stack — invalid
            }
        }
    }
    // INVARIANT: stack is empty only if every opener was matched and closed in order

    // any remaining openers were never closed
    return stack.isEmpty
}

// TEST CASES:
// bracketValidation("()[]{}")  → true
// bracketValidation("([{}])")  → true
// bracketValidation("(]")      → false
// bracketValidation("([)]")    → false
// bracketValidation("{[]")     → false


// ============================================================
// PROBLEM 7: Ransom Note
// LEVEL: Medium
// TIME: O(n + m) | SPACE: O(1)  where n = magazine length, m = note length
// ============================================================

// MENTAL MODEL:
// Build a frequency map from the magazine — every character it contains.
// Walk the ransom note, decrementing each character's count.
// If a character is missing or count hits zero, the note can't be built.

// CONSTRAINTS: strings contain only lowercase letters
// EDGE CASES: note longer than magazine, repeated characters in note

// Input:  ransomNote="aa", magazine="aab"  → true
// Input:  ransomNote="aa", magazine="ab"   → false  (only one 'a' in magazine)
// Input:  ransomNote="a",  magazine="b"    → false

func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {

    // build frequency map from magazine
    // time: O(n) | space: O(1) — at most 26 keys
    // INVARIANT: dic[ch] = number of times ch is still available from magazine
    var dic: [Character: Int] = [:]
    for ch in magazine {
        dic[ch, default: 0] += 1
    }

    // walk ransom note — consume one count per character needed
    // time: O(m) | space: O(1) — no extra allocation
    // INVARIANT: dic[ch] reflects remaining available count of ch after processing note so far
    for ch in ransomNote {
        if let count = dic[ch], count > 0 {
            dic[ch] = count - 1   // consume one from available supply
        } else {
            return false          // character missing or exhausted
        }
    }
    // INVARIANT: every character in ransomNote was available in magazine

    return true
}

// TEST CASES:
// canConstruct("aa", "aab")  → true
// canConstruct("aa", "ab")   → false
// canConstruct("a", "b")     → false
