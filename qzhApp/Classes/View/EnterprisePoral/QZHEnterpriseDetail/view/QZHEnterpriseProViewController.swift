//
//  QZHEnterpriseProViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/17.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit
/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHEnterpriseProViewController: QZHBaseViewController {
    override func loadData() {
        //去掉单元格的分割线
        self.tabbelView?.separatorStyle = .none
    }
}


// MARK: -  表格数据源方法，具体的数据源方法实现，不需要 super
extension QZHEnterpriseProViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240*PX+1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1. 取 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHEnterpriseDetailProCell
        
        //2. 设置 cell
        
        cell.proLogo.image = UIImage(named:"noPic")
        
        cell.proName.text = "全开 正度 厚／硬卡纸 背景纸 模型纸 250g 400g 大张色卡纸"
        
        cell.proSpec.text = "颜色分类： 250g 浅灰 1卷"
        
        cell.proPrice.text = "¥25.20"
        
        
        
        //3. 返回 cell
        return cell
    }
}

// MARK: - 设置界面
extension QZHEnterpriseProViewController{
    override func setupUI() {
        super.setupUI()
        navigationBar.isHidden = true
        tabbelView?.frame = CGRect(x:0, y: 1, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-210*PX-2)
        
        //注册 tableView
        tabbelView?.register(UINib(nibName:"QZHEnterpriseDetailProCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        let line:QZHUILabelView = QZHUILabelView()
        
        line.divider(0, y: 0, width: Int(SCREEN_WIDTH), height: 1, color: myColor().grayF0())
        view.addSubview(line)
    }
}

// MARK: - 监听方法
extension QZHEnterpriseProViewController{

}
