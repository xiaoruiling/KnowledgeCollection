//
//  EnumTestViewController+Addtion.swift
//  Test
//
//  Created by xiaorui on 2018/8/24.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import Foundation
import UIKit

extension EnumTestViewController {
  
  indirect enum ArithmeticExpression {
    case str(String)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
    
    func result() -> String {
      switch self {
      case let .str(str):
        return str
      case .addition(let str1, let str2):
        return "\(str1.result())\(str2.result())"
      case .multiplication(let str1, let str2):
        return "\(str1.result())/\(str2.result())"
      }
    }
  }
}
