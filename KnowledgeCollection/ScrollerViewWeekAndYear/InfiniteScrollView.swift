//
//  LCKMonthAndYearCalendarView.swift
//  Test
//
//  Created by xiaorui on 2018/5/16.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

public class InfiniteScrollView: UIView {

  
  // MARK: - Public
  
  var maxPageNum: Int = 3
  var maxItemNum: Int = 4
  
 
  // MARK: - Private
  
  private let kMonthCellId = "month_cell_id"

  private var _calendarFlowLayout: UICollectionViewFlowLayout
  private var _calendarCollectionView: UICollectionView
  
  private var _dates: [String] = []
  private var _index: Int = 1
  
  
  override init(frame: CGRect) {
    _calendarFlowLayout = UICollectionViewFlowLayout()
    _calendarFlowLayout.scrollDirection = .horizontal
    _calendarFlowLayout.minimumLineSpacing = CGFloat.leastNormalMagnitude
    _calendarFlowLayout.minimumInteritemSpacing = CGFloat.leastNormalMagnitude
    
    _calendarCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0), collectionViewLayout: _calendarFlowLayout)
    _calendarCollectionView.isPagingEnabled = true
    _calendarCollectionView.backgroundColor = UIColor.white
    _calendarCollectionView.bounces = false
    _calendarCollectionView.showsHorizontalScrollIndicator = false
    _calendarCollectionView.showsVerticalScrollIndicator = false
    
    super.init(frame: frame)
    
    _calendarCollectionView.delegate = self
    _calendarCollectionView.dataSource = self
    _calendarCollectionView.register(LCKMonthCollectionViewCell.self, forCellWithReuseIdentifier: kMonthCellId)
    
    addSubview(_calendarCollectionView)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(_didReceviedNotification(_:)),
                                           name: UIDevice.orientationDidChangeNotification,
                                           object: nil)
    
    _dates = ((_index - 1) * maxItemNum..<(_index * maxItemNum + (maxPageNum * maxItemNum) - 1 )).map({ "dfdfdfd\($0 + 1)" })
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
    _resetCollectionViewFrame()
    _calendarCollectionView.contentOffset = CGPoint(x: UIScreen.main.bounds.width, y: 0)
  }
}

extension InfiniteScrollView: UICollectionViewDelegate, UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return _dates.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMonthCellId, for: indexPath) as! LCKMonthCollectionViewCell
    cell.titleLabel.textAlignment = .center
    cell.titleLabel.text = _dates[indexPath.row]
    return cell
  }
}

extension InfiniteScrollView {
  
  // MARK: - UIScrollViewDelegate
  
  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
    if _index <= 1 { return }
    if (scrollView.contentOffset.x > UIScreen.main.bounds.width) {
      _index += 1
    } else if scrollView.contentOffset.x == UIScreen.main.bounds.width {
      return
    } else {
      _index -= 1
    }
    _dates.removeAll()
    _dates = ((_index * 4 - 1)..<(_index * 4 + 11)).map({ "fddjkf\($0 + 1)" })
    _calendarCollectionView.reloadData()
    _calendarCollectionView.contentOffset = CGPoint(x: UIScreen.main.bounds.width, y: 0)
  }
}

extension InfiniteScrollView {
  
  // MARK: - Utils

  private func _resetCollectionViewFrame() {
    _calendarFlowLayout.itemSize = CGSize(width: bounds.width / CGFloat(maxItemNum), height: 80)
    _calendarCollectionView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 80)
    _calendarCollectionView.contentSize = CGSize(width: bounds.width * CGFloat(maxPageNum) , height: 80)
  }
}

extension InfiniteScrollView {
  
  // MARK: - Event
  @objc
  private func _didReceviedNotification(_ notification: Notification) {
    if notification.name == UIDevice.orientationDidChangeNotification {
      _calendarFlowLayout.invalidateLayout()
    }
  }
}
