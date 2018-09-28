//
//  CodeViewController.swift
//  Test
//
//  Created by xiaorui on 2018/9/12.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .white
      
      let codeView = AuthenticationCodeView(frame: .zero)
      codeView.codeNum = 4

      view.addSubview(codeView)
      codeView.snp.makeConstraints { (make) in
        make.leading.equalTo(32)
        make.trailing.equalTo(-32)
        make.top.equalTo(100)
        make.height.equalTo(64)
      }
      
//      let code = CodeView(frame: CGRect(x: 63, y: 100, width: (UIScreen.main.bounds.width - 63) * 2, height: 40))
//
//      //Change Basic Attributes
//      /*
//       code.Base.changeViewBasicAttributes(codeNum: 4, lineColor: UIColor.blue, lineInputColor: UIColor.black, cursorColor: UIColor.red, errorColor: UIColor.red, fontNum: UIFont.systemFont(ofSize: 20), textColor: UIColor.black)
//       or
//       */
//
//      code.Base.changeInputNum(num: 4)
//
//      //To obtain Input Text
//      code.callBacktext = { str in
//        if str == "1234" {
//
//        } else {
//          code.clearnText(error: "error")
//        }
//      }
//      view.addSubview(code)
    }
}
