//
//  EnumTestViewController.swift
//  Test
//
//  Created by xiaorui on 2018/8/24.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

/**
 Swift 标准库中的eum 类型  optional(some(值)、none)
                        process
*/

class EnumTestViewController: UIViewController {
  
  private var _label: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    _label = UILabel(frame: CGRect(x: 100, y: 100, width: 300, height: 500))
    _label.textColor = .black
    view.addSubview(_label)
    
    _testEnum()
    debugPrint("我是好人2")
  }
  
  func _testEnum() { // 枚举的递归
    let str1 = ArithmeticExpression.str("xiaorui")
    let str2 = ArithmeticExpression.str("是好人")
    let addtion = ArithmeticExpression.addition(str1, str2)
    let mutil = ArithmeticExpression.multiplication(addtion, str1)
    _label.text = mutil.result()
  }
}
