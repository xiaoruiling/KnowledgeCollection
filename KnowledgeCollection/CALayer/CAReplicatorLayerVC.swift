//
//  CAReplicatorLayerVC.swift
//  Test
//
//  Created by xiaorui on 2018/3/27.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

/// CAReplicatorLayer --- 复制图层
class CAReplicatorLayerVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    _setupAppearence()
    _setupAppearence1()
  }
  
  func _setupAppearence() {
    view.backgroundColor = UIColor.white
    
    let animationView = UIView(frame: CGRect(x: 0, y: 64, width: 200, height: 200))
    animationView.backgroundColor = UIColor.lightGray
    view.addSubview(animationView)
    
    let animationLayer = CAShapeLayer()
    animationLayer.backgroundColor = UIColor.cyan.cgColor
    animationLayer.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
    animationLayer.cornerRadius = 10
    animationLayer.position = CGPoint(x: animationView.bounds.width / 2, y: animationView.bounds.height / 2)
    
    let transformAnim = CABasicAnimation(keyPath: "transform")
    transformAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(10, 10, 1))
    transformAnim.duration = 2
    
    let aplaAnim = CABasicAnimation(keyPath: "opacity")
    aplaAnim.toValue = 0
    aplaAnim.duration = 2
    
    let animGroup = CAAnimationGroup()
    animGroup.animations = [transformAnim, aplaAnim]
    animGroup.duration = 2
    animGroup.repeatCount = HUGE
    animationLayer.add(animGroup, forKey: nil)
    
    let replicatorLayer = CAReplicatorLayer()
    replicatorLayer.addSublayer(animationLayer)
    replicatorLayer.instanceCount = 5
    replicatorLayer.instanceDelay = 0.3
//    replicatorLayer.instanceRedOffset = -0.3
//    replicatorLayer.instanceBlueOffset = -0.5
//    replicatorLayer.instanceGreenOffset = -0.3
    animationView.layer.addSublayer(replicatorLayer)
  }
  
  func _setupAppearence1() {
    view.backgroundColor = UIColor.white
    
    let animationView = UIView(frame: CGRect(x: 0, y: 270, width: 300, height: 300))
    animationView.backgroundColor = UIColor.lightGray
    view.addSubview(animationView)
    
    let animationLayer = CAShapeLayer()
    animationLayer.backgroundColor = UIColor.cyan.cgColor
    animationLayer.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
    animationLayer.cornerRadius = 10
    animationLayer.position = CGPoint(x: animationView.bounds.width / 2, y: 50)
    animationLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
    
    let transformAnim = CABasicAnimation(keyPath: "transform")
    transformAnim.fromValue = NSValue(caTransform3D: CATransform3DMakeScale(1, 1, 1))
    transformAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(0.1, 0.1, 0.1))
    transformAnim.duration = 2
    transformAnim.repeatCount = HUGE
    
    animationLayer.add(transformAnim, forKey: nil)
    
    let replicatorLayer = CAReplicatorLayer()
    replicatorLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
    replicatorLayer.addSublayer(animationLayer)
    replicatorLayer.instanceCount = 20
    replicatorLayer.instanceDelay = 0.1
    replicatorLayer.instanceRedOffset = -0.3
    replicatorLayer.instanceBlueOffset = -0.2
    replicatorLayer.instanceGreenOffset = -0.1
    replicatorLayer.instanceAlphaOffset = -0.05
    let angle = CGFloat(2 * Double.pi) / CGFloat(20)
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1.0)
    animationView.layer.addSublayer(replicatorLayer)
  }
  
}
