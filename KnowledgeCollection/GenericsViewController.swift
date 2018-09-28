//
//  GenericsViewController.swift
//  Test
//
//  Created by xiaorui on 2018/9/27.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

class GenericsViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "泛型test"
//    _testGenericsFunction()
//    _testCustomGenerics()
//    _testFindIndex()
    _testAssociated()
  }
}

extension GenericsViewController {

  // MARK: - generics function
  func swapValue<T>(_ a: inout T, _ b: inout T) {
    let tempA = a
    a = b
    b = tempA
  }

  func _testGenericsFunction() {
    var a1 = 2
    var b1 = 10
    swapValue(&a1, &b1)
    debugPrint("a1: \(a1), b1: \(b1)")
  }
}

extension GenericsViewController {

  // MARK: - custom generics type（自定义泛型类型<class/struct/enum>）

  struct Stack<T> {
    var stack:[T] = []
    mutating func push(_ item: T) {
      stack.append(item)
    }

    mutating func pop() {
      stack.removeLast()
    }
  }

  func _testCustomGenerics() {
    var testStack: Stack = Stack<String>()
    testStack.push("li")
    testStack.push("rui")
    testStack.push("ling")
    testStack.pop()
    debugPrint("testStack: \(testStack)")

    debugPrint("topItem: \(testStack.topItem ?? "")")
  }
}

// 扩展泛型
extension GenericsViewController.Stack {
  var topItem: T? {
    return stack.isEmpty ? nil : stack[stack.count - 1]
  }
}

extension GenericsViewController {
  // MARK: - generics 类型约束
//  func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//    // function body goes here
//  }

  func findIndex<T: Equatable>(_ valueToFind: T, arry: [T]) -> Int? {
    for (index, value) in arry.enumerated() {
      if value == valueToFind {
        return index
      }
    }
    return nil
  }

  func _testFindIndex() {
    let arry = ["qq", "weixin", "xcode", "iPhone"]
    if let index = findIndex("weixin11", arry: arry) {
      debugPrint("找到索引： \(index)")
    } else {
      debugPrint("没有找到！")
    }
  }
}

protocol Container {
  associatedtype type
//  associatedtype Item: Equatable  // 向关联类型中添加约束
  mutating func append(_ item: type)
  var count: Int { get }
  subscript(i: Int) -> type { get }
}

extension GenericsViewController {
  // MARK: - 关联类型

  struct associatedStack<T>: Container {
    var items: [T] = []
    mutating func push(_ item: T) {
      items.append(item)
    }

    mutating func pop() {
      items.removeLast()
    }

    typealias type = T

    mutating func append(_ item: T) {
      self.push(item)
    }

    var count: Int {
      return items.count
    }

    subscript(i: Int) -> T {
      return items[i]
    }
  }

  func _testAssociated() {
    var testStack = associatedStack<Int>()
    testStack.push(1)
    testStack.append(2)
    testStack.push(3)
    testStack.push(4)
    testStack.pop()

    debugPrint("testStack count: \(testStack)")
    debugPrint("testStack: \(testStack)")
    debugPrint("testStack subscript: \(testStack[1])")
  }
}

extension GenericsViewController {

  // MARK: - Generics where 语句 用法

  // 1. func allItemsMatch<C1: Container, C2: Container>
  //    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
  //    where C1.Item == C2.Item, C1.Item: Equatable {}

  // 2. extension Stack where Element: Equatable {}  item必须符合Equatable协议

  // 3. extension Container where Item == Double {}  一个泛型where分句，要求Item是特定类型

  // 4. associatedtype Iterator: IteratorProtocol where Iterator.Element == Item  向继承的关联类型添加约束
}
