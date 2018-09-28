//
//  ScreenPanAndCustomerLeftBarItemVC.swift
//  Test
//
//  Created by xiaorui on 2018/4/4.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

/// UIScreenEdgePanGestureRecognizer 和 自定义返回按钮之后，实现右滑
class ScreenPanAndCustomerLeftBarItemVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    
    _testCustomerLeftNav()
    _testScreenEdgePanGestureRecognizer()
  }
}

extension ScreenPanAndCustomerLeftBarItemVC {
  
  // MARK: - Customer left back Button
  
  func _testCustomerLeftNav() {
    
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
    if let image = UIImage(named: "icon_app_nav_back") {
      button.tintColor = UIColor.green
      button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    button.contentHorizontalAlignment = .left
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    button.setTitle("返回", for: .normal)
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
    button.addTarget(self, action: #selector(_backBarItemDidClick(_:)), for: .touchUpInside)
    button.setTitleColor(UIColor.green, for: .normal)
    let backBarItem = UIBarButtonItem(customView: button)
    navigationItem.leftBarButtonItems = [backBarItem]

    let target = self.navigationController?.interactivePopGestureRecognizer?.delegate
    let handle = Selector(("handleNavigationTransition:"))
    let screenEdageView = self.navigationController?.interactivePopGestureRecognizer?.view
    
    let panGesture = UIPanGestureRecognizer(target: target, action: handle)
    panGesture.delegate = self
    screenEdageView?.addGestureRecognizer(panGesture)
  }
  
  @objc
  func _backBarItemDidClick(_ btn: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}

extension ScreenPanAndCustomerLeftBarItemVC: UIGestureRecognizerDelegate {
  
  // MARK: - UIGestureRecognizerDelegate
  
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true  // 可以在这个地方进制是否开启右滑
  }
}

private var _orangeView: UIView!
private var _cycanView: UIView!

extension ScreenPanAndCustomerLeftBarItemVC {
  
  // MARK: - UIScreenEdgePanGestureRecognizer
  
  func _testScreenEdgePanGestureRecognizer() {
    
    _orangeView = UIView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 100))
    _orangeView.backgroundColor = UIColor.orange
    view.addSubview(_orangeView)
    
    _cycanView = UIView(frame: CGRect(x: 0, y: 250, width: UIScreen.main.bounds.width, height: 100))
    _cycanView.backgroundColor = UIColor.cyan
    view.addSubview(_cycanView)
    
    let orangeScreenEdgePanGes = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(_orangerGestureAction(_:)))
    orangeScreenEdgePanGes.edges = .left
    _orangeView.addGestureRecognizer(orangeScreenEdgePanGes)
    
    let cycanScreenEdgePanGes = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(_cycanGestureAction(_:)))
    cycanScreenEdgePanGes.edges = .right
    _cycanView.addGestureRecognizer(cycanScreenEdgePanGes)
  }
  
  @objc
  func _orangerGestureAction(_ gesture: UIScreenEdgePanGestureRecognizer) {
    let centerX: CGFloat = _orangeView.frame.size.width / 2
    var startX: CGFloat = 0
    
    switch gesture.state {
    case .began:
      startX = gesture.location(in: _orangeView).x
    case .changed:
      let changedX = gesture.translation(in: _orangeView).x - startX
      debugPrint("centerX: +++ \(centerX), changedX: ----------------- \(changedX)")
      _orangeView.center = CGPoint(x: centerX + changedX, y: _orangeView.center.y)
    case .ended:
      UIView.animate(withDuration: 0.3, animations: {
        _orangeView.center = CGPoint(x: centerX, y: _orangeView.center.y)
      })
    default:
      break
    }
  }
  
  @objc
  func _cycanGestureAction(_ gesture: UIScreenEdgePanGestureRecognizer) {
    let centerX: CGFloat = _cycanView.frame.size.width / 2
    var startX: CGFloat = 0
    guard let currentView = gesture.view else { return }
    
    switch gesture.state {
    case .began:
      startX = gesture.location(in: gesture.view).x

    case .changed:
      let changedX = gesture.translation(in: currentView).x - startX
      currentView.center = CGPoint(x: centerX + changedX, y: currentView.center.y)
    case .ended:
      UIView.animate(withDuration: 0.3, animations: {
        currentView.center = CGPoint(x: centerX, y: currentView.center.y)
      })
    default:
      break
    }
  }
}
