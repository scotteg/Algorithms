import Foundation

public enum AlgoType: String {
    
    // Sorting
    case sorted, bubbleSorted, insertionSorted, selectionSorted, mergeSorted, quickSorted
    
    // Searching
    case indexOf, linearSearch, binarySearchRecursively, binarySearchIteratively
}

public var randomInt: Int = {
    return Int(arc4random_uniform(1_000))
}()

public func randomIntArray(_ count: Int = 1_000) -> [Int] {
    var array = [Int]()
    
    (0..<count).forEach { _ in
        array.append(Int(arc4random_uniform(1_000)))
    }
    
    return array
}

public func run(_ type: AlgoType, action: () -> Void) {
    let time = Date().timeIntervalSinceReferenceDate
    action()
    print(type, Date().timeIntervalSinceReferenceDate - time)
}
