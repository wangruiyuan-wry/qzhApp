//
//  QZHCompanyProViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/3.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHCompanyProViewController: QZHBaseViewController {
    
    // 暂无产品
    var noPro:QZHUIView = QZHUIView()

    override func loadData() {
        
    }
}

// MARK: - 设置页面样式
extension QZHCompanyProViewController{
    override func setupUI() {
        super.setupUI()
        //注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationBar.isHidden = true
        tabbelView?.separatorStyle = .none
        
        let line:QZHUILabelView = QZHUILabelView()        
        line.dividers(0, y: 0, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        view.addSubview(line)

        setupNoPro()
        noPro.isHidden = false
    }
    
    // 设置未找到企业
    func setupNoPro(){
        noPro.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 210*PX, bgColor: UIColor.white)
        noPro.isHidden = true
        self.view.addSubview(noPro)
        
        //
        let pic:UIImageView = UIImageView(frame:CGRect(x:296*PX,y:85*PX,width:158*PX,height:152*PX))
        pic.image = UIImage(named:"Market_noCompany")
        noPro.addSubview(pic)
        
        let nolabel:QZHUILabelView = QZHUILabelView()
        nolabel.setLabelView(229*PX, 270*PX, 292*PX, 50*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 36, "暂无产品")
        nolabel.alpha = 0.5
        noPro.addSubview(nolabel)
        tabbelView?.tableHeaderView = noPro
    }
}

// MARK: - 数据源绑定
extension QZHCompanyProViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    /// 捕捉滚动条动作
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}


