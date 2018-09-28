//
//  OneClockVC.swift
//  Test
//
//  Created by xiaorui on 2018/3/27.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

// OneClock的翻页时钟效果是如何实现的
class OneClockVC: UIViewController {
  
  private var viewX: UIView!
  private var viewY: UIView!
  
  private var viewA: UIView!
  private var ViewB: UIView!
  private var ViewC: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func _setupAppearence() {
    view.backgroundColor = UIColor.black
  }
}



extension Bundle {
  class var current: Bundle {
    let caller = Thread.callStackReturnAddresses[1]
    
    if let bundle = _cache.object(forKey: caller) {
      return bundle
    }
    
    var info = Dl_info(dli_fname: "", dli_fbase: nil, dli_sname: "", dli_saddr: nil)
    dladdr(caller.pointerValue, &info)
    let imagePath = String(cString: info.dli_fname)
    
    for bundle in Bundle.allBundles + Bundle.allFrameworks {
      if let execPath = bundle.executableURL?.resolvingSymlinksInPath().path,
        imagePath == execPath {
        _cache.setObject(bundle, forKey: caller)
        return bundle
      }
    }
    fatalError("Bundle not found for caller \"\(String(cString: info.dli_sname))\"")
  }
  
  private static let _cache = NSCache<NSNumber, Bundle>()
}
