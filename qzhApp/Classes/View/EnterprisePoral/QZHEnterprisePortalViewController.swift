//
//  QZHEnterprisePortalViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/10.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHEnterprisePortalViewController: QZHBaseViewController {

    //列表视图模型
    lazy var listViewModel = QZHEnterprisePortalViewModel()
    
    //加载的数据
    override func loadData() {
        
        //去掉单元格的分割线
        self.tabbelView?.separatorStyle = .none
       listViewModel.loadStatus(pullup: self.isPulup) { (isSuccess,shouldRefresh) in
            //结束刷新控件
            self.refreahController?.endRefreshing()
            
            //恢复上拉刷新标记
            self.isPulup = false
            
            //刷新表/Users/sbxmac/Documents/My Workspace/qzhApp/Podfile格
            if shouldRefresh {
                
                self.tabbelView?.reloadData()
                
            }
        }
        
    }
    
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- 表格数据源方法，具体的数据源方法实现，不需要 super
extension QZHEnterprisePortalViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1. 取 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHEnterprisePortalStatusCell
        
        
        //2. 设置 cell
        //cell.textLabel?.text = listViewModel.statusList[indexPath.row].address
        
        
        //3. 返回 cell
        return cell
    }
}

//MARK:-设置界面
extension QZHEnterprisePortalViewController{
    
    //重写父类方法
    override func setupUI() {
        super.setupUI()
        
        //设置导航栏按钮
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "", target: self, action: #selector(showFriends))
        
        //注册原型 cell
        //tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tabbelView?.register(UINib(nibName:"QZHEnterprisePortalStatusCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        //设置行高
        tabbelView?.rowHeight = UITableViewAutomaticDimension
        tabbelView?.estimatedRowHeight = 260*PX
        
        setupNavTitle()
    }
    
    //设置导航栏标题
    func setupNavTitle(){
    
    }
}
