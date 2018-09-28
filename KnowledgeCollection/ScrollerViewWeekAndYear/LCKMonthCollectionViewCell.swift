//
//  LCKMonthCollectionViewCell.swift
//  Test
//
//  Created by xiaorui on 2018/5/16.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

class LCKMonthCollectionViewCell: UICollectionViewCell {
  
  var titleLabel: UILabel

  override init(frame: CGRect) {
    titleLabel = UILabel()
    titleLabel.textColor = UIColor.black
    titleLabel.font = UIFont.systemFont(ofSize: 14)
    titleLabel.numberOfLines = 0
    
    super.init(frame: frame)
    
    backgroundColor = UIColor.cyan
    
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      make.leading.top.bottom.trailing.equalTo(0)
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

