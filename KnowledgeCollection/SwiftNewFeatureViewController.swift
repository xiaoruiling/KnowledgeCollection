//
//  SwiftNewFeatureViewController.swift
//  KnowledgeCollection
//
//  Created by xiaorui on 2018/9/28.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

/// test 4.2 New Feature
///
/// 参数: e无
///
/// @since 1.0
/// @author xiaorui
class SwiftNewFeatureViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    _addCaseInterable()
    _toggle()
    _testRemoveAllItems()
    _testRandomNumber()
  }
}

extension SwiftNewFeatureViewController {
  enum CompassDirection: CaseIterable {
    case west, south, east, north
  }

//  enum CompassDirection1: CaseIterable { 此时报错
//    case west, south, east, north
//    @available(*, unavailable)
//    case all
//  }

  private func _addCaseInterable() {
    let caseList = CompassDirection.allCases.map({ "\($0)" }).joined(separator: ", ")
    debugPrint("all: \(caseList)")
  }

  private func _toggle() {
    var a = [true, true]
    a[0].toggle()
    debugPrint("反转： \(a)")
  }

  private func _testRemoveAllItems() {
    var pythons = ["John", "Michael", "Graham", "Terry", "Eric", "Terry"]
    pythons.removeAll { $0.hasPrefix("Terry") }
    debugPrint("\(pythons)")
    debugPrint("\(pythons.allSatisfy({ $0.contains("r") }))")

    let numbers = [3, 7, 4, -2, 9, -6, 10, 1]
    if let lastNegative = numbers.last(where: { $0 < 10 }) {
      print("The last negative number is \(lastNegative).")
    }

    if let lastIndex = numbers.lastIndex(of: 10) {
      debugPrint("lastIndex: \(lastIndex)")
    }

    if let lastWhereIndex = numbers.lastIndex(where: { $0 < 10 }) {
      debugPrint("lastWhereIndex: \(lastWhereIndex)")
    }

    if let firstIndex = numbers.firstIndex(of: 4) {
      debugPrint("firstIndex: \(firstIndex)")
    }

    if let firstWhereIndex = numbers.firstIndex(where: { $0 < 7 && $0 >= 4 }) {
      debugPrint("firstWhereIndex: \(firstWhereIndex)")
    }
  }

  private func _testRandomNumber() {
    func coinToss(count tossCount: Int) -> (heads: Int, tails: Int) {
      var tally = (heads: 0, tails: 0)
      for _ in 0..<tossCount {
        let isHeads = Bool.random()
        if isHeads {
          tally.heads += 1
        } else {
          tally.tails += 1
        }
      }
      return tally
    }

    let (heads, tails) = coinToss(count: 100)
    print("100 coin tosses — heads: \(heads), tails: \(tails)")

    let emotions = "😀😂😊😍🤪😎😩😭😡"
    let randomEmotion = emotions.randomElement()!
    debugPrint("randomEmotion: \(randomEmotion)")

    let numbers = 1...10
    let shuffled = numbers.shuffled()
    debugPrint("shuffled: \(shuffled)")
  }
}
