//
//  UsageVC.swift
//  Test
//
//  Created by xiaorui on 2018/4/9.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

class UsageVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.gray
    
    _testSubscripts()
  }
}

extension UsageVC {
  
  private func _testSubscripts() {
    let testSub = TestSubscripts()
    testSub[.report] = "report"
    
    let subscriptsLable = UILabel(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 50))
    subscriptsLable.text = testSub[.report]
    subscriptsLable.textAlignment = .center
    subscriptsLable.textColor = UIColor.red
    subscriptsLable.backgroundColor = UIColor.cyan
    view.addSubview(subscriptsLable)
  }
}

extension UsageVC {
  
  // MARK: - Struct custom array
  
  struct Countdown: Sequence, IteratorProtocol {
    var count: Int
  
    mutating func next() -> Int? {
      if count == 0 {
        return nil
      } else {
        defer { count -= 1 }
        return count
      }
    }
  
  //  func makeIterator() -> Countdown {
  //    return Countdown(count: count)
  //  }
  }
  
  private func _testStructArray() {
    let threeToGo = Countdown(count: 7)
    for i in threeToGo {
      print(i)
    }
    
    let bb = threeToGo.reversed()
    debugPrint("\(bb)")
  }

  
  // MARK: - Enum custom array
  
  private func _testEnumArray() {
    for item in Card.cases() {
      debugPrint("\(item.rawValue)")
    }
  }
}

enum Card: String {
  case red = "♥"
  case black = "♠"
  case squre = "♦"
  case flower = "♣"
}

extension Card {
  static func cases() -> AnySequence<Card> {
    typealias S = Card
    return AnySequence { () -> AnyIterator<S> in
      var raw = 0
      return AnyIterator {
        let current : Card = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
        guard current.hashValue == raw else { return nil }
        raw += 1
        return current
      }
    }
  }
}

 // Classes, structures, and enumerations
class TestSubscripts {
  
  enum ApplicationType {
    case task
    case driver
    case calendar
    case report
  }
  
  private var datas: [ApplicationType: String] = [:]
  
  subscript(_ type: ApplicationType) -> String {
    
    set(newValue) {
      datas[type] = newValue
    }
    
    get {
      return datas[type] ?? "default"
    }
  }
}
