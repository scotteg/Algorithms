//: ## Sorting
import Foundation

let randomArray = randomIntArray(100)

run(.sorted) {
    // Source: https://github.com/apple/swift/blob/6c7d93491fe2bf42553fbccff529aeddc938796c/stdlib/public/core/CollectionAlgorithms.swift.gyb
    let array = randomArray
    array.sorted()
    array.sorted(by: >)
}

//: ### Bubble - O(n²)

extension Array where Element: Comparable {
    
    /// Returns a bubble-sorted copy - O(n²)
    ///
    /// - Parameter compare: function type that takes two Element inputs and returns a Bool (default: <)
    /// - Returns: Bubble-sorted copy of self
    func bubbleSorted(_ compare: (Element, Element) -> Bool = (<)) -> [Element] {
        guard count > 1 else { return self }
        var array = self
        let offset = array.count - 1
        
        for a in 0..<offset {
            for b in 0..<offset - a where compare(array[b + 1], array[b]) {
                array.swapAt(b, b + 1)
            }
        }
        
        return array
    }
    
    /// Bubble sorts in place - O(n²)
    ///
    /// - Parameter comparator: function type that takes two Element inputs and returns a Bool (default: <)
    mutating func bubbleSort(_ compare: (Element, Element) -> Bool = (<)) {
        self = bubbleSorted(compare)
    }
}

run(.bubbleSorted) {
    let array = randomArray
    array.bubbleSorted()
    array.bubbleSorted(>)
}

//: ### Insertion - O(n²)

extension Array where Element: Comparable {
    
    /// Returns an insertion-sorted copy - O(n²)
    ///
    /// - Parameter compare: function type that takes two Element inputs and returns a Bool (default: <)
    /// - Returns: Insertion-sorted copy of self
    func insertionSorted(_ compare: (Element, Element) -> Bool = (<)) -> [Element] {
        guard count > 1 else { return self }
        var array = self
        
        for a in 1..<array.count {
            var b = a
            let value = array[b]
            
            while b > 0 && compare(value, array[b - 1]) {
                array[b] = array [b - 1]
                b -= 1
            }
            
            array[b] = value
        }
        
        return array
    }
    
    /// Insertion sorts in place - O(n²)
    ///
    /// - Parameter compare: function type that takes two Element inputs and returns a Bool (default: <)
    mutating func insertionSort(_ compare: (Element, Element) -> Bool = (<)) {
        self = insertionSorted(compare)
    }
}

run(.insertionSorted) {
    let array = randomArray
    array.insertionSorted()
    array.insertionSorted(>)
}

//: ### Selection - O(n²)

extension Array where Element: Comparable {
    
    /// Returns a selection-sorted copy - O(n²)
    ///
    /// - Parameter compare: function type that takes two Element inputs and returns a Bool (default: <)
    /// - Returns: Insertion-sorted copy of self
    func selectionSorted(_ compare: (Element, Element) -> Bool = (<)) -> [Element] {
        guard count > 1 else { return self }
        var array = self
        
        for a in 0..<array.count - 1 {
            var b = a
            
            for c in a + 1..<array.count where compare(array[c], array[b]) {
                b = c
            }
            
            guard a != b else { continue }
            array.swapAt(a, b)
        }
        
        return array
    }
    
    /// Selection sorts in place - O(n²)
    ///
    /// - Parameter compare: function type that takes two Element inputs and returns a Bool (default: <)
    mutating func selectionSort(_ compare: (Element, Element) -> Bool = (<)) {
        self = selectionSorted(compare)
    }
}

run(.selectionSorted) {
    let array = randomArray
    array.selectionSorted()
    array.selectionSorted(>)
}

//: ### Merge - O(n log n)

extension Array where Element: Comparable {
    
    private func _merge(_ left: [Element], _ right: [Element], _ compare: (Element, Element) -> Bool = (<)) -> [Element] {
        var array = [Element]()
        var l = left
        var r = right
        
        while l.count > 0 && r.count > 0 {
            let first = l[0]
            let second = r[0]
            
            if compare(first, second) {
                array.append(first)
                l.remove(at: 0)
            } else {
                array.append(second)
                r.remove(at: 0)
            }
        }
        
        return array + l + r
    }
    
    private func _mergeSorted(_ compare: (Element, Element) -> Bool = (<)) -> [Element] {
        guard count > 1 else { return self }
        var array = self
        let left = Array(array[..<Int(array.count / 2)])
        let right = Array(array[Int(array.count / 2)..<array.count])
        return _merge( left._mergeSorted(compare), right._mergeSorted(compare), compare)
    }
    
    /// Returns a merge-sorted copy - O(n log n)
    ///
    /// - Parameter compare: function type that takes two Element inputs and returns a Bool (default: <)
    /// - Returns: Merge-sorted copy of self
    func mergeSorted(_ compare: (Element, Element) -> Bool = (<)) -> [Element] {
        guard count > 1 else { return self }
        let array = self
        return array._mergeSorted(compare)
    }
    
    /// Merge sorts in place - O(n log n)
    ///
    /// - Parameter compare: function type that takes two Element inputs and returns a Bool (default: <)
    mutating func mergeSort(_ compare: (Element, Element) -> Bool = (<)) {
        self = mergeSorted(compare)
    }
}

run(.mergeSorted) {
    let array = randomArray
    array.mergeSorted()
    array.mergeSorted(>)
}

//: ### Quick - O(n log n) to O(n²)

extension Array where Element: Comparable {
    
    /// Returns a quick-sorted copy - O(n²) to O(n log n)
    ///
    /// - Parameter compare: function type that takes two Element inputs and returns a Bool (default: <)
    /// - Returns: Quick-sorted copy of self
    func quickSorted(_ compare: (Element, Element) -> Bool = (<)) -> [Element] {
        guard count > 1 else { return self }
        var array = self
        
        let pivot = array.remove(at: 0)
        let left = array.filter { compare($0, pivot) }
        let right = array.filter { compare($0, pivot) == false }
        let middle = [pivot]
        
        return left.quickSorted(compare) + middle + right.quickSorted(compare)
    }
    
    /// Quick sorts in place - O(n²) to O(n log n)
    ///
    /// - Parameter compare: function type that takes two Element inputs and returns a Bool (default: <)
    mutating func quickSort(_ compare: (Element, Element) -> Bool = (<)) {
        self = quickSorted(compare)
    }
}

run(.quickSorted) {
    let array = randomArray
    array.quickSorted()
    array.quickSorted(>)
}

//: ### Verify

do {
    let sorted = randomArray.sorted()
    let sortedDesc = randomArray.sorted(by: >)
    let bubbleSorted = randomArray.bubbleSorted()
    let bubbleSortedDesc = randomArray.bubbleSorted(>)
    let insertionSorted = randomArray.insertionSorted()
    let insertionSortedDesc = randomArray.insertionSorted(>)
    let selectionSorted = randomArray.selectionSorted()
    let selectionSortedDesc = randomArray.selectionSorted(>)
    let mergeSorted = randomArray.mergeSorted()
    let mergeSortedDesc = randomArray.mergeSorted(>)
    let quickSorted = randomArray.quickSorted()
    let quickSortedDesc = randomArray.quickSorted(>)
    
    let verified = sorted == bubbleSorted &&
        sorted == insertionSorted &&
        sorted == selectionSorted &&
        sorted == mergeSorted &&
        sorted == quickSorted &&
        sortedDesc == bubbleSortedDesc &&
        sortedDesc == insertionSortedDesc &&
        sortedDesc == selectionSortedDesc &&
        sortedDesc == mergeSortedDesc &&
        sortedDesc == quickSortedDesc
    
    print(verified ? "Verified" : "NOT verified")
}

//: [Next](@next)
