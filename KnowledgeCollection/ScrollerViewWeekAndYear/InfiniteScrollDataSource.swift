//
//  InfiniteScrollDataSource.swift
//  Test
//
//  Created by xiaorui on 2018/7/10.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import Foundation

public protocol InfiniteScrollDataSource: class {
  
  func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier: String) -> Void
  func infiniteScrollView(_ infiniteScrollView: InfiniteScrollView, numberOfItemsInSection section: Int) -> Int
}
