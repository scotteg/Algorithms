//: [Previous](@previous)
//: ## Searching
import Foundation

randomInt
let sortedArray = randomIntArray(10_000).sorted()

run(.indexOf) {
    let index = sortedArray.index(of: randomInt)
    index
}

//: ### Linear - 0(1) to O(n)

extension Array where Element: Comparable {
    
    /// Linearly searches self for value - 0(1) to O(n)
    ///
    /// - Parameter value: Value to search for
    /// - Returns: Index if `value` was found, otherwise `nil`
    func linearSearch(_ value: Element) -> Int? {
        for (i, v) in self.enumerated() where v == value {
            return i
        }
        
        return nil
    }
}

run(.linearSearch) {
    let contains = sortedArray.linearSearch(randomInt)
    contains
}

//: ### Binary - 0(log n)

extension Array where Element: Comparable {
    
    /// Binary searches (recursively) self for value - 0(log n)
    ///
    /// - Parameters:
    ///   - value: Value to search for
    ///   - range: Range of self to search within
    /// - Returns: Index if `value` was found, otherwise `nil`
    func binarySearchRecursively(_ value: Element, range: Range<Int>) -> Int? {
        guard range.lowerBound < range.upperBound else { return nil }
        let mid = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        
        if self[mid] > value {
            return binarySearchRecursively(value, range: range.lowerBound..<mid)
        } else if self[mid] < value {
            return binarySearchRecursively(value, range: mid + 1..<range.upperBound)
        } else {
            return mid
        }
    }
    
    /// Binary searches (iteratively) self for value - 0(log n)
    ///
    /// - Parameters:
    ///   - value: Value to search for
    /// - Returns: Index if `value` was found, otherwise `nil`
    func binarySearchIteratively(_ value: Element) -> Int? {
        var lower = 0
        var upper = count
        
        while lower < upper {
            let mid = lower + (upper - lower) / 2
            
            if self[mid] == value {
                return mid
            } else if self[mid] < value {
                lower = mid + 1
            } else {
                upper = mid
            }
        }
        
        return nil
    }
}

run(.binarySearchRecursively) {
    let contains = sortedArray.binarySearchRecursively(randomInt, range: 0..<sortedArray.count)
    contains
}

run(.binarySearchIteratively) {
    let contains = sortedArray.binarySearchIteratively(randomInt)
    contains
}

//: ### Verify

do {
    let indexOf = sortedArray.index(of: randomInt)
    let binarySearchRecursively = sortedArray.binarySearchRecursively(randomInt, range: 0..<sortedArray.count)
    let binarySearchIteratively = sortedArray.binarySearchIteratively(randomInt)
    
    var verified = false
    
    if let indexOf = indexOf,
        let binarySearchRecursively = binarySearchRecursively,
        let binarySearchIteratively = binarySearchIteratively {
        verified = sortedArray[indexOf] == sortedArray[binarySearchRecursively] &&
            sortedArray[indexOf] == sortedArray[binarySearchIteratively]
    }
    
    print(verified ? "Verified" : "NOT verified")
    
    let count = sortedArray.filter({ $0 == randomInt }).count
    count
}
