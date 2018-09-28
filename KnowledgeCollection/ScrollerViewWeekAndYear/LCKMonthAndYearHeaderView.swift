//
//  LCKMonthAndYearHeaderView.swift
//  Test
//
//  Created by xiaorui on 2018/5/16.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

class LCKMonthAndYearHeaderView: UIView {
  
  var titleLabel: UILabel
  
  override init(frame: CGRect) {
    
    titleLabel = UILabel()
    titleLabel.textColor = UIColor.black
    titleLabel.textAlignment = .center
    titleLabel.font = UIFont.systemFont(ofSize: 14)
    titleLabel.numberOfLines = 0
    titleLabel.text = "2018年5月"
    
    super.init(frame: frame)
    
    backgroundColor = UIColor.green
    
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      make.leading.top.bottom.trailing.equalTo(0)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
