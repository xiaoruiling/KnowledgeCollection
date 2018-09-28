//
//  DrawCharacterViewController.swift
//  Test
//
//  Created by xiaorui on 2018/3/27.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

class DrawCharacterVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    _drawWorktile()
  }
  
  private func _drawWorktile() {
    
    view.backgroundColor = UIColor.darkGray
    
    // 获取字符串轮廓的 path
    let font = CTFontCreateWithName("STHeitiSC-Light" as CFString, 72, nil)
    let attrStr = NSAttributedString(string: "Worktile！",
                                     attributes: [kCTFontAttributeName as NSAttributedString.Key: font])
    let line = CTLineCreateWithAttributedString(attrStr)
    let runArray = CTLineGetGlyphRuns(line) as! [CTRun]
    
    let letters = CGMutablePath()
    
    for runIndex in 0..<CFArrayGetCount(runArray as CFArray) {
      let run: CTRun = runArray[runIndex]
      
      for runGlyphIndex in 0..<CTRunGetGlyphCount(run) {
        let thisGlyphRange = CFRangeMake(runGlyphIndex, 1)
        var glyph: CGGlyph = CGGlyph()
        var position: CGPoint = CGPoint()
        CTRunGetGlyphs(run, thisGlyphRange, &glyph)
        CTRunGetPositions(run, thisGlyphRange, &position)
        
        let letter = CTFontCreatePathForGlyph(font, glyph, nil)
        let t = CGAffineTransform(translationX: position.x, y: position.y);
        
        letters.addPath(letter!, transform: t)
      }
    }
    
    // CAShapeLayer
    let shapeLayer = CAShapeLayer()
    
    shapeLayer.path = letters               // 设置 CAShapeLayer 的 path 为上文中取出的字符串轮廓 path
    let screenSize = UIScreen.main.bounds
    shapeLayer.frame = CGRect(x: (screenSize.width-attrStr.size().width)/2,
                              y: (screenSize.height-attrStr.size().height)/2,
                              width: attrStr.size().width,
                              height: attrStr.size().height)
    shapeLayer.strokeColor = UIColor.red.cgColor
    shapeLayer.fillColor = nil
    shapeLayer.lineWidth = 1.0
    shapeLayer.isGeometryFlipped = true       // 上下翻转 ShapeLayer 的坐标系
    
    view.layer.addSublayer(shapeLayer)
    
    // CABaseAnimation
    let animation = CABasicAnimation(keyPath: "strokeEnd");  // 改变 strokeEnd 属性，创建动画
    animation.fromValue = 0.0
    animation.toValue = 1.0
    animation.duration = 5
    
    shapeLayer.add(animation, forKey: "storkeEnd")
  }
}
