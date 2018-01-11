//
//  QZHHomeViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/8.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHHomeViewController: QZHBaseViewController {

    lazy var statusList=[String]()
    
    //加载的数据
    override func loadData() {
        
        //print(QZHNetworkManager.shared)
        //网络工具加载数据
         /*let str = "http://192.168.100.73:81/portal/myStore/enterpriseList"
       
        QZHNetworkManager.shared.request(URLString: str, parameters: [:]) { (json, isSuccess) in
            print("\(json)结果")
        }*/
        
        
        //模拟‘延时’加载 -> dispacth_after
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.4) {
            for i in 0..<10{
                //将上拉刷新追加到底部
                if self.isPulup {
                    self.statusList.append("上拉\(i)")
                }else{
                    //加载数据到顶部
                    self.statusList.insert(i.description, at: 0)
                }
            }
            //结束刷新控件
            self.refreahController?.endRefreshing()
            
            //恢复上拉刷新标记
            self.isPulup = false
            
            //刷新表/Users/sbxmac/Documents/My Workspace/qzhApp/Podfile格
            self.tabbelView?.reloadData()
        }
    }
    
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- 表格数据源方法，具体的数据源方法实现，不需要 super
extension QZHHomeViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. 取 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        //2. 设置 cell
        cell.textLabel?.text = statusList[indexPath.row]
        
        //3. 返回 cell
        return cell
    }
}

//MARK:-设置界面
extension QZHHomeViewController{

    //重写父类方法
    override func setupUI() {
        super.setupUI()
        
        //设置导航栏按钮 
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "", target: self, action: #selector(showFriends))
        
        //注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}
