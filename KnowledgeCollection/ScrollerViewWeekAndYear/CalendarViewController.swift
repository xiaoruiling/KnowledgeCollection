//
//  CalendarViewController.swift
//  Test
//
//  Created by xiaorui on 2018/5/16.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let calendarView = InfiniteScrollView()
    calendarView.backgroundColor = UIColor.red
    view.addSubview(calendarView)
    calendarView.snp.makeConstraints { (make) in
      make.top.equalTo(110)
      make.leading.trailing.equalTo(0)
      make.height.equalTo(110)
    }
    
    view.backgroundColor = UIColor.white
  }
}
