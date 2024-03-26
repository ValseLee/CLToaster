//
//  CLToastManager.swift
//
//
//  Created by Celan on 3/26/24.
//

import Foundation

protocol CLToastRepository {
  func dequeue() -> CLToastUIKitData?
}

final class CLToastManager: CLToastRepository {
  fileprivate(set) var priorityQueue = PriorityQueue<CLToastUIKitData>(order: <)
  func dequeue() -> CLToastUIKitData? {
    priorityQueue.removeFirst()
  }
  
  func enqueue(data: CLToastUIKitData) {
    priorityQueue.push(data)
  }
}
