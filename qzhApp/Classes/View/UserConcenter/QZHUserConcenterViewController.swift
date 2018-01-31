//
//  QZHUserConcenterViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/29.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHUserConcenterViewController: QZHBaseViewController {

    override func loadData() {
       
    }
    
}


// MARK: - 会员中心页面 UI 设置
extension QZHUserConcenterViewController{
    override func setupUI() {
        super.setupUI()
        tabbelView?.isHidden = true
        //注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "", target: self, action: #selector(showFriends))
        
        if self.tabBarController?.tabBar.tag != 1 {
            navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        }
        self.title = "会员中心"
        
        // 设置登录跳转
        let btn:QZHUIButton = QZHUIButton()
        btn.setupButton(100, 150, SCREEN_WIDTH-100, 50, UIColor.gray, UIColor.white, "登录", 20, 1, UIColor.gray, "", UIControlState.normal, 0, UIViewContentMode.center)
        btn.addTarget(self, action: #selector(self.goToLogin), for: .touchUpInside)
        view.addSubview(btn)
        
        
    }
}

// MARK: - 会员中心 监听方法设置
extension QZHUserConcenterViewController{

    //返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //  跳转登录页面
    func goToLogin(){
        let nav = QZHOAuthViewController()
        present(nav, animated: true, completion: nil)
    }
    
}
