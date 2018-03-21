//
//  QZHSelAddressViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/20.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHSelAddressViewController: QZHBaseViewController {
    
    // 地址列表视图懒加载
    lazy var addressStatus = QZHAddressListViewModel()
    
    override func loadData() {
        
    }
}

// MARK: - 页面 UI 样式设置
extension QZHSelAddressViewController{
    override func setupUI() {
        super.setupUI()
        
        self.isPush = true
        // 注册原型 cell
        tabbelView?.register(UINib(nibName:"QZHAddressListTableViewCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        tabbelView?.y = 128*PX
        tabbelView?.height = SCREEN_HEIGHT - 128*PX
        tabbelView?.separatorStyle = .none
        
        setupNav()

    }
    
    // 设置导航条
    func setupNav(){
        self.title = "选择收货地址"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon2", target: self, action: #selector(self.close),color:UIColor.white)
        navItem.rightBarButtonItem = UIBarButtonItem(title: "管理", img: "", fontSize: 26, target: self, action: #selector(self.manageAction), color: myColor().gray3())
    }

}

// MARK: - 数据源绑定
extension QZHSelAddressViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 181*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHAddressListTableViewCell
        //cell.nameLabel.text = self.add
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addressStatus.addressListStatus.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - 监听方法
extension QZHSelAddressViewController{
    // 返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 管理
    func manageAction(){
        
    }

}
