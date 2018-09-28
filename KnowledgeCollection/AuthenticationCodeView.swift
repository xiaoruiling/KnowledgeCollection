//
//  AuthenticationCodeView.swift
//  Test
//
//  Created by xiaorui on 2018/9/12.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

class AuthenticationCodeView: UIView {

  // MARK: - Public
  
  var cursorColor: UIColor = .red
  var lineColor: UIColor = .green
  var codeNum: Int = 4
  var didCodeClosure: ((_ code: String) -> Void)?
  
  
  // MARK: - Private
  
  private var _textFiled: UITextField
  private var _lineArr: [UIView] = []
  private var _labelArr:[UILabel] = []
  private var _cursorArr:[CALayer] = []
  
  override init(frame: CGRect) {
    
    _textFiled = UITextField(frame: .zero)
    _textFiled.textColor = UIColor.white
    _textFiled.font = UIFont.systemFont(ofSize: 45)
    _textFiled.autocapitalizationType = .none
    _textFiled.keyboardType = .numberPad
    _textFiled.becomeFirstResponder()
    _textFiled.isHidden = true
    
    super.init(frame: frame)
    
    _textFiled.delegate = self
    _textFiled.addTarget(self, action: #selector(_textFieldDidChange(_:)), for: .editingChanged)
    addSubview(_textFiled)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    _textFiled.frame = bounds
    _createLineView()
    _createInputLabel()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    _textFiled.becomeFirstResponder()
  }
}

extension AuthenticationCodeView {
  
  // MARK: - Utils
  
  private func _createLineView() {
    for i in 0..<codeNum {
      let padding = (bounds.width - CGFloat(60 * codeNum)) / CGFloat(codeNum - 1)
      let lineView = UIView(frame: CGRect(x: CGFloat(i) * (60 + padding),
                                          y: bounds.height - 1,
                                          width: 60,
                                          height: 1))
      lineView.backgroundColor = lineColor
      addSubview(lineView)
      _lineArr.append(lineView)
    }
  }
  
  private func _createInputLabel() {
    for i in 0..<codeNum {
      let padding = (bounds.width - CGFloat(60 * codeNum)) / CGFloat(codeNum - 1)
      let label = UILabel(frame: CGRect(x: CGFloat(i) * (60 + padding),
                                        y: 0,
                                        width: 60,
                                        height: bounds.height - 1))
      label.textColor = .black
      label.font = _textFiled.font
      label.textAlignment = .center
      let path = UIBezierPath(rect: CGRect(x: (label.frame.width - 2) / 2,
                                           y: 5,
                                           width: 2,
                                           height: label.frame.height - 10))
      let lineLayer = CAShapeLayer()
      lineLayer.path = path.cgPath
      lineLayer.fillColor = cursorColor.cgColor
      addSubview(label)
      if i == 0 {
        lineLayer.isHidden = false
      } else {
        lineLayer.isHidden = true
      }
      label.layer.addSublayer(lineLayer)
      lineLayer.add(alphaChangge(), forKey: "alpha")
      _labelArr.append(label)
      _cursorArr.append(lineLayer)
    }
  }
}

extension AuthenticationCodeView: UITextFieldDelegate {
  
  // MARK: - UITextFieldDelegate
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if string == "\n" {
      textField.resignFirstResponder()
      return false
    } else if string.isEmpty {
      return true
    } else if (textField.text ?? "").count >= codeNum {
      return false
    } else {
      return true
    }
  }
}

extension AuthenticationCodeView {
  
  // MARK: - Event
  
  @objc
  private func _textFieldDidChange(_ textFiled: UITextField) {
    _labelArr.forEach { $0.text = nil }
    _cursorArr.forEach({ $0.isHidden = true })

    for i in 0..<(textFiled.text ?? "").count {
      if i < _labelArr.count {
        (_labelArr[i] as UILabel).isHidden = false
        (_labelArr[i] as UILabel).text = textFiled.text?.subString(start: i, length: 1)
      }
    }
    
    _lineArr.forEach({ $0.backgroundColor = lineColor })
    for i in 0 ..< (_textFiled.text ?? "").count {
      if i < _lineArr.count {
        (_lineArr[i] as UIView).backgroundColor = lineColor
      }
    }
    
    if (textFiled.text ?? "").count < codeNum {
      _cursorArr[(textFiled.text ?? "").count].isHidden = false
    }
    
    if (textFiled.text ?? "").count == codeNum {
      didCodeClosure?(textFiled.text ?? "")
    }
  }
}

extension AuthenticationCodeView {
  
  public func alphaChangge() -> CABasicAnimation{
    let alpheAnimation = CABasicAnimation()
    alpheAnimation.keyPath = "opacity"
    alpheAnimation.fromValue = 1.0
    alpheAnimation.toValue = 0.0
    alpheAnimation.duration = 1.0
    alpheAnimation.repeatCount = MAXFLOAT
    alpheAnimation.fillMode = CAMediaTimingFillMode.forwards
    alpheAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
    alpheAnimation.isRemovedOnCompletion = false
    return alpheAnimation
  }
  
//  public func loadShakeAnimationForView(view:UIView) {
//    let layer = view.layer
//    let point = layer.position
//    let y = CGPoint(x: point.x - 2, y: point.y)
//    let x = CGPoint(x: point.x + 2, y: point.y)
//    let animation = CABasicAnimation(keyPath: "position")
//    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//    animation.fromValue = x
//    animation.toValue = y
//    animation.autoreverses = true
//    animation.duration = 0.1
//    animation.repeatCount = 1
//    layer.add(animation, forKey: nil)
//  }
}

extension String {
  func subString(start:Int, length:Int = -1) -> String {
    var len = length
    if len == -1 {
      len = self.count - start
    }
    let st = self.index(startIndex, offsetBy:start)
    let en = self.index(st, offsetBy:len)
    return String(self[st ..< en])
  }
}
