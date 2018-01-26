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
    
    //列表视图模型
    lazy var listViewModel = QZHEnterpriseDetailViewModels()
    
    override func loadData() {
        
        //去掉单元格的分割线
        self.tabbelView?.separatorStyle = .none
        
        listViewModel.loadProList(pullup: self.isPulup) { (isSuccess,shouldRefresh) in
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
}


// MARK: -  表格数据源方法，具体的数据源方法实现，不需要 super
extension QZHEnterpriseProViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.proList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240*PX+1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1. 取 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHEnterpriseDetailProCell
        
        //2. 设置 cell
        
        cell.proName.text = listViewModel.proList[indexPath.row].status.goodsName

        if listViewModel.proList[indexPath.row].status.pic != ""{
            cell.proLogo.image = UIImage(data:PublicFunction().imgFromURL(listViewModel.proList[indexPath.row].status.pic))
        }else{
            cell.proLogo.image = UIImage(named:"noPic")
        }
        
        
        let spec:[String:AnyObject] = listViewModel.proList[indexPath.row].status.attribute
        
        cell.proSpec.text = "\(String(describing: spec["attributeName"])):\(String(describing: spec["optionName"]))"
        
        cell.proPrice.text = "¥\(listViewModel.proList[indexPath.row].status.fixedPrice)"
        
        
        
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
