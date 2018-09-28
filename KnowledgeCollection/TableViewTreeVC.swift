//
//  TableViewTreeVC.swift
//  Test
//
//  Created by xiaorui on 2018/4/16.
//  Copyright © 2018年 Worktile. All rights reserved.
//

import UIKit

/// TableView 分层级
class TableViewTreeVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    
    let tableview = UITableView()
    tableview.delegate = self
    tableview.dataSource = self
    tableview.rowHeight = 56
    tableview.register(TableViewTreeCell.self, forCellReuseIdentifier: "id")
    
    view.addSubview(tableview)
    tableview.snp.makeConstraints { (make) in
      make.leading.trailing.top.bottom.equalTo(0)
    }
  }
}

extension TableViewTreeVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! TableViewTreeCell
    return cell
  }
}

extension TableViewTreeVC {
  class TableViewTreeCell: UITableViewCell {
    
    // MARK: - Private
    
    private var _iconImageView: UIImageView
    private var _titleLabel: UILabel
    private var _arrowBtn: UIButton

    
    // MARK: - Lifecycle
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      
      _iconImageView = UIImageView()
      _iconImageView.backgroundColor = UIColor.cyan
      
      _titleLabel = UILabel()
      _titleLabel.textColor = UIColor.black
      _titleLabel.font = UIFont.systemFont(ofSize: 18)
      
      _arrowBtn = UIButton()
      _arrowBtn.backgroundColor = UIColor.green
      
      super.init(style: style, reuseIdentifier: reuseIdentifier)      
      
      contentView.addSubview(_iconImageView)
      _iconImageView.snp.makeConstraints { (make) in
        make.leading.equalTo(15)
        make.centerY.equalTo(contentView.snp.centerY)
      }
      contentView.addSubview(_titleLabel)
      _titleLabel.snp.makeConstraints { (make) in
        make.leading.leading.equalTo(_iconImageView.snp.trailing).offset(15)
        make.centerY.equalTo(contentView.snp.centerY)
      }
      contentView.addSubview(_arrowBtn)
      _arrowBtn.snp.makeConstraints { (make) in
        make.leading.equalTo(-15)
        make.leading.equalTo(_titleLabel.snp.trailing)
        make.width.height.equalTo(44)
        make.centerY.equalTo(contentView.snp.centerY)
      }
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    func setupDataSource(_ dataSource: String, offset: CGFloat) {
      
      _titleLabel.text = dataSource
      _iconImageView.snp.remakeConstraints { (make) in
        make.leading.equalTo(offset)
      }
    }
    
    override func draw(_ rect: CGRect) {
      guard let context = UIGraphicsGetCurrentContext() else { return }
      debugPrint("\(context)")
      //    context?.setStrokeColor(UIColor(hexString: "#f1f1f1").cgColor)
      
      let path = CGMutablePath()
      path.move(to: CGPoint(x:100, y:0))
      path.addLine(to:CGPoint(x:100, y:56))
      context.addPath(path)
      context.setLineWidth(10)
      context.setStrokeColor(UIColor.red.cgColor)
      context.strokePath()
    }
  }
}
