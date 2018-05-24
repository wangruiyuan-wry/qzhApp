//
//  QZHSetUpViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/3.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHSetUpViewController: QZHBaseViewController {
    
    // 用户信息视图列表懒加载
    lazy var personInfoStatus = QZHPersonalCenterMyViewModel()
    
    // 页面
    var body:QZHUIView = QZHUIView()
    
    // 缓存
    var cacheLabel:QZHUILabelView = QZHUILabelView()
    
    // 版本
    var bb:QZHUILabelView = QZHUILabelView()
    
    override func loadData() {
        
    }

}

// MARK: - 设置页面 UI样式
extension QZHSetUpViewController{
    override func setupUI() {
        super.setupUI()
        //设置导航栏按钮
        setupNavTitle()
        
        //注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tabbelView?.separatorStyle = .none
        tabbelView?.y = 128*PX
        tabbelView?.height = SCREEN_HEIGHT - 232*PX
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                tabbelView?.y = 176*PX
                tabbelView?.height = SCREEN_HEIGHT - 446*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        tabbelView?.backgroundColor = myColor().grayF0()
        tabbelView?.isHidden = true
        
        body.setupViews(x:0 , y: 129*PX, width: SCREEN_WIDTH, height: 300*PX, bgColor: UIColor.clear)
        
        setupBody()
        
        self.view.backgroundColor = myColor().grayF0()
        
    }
    
    // 设置头部导航栏
    func setupNavTitle(){
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        
        self.title = "设置"
    }
    
    // 设置 页面内容
    func setupBody(){
        let pwd = self.setupList(y: 0, textStr: "修改密码", action: #selector(self.editPWD))
        let editpwd:QZHUILabelView = QZHUILabelView()
        editpwd.setLabelView(0, 0, pwd.width, pwd.height, NSTextAlignment.left, UIColor.clear, UIColor.clear, 23, "")
        editpwd.addOnClickLister(target: self, action: #selector(self.editPWD))
        pwd.addSubview(editpwd)
        
        self.setupList(y: 101*PX, textStr: "清除缓存", action: #selector(self.showFriends),false,1)
        self.setupList(y: 182*PX, textStr: "关于版本", action: #selector(self.showFriends),false,2)
        
        let btnView:QZHUILabelView = QZHUILabelView()
        btnView.setLabelView(0, SCREEN_HEIGHT - 104*PX, SCREEN_WIDTH, 104*PX, NSTextAlignment.center, myColor().blue007aff(), UIColor.white, 28, "退出当前账户")
        btnView.addOnClickLister(target: self, action: #selector(self.exitLogin))
        self.view.addSubview(btnView)
        
        self.view.addSubview(body)
    }
    
    // 设置单条的操作项
    func setupList(y:CGFloat,textStr:String,action:Selector,_ flag:Bool = true,_ tag:Int = 0)->QZHUIView{
        let thisView:QZHUIView  = QZHUIView()
        thisView.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: 81*PX, bgColor: UIColor.white)
        //thisView.addOnClickLister(target: self, action: action)
        body.addSubview(thisView)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 80*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        thisView.addSubview(line)
        
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(20*PX, 20*PX, 300*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, textStr)
        thisView.addSubview(title)
        
        if tag == 1{
            cacheLabel.setLabelView(378*PX, 20*PX, 312*PX, 40*PX, NSTextAlignment.right, UIColor.white, myColor().gray9(), 28, "0M")
            thisView.addSubview(cacheLabel)
        }
        if tag == 2{
            let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            bb.setLabelView(378*PX, 20*PX, 312*PX, 40*PX, NSTextAlignment.right, UIColor.clear, myColor().gray9(), 28, "V \(currentVersion)")
            thisView.addSubview(bb)
        }
        
        if flag{
            let icon:UIImageView = UIImageView(frame:CGRect(x:708*PX,y:28*PX,width:14*PX,height:24*PX))
            icon.image = UIImage(named:"rightIcon")
            thisView.addSubview(icon)
        }
        
        
        return thisView
    }
}

// MARK: - 数据源绑定
extension QZHSetUpViewController{
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

// MARK: - 方法监听
extension QZHSetUpViewController{
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    //返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 修改密码
    func editPWD(){
        QZHPWDModel.pageName = "修改密码"
        let nav = QZHPWDViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 退出登录
    func exitLogin(){
        self.personInfoStatus.exitLogin { (isSuccess, str) in
            if isSuccess{
                self.dismiss(animated: true, completion: nil)
            }else{
                UIAlertController.showAlert(message: str, in: self)
            }
        }
    }
}
