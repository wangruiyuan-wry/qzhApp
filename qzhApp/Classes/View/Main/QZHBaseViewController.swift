//
//  QZHBaseViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/8.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit


/// 所有的主控制器的基类的控制器 UITableViewDataSource,UITableViewDelegate
/// Swift 中可以利用 extension 可以把“函数”按功能分类管理，便于阅读和维护
/// 注意：
//1. extension 中不能有属性
//2. extension 中不能重写父类方法，重写父类方法是子类的的职责，扩展是对类的扩展

class QZHBaseViewController: UIViewController{
    
    
    
    /// 访客视图字典信息
    var visitorInfoDictionary:[String:String]?
    
    /// 表格视图
    var tabbelView:UITableView?
    
    //刷新控件
    var refreahController:UIRefreshControl?
    
    //上拉刷新标记
    var isPulup = false
    
    // 下拉刷新
    var isPush = false
    
    // 页面跳转标示
    var pageIsOpen = true
    
    /// 自定义导航条
    lazy var navigationBar = UINavigationBar(frame:CGRect(x:0,y:0,width:SCREEN_WIDTH,height:PX*128))
    
    /// 自定义导航项 - 以后设置导航栏内容，统一使用 navItem
    lazy var navItem =  UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        setupUI()
        
        if isPush{
            loadData()
        }
        
    }
    
    override var title: String?{
        didSet{
            navItem.title = title
        }
    }
    
    // 加载数据的方法 - 具体实现又由子类负责
    func loadData(){
        //如果子类不实现任何方法，默认关闭刷新控件
        refreahController?.endRefreshing()
    }
}

//MARK：-设置界面
extension QZHBaseViewController{
    func setupUI(){
        view.backgroundColor = UIColor.white
        
        //取消自动取消 - 如果隐藏了导航栏会缩进20个点
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigation()
        
        setupTabelView()
        
        /*if pageFlag{
            setupTabelView()
        }else{
            setupVisitorView()
        }*/
        
        //QZHNetworkManager.shared.userLogo?setupTabelView():setupVisitorView()
        
        
    }
    
    /// 设置表格时图
    private func setupTabelView(){
        tabbelView = UITableView(frame:view.bounds,style:.plain)
        //view.addSubview(tabbelView!)
        view.insertSubview(tabbelView!, belowSubview: navigationBar)
        
        //设置数据源 && 代理 -> 目的：子类直接实现数据源的方法
        tabbelView?.dataSource = self
        tabbelView?.delegate = self
    
        //设置内容缩进
        //tabbelView?.contentInset=UIEdgeInsets(top:navigationBar.bounds.height,left:0,bottom:(tabBarController?.tabBar.bounds.height)!,right:0)
    
        //设置刷新控件
        // 1> 实例化控件
        refreahController = UIRefreshControl()
    
        // 2>添加到表格视图
        tabbelView?.addSubview(refreahController!)
    
        // 3>添加监听方法
        refreahController?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    
    }
    
    /// 设置导航条
    private func setupNavigation(){
        //添加导航条
        view.addSubview(navigationBar)
        //将 item 设置给 bar
        navigationBar.items = [navItem]
        
        // 设置 navBar 的渲染颜色
        navigationBar.frame = CGRect(x:0,y:20,width:750*PX,height:128*PX-20)
        navigationBar.barTintColor = UIColor.white
        navigationBar.barTintColor = UIColor.white
        navigationBar.tintColor=myColor().gray3()
        navigationBar.titleTextAttributes=[NSFontAttributeName:UIFont.boldSystemFont(ofSize: PX*36),NSForegroundColorAttributeName:myColor().gray3()]
    }
}

//MARK: - UITableViewDataSource,UITableViewDelegate
extension  QZHBaseViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    //基类只是准备方法，子类负责具体的实现
    //子类的数据源方法不需要 super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //只是保证没有错误语法

        return UITableViewCell()
    }
    
    //在显示最后一行的时候，上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 取消 cell 的选中事件
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        //1.判断 indexPath 是否是最后一行
        // 1> row
        let row = indexPath.row
        // 2> section
        let section=(tabbelView?.numberOfSections)!-1
        
        if row < 0 || section <  0{
            return
        }
        // 3> 行数
        let count = tabbelView?.numberOfRows(inSection: section)
        
        //如果是最后一行，同时没有开始上拉刷新
        if row == (count! - 1) && !isPulup{
            isPulup = true
            
            //开始刷新
            loadData()
        }
    }
}


//MAKRK: - 访客视图监听方法
extension QZHBaseViewController{
    @objc func login(){
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: QZHUserShouldLoginNotification), object: nil)
        
    }
    @objc private func register(){
        print("用户注册")
    }
}
