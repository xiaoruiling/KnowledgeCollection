//
//  RegularViewController.swift
//  Test
//
//  Created by xiaorui on 2018/8/30.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

class RegularViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "8个常用的正则表达式"
    view.backgroundColor = UIColor.white
    
    // 1. Matching a Username ( /^[a-z0-9_-]{3,16}$/ )
    //    eg: my-us3r_n4m3   √
    //        th1s1s-wayt00_l0ngt0beausrname   ×
    // 2. Matching a Password ( /^[a-z0-9_-]{6,18}$/ )
    //    eg: myp4ssw0rd    √
    //        mypa$$w0rd    ×
    // 3. Matching a Hex Value(16进制) ( /^#?([a-f0-9]{6}|[a-f0-9]{3})$/ )
    //    eg: #a3c113    √
    //        #4d82h4    ×
    // 4. Matching a Slug ( /^[a-z0-9-]+$/ )
    //    eg: my-title-here   √
    //        my_title_here   ×
    // 5. Matching an Email ( /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/ )
    //    eg: john@doe.com    √
    //        john@doe.something (TLD is too long)  ×
    // 6. Matching a URL ( /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/ )
    //    eg: http://net.tutsplus.com/about  √
    //        http://google.com/some/file!.html (contains an exclamation point)  ×
    // 7. Matching an IP Address (/^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/)
    //    eg: 73.60.124.13  √
    //        256.60.124.136  ×
    // 8. Matching an HTML Tag  ( /^<([a-z]+)([^<]+)*(?:>(.*)<\/\1>|\s+\/>)$/ )
    //    eg: Nettuts">http://net.tutsplus.com/">Nettuts+   √
    //        <img src="img.jpg" alt="My image>" /> (attributes can't contain greater than signs) ×
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
