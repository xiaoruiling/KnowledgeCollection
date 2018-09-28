//
//  TestTabbarViewController.swift
//  Test
//
//  Created by xiaorui on 2018/4/24.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

class TestTabbarViewController: UITabBarController {
  
  private var drawVC: UINavigationController!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    _setupAppearence()
  }
}

extension TestTabbarViewController {
  
  private func _setupAppearence() {
    
    let screenVC1 = ScreenPanAndCustomerLeftBarItemVC()
    let screenVC = UINavigationController(rootViewController: screenVC1)
    screenVC.tabBarItem = UITabBarItem(title: "1", image: UIImage(named: "icon_app_comment_like"), selectedImage: UIImage(named: "icon_app_comment_liked"))
    
    let drawVC1 = DrawCharacterVC()
    drawVC = UINavigationController(rootViewController: drawVC1)
    drawVC.tabBarItem = UITabBarItem(title: "2", image: UIImage(named: "icon_app_comment_like"), selectedImage: UIImage(named: "icon_app_comment_liked"))
    
    selectedIndex = 1
    delegate = self
    viewControllers = [screenVC, drawVC]
  }
}

extension TestTabbarViewController: UITabBarControllerDelegate {
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    if viewController == drawVC {
      drawVC.viewControllers.first?.title = "换货单号"
    }
  }
}


