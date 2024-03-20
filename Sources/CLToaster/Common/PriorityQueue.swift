//
//  PriorityQueue.swift
//
//
//  Created by Celan on 3/19/24.
//

import Foundation

public struct PriorityQueue<T: Comparable> {
//  public static func hi() {
//    let arr = [1,2,5,4,3]
//    print(PriorityQueue<Int>(order: <, startingValues: arr))
//  }
  
  fileprivate(set) var heap = [T]()
  private let ordered: (T, T) -> Bool
  
  /// Numbers of elements in Priority Queue. O(1)
  var count: Int { return heap.count }
  
  /// if the Priority Queue is empty, returns true. O(1)
  var isEmpty: Bool { return heap.isEmpty }
  
  /// Get a look at the current highest priority item, without removing it. O(1)
  ///
  /// - Returns: The element with the highest priority in the Priority Queue, or nil if the Priority Queue is empty.
  func peek() -> T? { return heap.first }
  
  /// Eliminate all of the elements from the Priority Queue, optionally replacing the order.
  mutating func clear() { heap.removeAll() }
  
  // MARK: - Lifecycle
  /// Creates a new PriorityQueue with the given custom ordering function.
  ///
  /// - Parameters:
  ///   - order: A function that specifies whether its first argument should come after the second argument in the Priority Queue. Giving `<` means Max Heap, otherwise Min Heap.
  ///   - startingValues: An array of elements to initialize the PriorityQueue with.
  init(
    order: @escaping (T, T) -> Bool,
    startingValues: [T] = []
  ) {
    self.ordered = order
    self.heap = startingValues
    
    var midIndex = heap.count / 2 - 1
    
    while midIndex >= 0 {
      sink(midIndex)
      midIndex -= 1
    }
  }
  
  // MARK: - Helpers
  /// Add a new element onto the Priority Queue. O(log n)
  ///
  /// - Parameter element: The element to be inserted into the Priority Queue.
  /// - Note: This function will **append** a element into heap Array.
  mutating func push(_ element: T) {
    heap.append(element)
    swim(heap.count - 1)
  }
  
  /// Add a new element onto a Priority Queue, limiting the size of the queue. O(n^2)
  /// If the size limit has been reached, the lowest priority element will be removed and returned.
  /// It acts like a buffer.
  ///
  /// - Parameters:
  ///   - element: The element to be inserted into the Priority Queue.
  ///   - maxCount: The Priority Queue will not grow further if its count >= maxCount.
  /// - Returns: the discarded lowest priority element, or `nil` if count < maxCount
  /// - Note: Since this is a binary heap, there is no easy way to find the lowest priority item, so this method **can be inefficient**.
  /// - Note: Also note, that only one item will be removed, even if count > maxCount by more than one.
  mutating func push(_ element: T, maxCount: Int) -> T? {
    precondition(maxCount > 0)
    
    if count < maxCount {
      push(element)
    } else if heap.count >= maxCount {
      // find the min priority element (ironically using max here)
      if let discard = heap.max(by: ordered) {
        if ordered(discard, element) { return element }
        // if
        push(element)
        remove(discard)
        return discard
      }
    }
    
    return nil
  }
  
  /// Remove and return the element with the **highest priority** or **lowest** if ascending. O(log n)
  ///
  /// - Returns: The element with the highest priority in the Priority Queue, or nil if the Priority Queue is empty.
  public mutating func pop() -> T? {
    if heap.isEmpty { return nil }
    let count = heap.count
    if count == 1 { return heap.removeFirst() }
    fastPop(newCount: count - 1)
    
    return heap.removeLast()
  }
  
  /// Removes the first occurence of a particular item. Finds it by value comparison using `==` O(n)
  /// Silently exits if no occurrence found.
  ///
  /// - Parameter item: The item to remove the first occurrence of.
  ///
  /// ## Example
  ///
  /// ```plain
  /// given: heap = [1,2,3,4,5] | remove 3 | index == 2
  /// heap[idx] goes to last position (swapAt)
  /// and pops (removeLast) then rearrange the Pritority Queue.
  /// If you removed the last item, swim doesn't get called.
  /// ```
  mutating func remove(_ item: T) {
    if let index = heap.firstIndex(of: item) {
      
      heap.swapAt(index, heap.count - 1)
      heap.removeLast()
      
      if index < heap.count {
        swim(index)
        sink(index)
      }
    }
  }
  
  /// Removes **all occurences** of a particular item.
  /// Finds it by value comparison using ==. O(n^2)
  /// Silently exits if no occurrence found.
  ///
  /// - Parameter item: The item to remove.
  mutating func removeAll(_ item: T) {
    var lastCount = heap.count
    remove(item)
    
    while heap.count < lastCount {
      lastCount = heap.count
      remove(item)
    }
  }
  
  /// Helper function for pop.
  ///
  /// Swaps the first and last elements, then sinks the first element.
  ///
  /// After executing this function, calling `heap.removeLast()` returns the popped element.
  /// - Parameter newCount: The number of elements in heap after the `pop()` operation is complete.
  private mutating func fastPop(newCount: Int) {
    var index = 0
    var heap = heap
    heap.withUnsafeMutableBufferPointer { bufferPointer in
      let _heap = bufferPointer.baseAddress! // guaranteed non-nil because count > 0
      swap(&_heap[0], &_heap[newCount])
      while 2 * index + 1 < newCount {
        var j = 2 * index + 1
        if j < (newCount - 1) && ordered(_heap[j], _heap[j+1]) { j += 1 }
        if !ordered(_heap[index], _heap[j]) { return }
        swap(&_heap[index], &_heap[j])
        index = j
      }
    }
  }
}

// MARK: - swim and sink
extension PriorityQueue {
  private mutating func sink(_ index: Int) {
    var index = index
    while 2 * index + 1 < heap.count {
      var j = 2 * index + 1
      print(#function, "SINK START", "J", j, "IDX", index)
      
      if j < (heap.count - 1) && ordered(heap[j], heap[j + 1]) { j += 1 }
      if !ordered(heap[index], heap[j]) { break }
      print(#function, "SINK END", "J", j, "IDX", index)
      heap.swapAt(index, j)
      index = j
    }
  }
  
  
  private mutating func swim(_ index: Int) {
    var index = index
    
    while index > 0 && ordered(heap[(index - 1) / 2], heap[index]) {
      print(#function, "SWIM START", "IDX", index)
      heap.swapAt((index - 1) / 2, index)
      index = (index - 1) / 2
      print(#function, "SWIM END", "IDX", index)
    }
  }
}
