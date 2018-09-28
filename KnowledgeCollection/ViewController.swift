//
//  ViewController.swift
//  Test
//
//  Created by xiaorui on 2018/3/27.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - Private
  
  private var _tableView: UITableView!
  private var _data: [TestData] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    _setupAppearence()
    _setupDataSource()
    debugPrint("我是好人2")

  }
  
  func _setupAppearence() {
    _tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
    _tableView.delegate = self
    _tableView.dataSource = self
    _tableView.tableFooterView = UIView()
    
    view.addSubview(_tableView)
  }
  
  func _setupDataSource() {
    _data = [
      TestData(title: "CAReplicatorLayer --- 复制图层", vc: CAReplicatorLayerVC.self),
      TestData(title: "OneClock的翻页时钟效果", vc: OneClockVC.self),
      TestData(title: "draw Character --- 画文字", vc: DrawCharacterVC.self),
      TestData(title: "自定义返回按钮实现侧和 UIScreenEdgePanGestureRecognizer", vc: ScreenPanAndCustomerLeftBarItemVC.self),
      TestData(title: "画大括号和拖动", vc: DrawAndDropBraceVC.self),
      TestData(title: "一些不熟悉的用法", vc: UsageVC.self),
      TestData(title: "无限滑动的月/周和年/月控件", vc: CalendarViewController.self),
      TestData(title: "tree", vc: TableViewTreeVC.self),
      TestData(title: "Enum Test", vc: EnumTestViewController.self),
      TestData(title: "Regular Test", vc: RegularViewController.self),
      TestData(title: "code", vc: CodeViewController.self),
      TestData(title: "Generics Test", vc: GenericsViewController.self),
      TestData(title: "未完待续", vc: UIViewController.self)]
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return _data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = _data[indexPath.row].title
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if indexPath.row < (_data.count - 1) {
      let vc: UIViewController = _data[indexPath.row].vc.init()
      vc.title = _data[indexPath.row].title
      navigationController?.pushViewController(vc, animated: true)
    }
  }
}

extension ViewController {
  struct TestData {
    let title: String
    let vc: UIViewController.Type
  }
}

