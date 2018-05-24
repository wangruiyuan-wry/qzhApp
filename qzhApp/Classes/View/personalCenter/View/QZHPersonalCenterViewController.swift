//
//  QZHPersonalCenterViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/2.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHPersonalCenterViewController: QZHBaseViewController {
    
    // 用户信息视图列表懒加载
    lazy var personInfoStatus = QZHPersonalCenterMyViewModel()
    
    // 用户头像
    var userPhoto:UIImageView = UIImageView()
    
    // 用户名称
    var userName:QZHUILabelView = QZHUILabelView()
    
    // 用户公司名称
    var userCompanyName:QZHUILabelView = QZHUILabelView()
    
    //
    var userDetail:QZHUIView = QZHUIView()
    
    // 用户等级
    var userLavel:QZHUILabelView = QZHUILabelView()
    
    // 收藏chanpin
    var collectionNum:QZHUILabelView = QZHUILabelView()
    
    // 关注店铺
    var focusStoreNum:QZHUILabelView = QZHUILabelView()
    
    // 我的足迹
    var footPrintNum:QZHUILabelView = QZHUILabelView()
    
    // 待付款
    var payNum:QZHUILabelView = QZHUILabelView()
    
    // 待发货
    var sendGoodsNum:QZHUILabelView = QZHUILabelView()
    
    // 待收货
    var forGoodsNum:QZHUILabelView = QZHUILabelView()
    
    // 待评价
    var commentNum:QZHUILabelView = QZHUILabelView()
    
    // 售后
    var afterSalesNum:QZHUILabelView = QZHUILabelView()
    
    // 页面
    var body:QZHUIView = QZHUIView()
    var rightIcon:UIImageView = UIImageView()
    
    // 登录按钮
    var loginBtn:QZHUILabelView = QZHUILabelView()
    
    override func loadData() {
        self.personInfoStatus.getMyInfo { (isSuccess,isLogin,shouldRefresh) in
            //结束刷新控件
            self.refreahController?.endRefreshing()
            if isSuccess{
                if isLogin{
                    self.loginBtn.isHidden = true
                    self.userName.isHidden = false
                    self.userCompanyName.isHidden = false
                    self.userDetail.isHidden = false
                    self.rightIcon.isHidden = false
                    let person = self.personInfoStatus.personInfo[0].status
                    let info = self.personInfoStatus.myInfo[0].status
                    let order = self.personInfoStatus.orderCount[0].status
                    if person.headPortrait == ""{}else{
                        if let url = URL(string: person.headPortrait) {
                            self.userPhoto.downloadedFrom(url: url)
                        }else{
                            self.userPhoto.image = UIImage(named:"UserCenter_Logo")
                        }
                    }
                    
                    self.userName.text = "\(person.nikeName)  (ID:\(person.id))"
                    self.userCompanyName.text = person.companyName
                    self.collectionNum.text = "\(info.collectProductCount)"
                    self.focusStoreNum.text = "\(info.attentionStoreCount)"
                    self.footPrintNum.text = "\(info.myFootCount)"
                    
                    if order.dfkCount != 0{
                        self.payNum.isHidden = false
                        self.payNum.text = "\(order.dfkCount)"
                    }
                    
                    if order.dfhCount != 0{
                        self.sendGoodsNum.isHidden = false
                        self.sendGoodsNum.text = "\(order.dfhCount)"
                    }
                    
                    if order.dshCount != 0{
                        self.forGoodsNum.text = "\(order.dshCount)"
                        self.forGoodsNum.isHidden = false
                    }
                    
                    if order.dpjCount != 0{
                        self.commentNum.text = "\(order.dpjCount)"
                        self.commentNum.isHidden = false
                    }
                    
                    if order.tkCount != 0{
                        self.afterSalesNum.isHidden = false
                        self.afterSalesNum.text = "\(order.tkCount)"
                    }
                    
                    //刷新表
                    if shouldRefresh {
                        
                        self.tabbelView?.reloadData()
                        
                    }
                }else{
                    self.loginBtn.isHidden = false
                    self.userName.isHidden = true
                    self.userCompanyName.isHidden = true
                    self.userDetail.isHidden = true
                    self.rightIcon.isHidden = true
                    LoginModel.isLogin = 0
                    self.userPhoto.image = UIImage(named:"UserCenter_Logo")
                    self.collectionNum.text = "0"
                    self.focusStoreNum.text = "0"
                    self.footPrintNum.text = "0"
                    self.payNum.isHidden = true
                    self.sendGoodsNum.isHidden = true
                    self.forGoodsNum.isHidden = true
                    self.commentNum.isHidden = true
                    self.afterSalesNum.isHidden = true
                    
                    self.tabbelView?.reloadData()
                }
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isPush = true
        setStatusBarBackgroundColor(color: .clear)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        loadData()
    }
}

// MARK: - 设置页面 UI 样式
extension QZHPersonalCenterViewController{
    override func setupUI() {
        super.setupUI()//设置导航栏按钮
        self.isPush = true
        QZHOrderListModel.from = 0
        setupNavTitle()
        setStatusBarBackgroundColor(color: myColor().blue007aff())
        
        tabbelView?.separatorStyle = .none
        tabbelView?.backgroundColor = UIColor.white
        //注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupHeader()
        setupUser_Operation()
        setupOrder()
        setupOperation()
        tabbelView?.tableHeaderView = body
        body.backgroundColor =  myColor().grayF0()
        
    }
    
    // 设置头部导航栏
    func setupNavTitle(){
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIconWhite", target: self, action: #selector(showFriends))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "setupIcon", target: self, action: #selector(self.gotoSETUP),color:UIColor.white)
        
        navigationBar.tintColor = UIColor.white
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        let titleView:QZHUILabelView = QZHUILabelView()
        titleView.setLabelView(0, 0, 160*PX, 50*PX, NSTextAlignment.center, UIColor.clear, UIColor.white, 36, "个人中心")
        navItem.titleView = titleView
    }
    
    // 设置头部
    func setupHeader(){
        let headerView:QZHUIView = QZHUIView()
        headerView.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 258*PX, bgColor: myColor().blue007aff())
        body.addSubview(headerView)
        
        userPhoto.frame = CGRect(x:20*PX,y:128*PX,width:100*PX,height:100*PX)
        userPhoto.image = UIImage(named:"UserCenter_Logo")
        userPhoto.layer.cornerRadius = userPhoto.frame.height / 2
        userPhoto.layer.masksToBounds = true
        userPhoto.backgroundColor = UIColor.white
        headerView.addSubview(userPhoto)
        
        userName.setLabelView(150*PX, 139*PX, 450*PX, 40*PX, NSTextAlignment.left, UIColor.clear, UIColor.white, 28, "")
        userName.lineBreakMode = .byTruncatingTail 
        headerView.addSubview(userName)
        
        userLavel.setLabelView(495*PX, 143*PX, 50*PX, 31*PX, NSTextAlignment.left, UIColor.clear, myColor().yellowF5d96c(), 28, "lv 1")
        userLavel.font = UIFont.italicSystemFont(ofSize: 28*PX)
        userLavel.isHidden = true
        headerView.addSubview(userLavel)
        
        userCompanyName.setLabelView(150*PX, 189*PX, 450*PX, 28*PX, NSTextAlignment.left, UIColor.clear, UIColor.white, 20, "")
        headerView.addSubview(userCompanyName)
        
        
        userDetail.setupViews(x: 650*PX, y: 128*PX, width: 100*PX, height: 130*PX, bgColor: myColor().blue007aff())
        userDetail.addOnClickLister(target: self, action: #selector(self.gotoUserInfo))
        rightIcon.frame = CGRect(x:54*PX,y:37*PX,width:17*PX,height:27*PX)
        rightIcon.image = UIImage(named:"rightOpen0")
        userDetail.addSubview(rightIcon)
        headerView.addSubview(userDetail)
        
       loginBtn.setLabelView(150*PX, 153*PX, 120*PX, 50*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 28, "登录")
        loginBtn.addOnClickLister(target: self, action: #selector(self.loginUser))
        loginBtn.layer.cornerRadius = 5*PX
        loginBtn.layer.masksToBounds = true
        headerView.addSubview(loginBtn)
        
    }
    
    // 设置收藏
    func setupUser_Operation(){
        let bg:QZHUIView = QZHUIView()
        bg.setupViews(x: 0, y: 258*PX, width: SCREEN_WIDTH, height: 110*PX, bgColor: UIColor.white)
        body.addSubview(bg)
        
        // 收藏产品
        let collectionView:QZHUIView = QZHUIView()
        collectionView.setupViews(x: 10*PX, y: 0, width: 710/3*PX, height: 110*PX, bgColor: UIColor.clear)
        collectionView.addOnClickLister(target: self, action: #selector(self.gotoCollection))
        collectionNum.setLabelView(0, 14*PX, collectionView.width, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 28, "0")
        collectionView.addSubview(collectionNum)
        let collectioTitle:QZHUILabelView = QZHUILabelView()
        collectioTitle.setLabelView(0, 64*PX, collectionView.width, 33*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 24, "收藏产品")
        collectionView.addSubview(collectioTitle)
        bg.addSubview(collectionView)
        
        // 关注店铺
        let focusStoreView:QZHUIView = QZHUIView()
        focusStoreView.setupViews(x: 20*PX + collectionView.width, y: 0, width: 710/3*PX, height: 110*PX, bgColor: UIColor.clear)
        focusStoreView.addOnClickLister(target: self, action: #selector(self.gotoFocuseStore))
        focusStoreNum.setLabelView(0, 14*PX, focusStoreView.width, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 28, "0")
        focusStoreView.addSubview(focusStoreNum)
        let focusStoreTitle:QZHUILabelView = QZHUILabelView()
        focusStoreTitle.setLabelView(0, 64*PX, focusStoreView.width, 33*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 24, "关注店铺")
        focusStoreView.addSubview(focusStoreTitle)
        bg.addSubview(focusStoreView)
        
        // 我的足迹
        let footPrintView:QZHUIView = QZHUIView()
        footPrintView.setupViews(x: 30*PX + collectionView.width*2, y: 0, width: 710/3*PX, height: 110*PX, bgColor: UIColor.clear)
        footPrintView.addOnClickLister(target: self, action: #selector(self.gotoMyFootPrint))
        footPrintNum.setLabelView(0, 14*PX, footPrintView.width, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 28, "0")
        footPrintView.addSubview(footPrintNum)
        let footPrintTitle:QZHUILabelView = QZHUILabelView()
        footPrintTitle.setLabelView(0, 64*PX, footPrintView.width, 33*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 24, "我的足迹")
        footPrintView.addSubview(footPrintTitle)
        bg.addSubview(footPrintView)
    }
    
    // 采购订单
    func setupOrder(){
        let orderView:QZHUIView = QZHUIView()
        orderView.setupViews(x: 0, y: 388*PX, width: SCREEN_WIDTH, height: 230*PX, bgColor: UIColor.white)
        body.addSubview(orderView)
        
        let titleView:QZHUILabelView = QZHUILabelView()
        titleView.setLabelView(20*PX, 20*PX, 130*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, "采购订单")
        orderView.addSubview(titleView)
        
        let checkOrder:QZHUILabelView = QZHUILabelView()
        checkOrder.tag = 8
        checkOrder.addOnClickLister(target: self, action: #selector(self.gotoMyOrder(_:)))
        checkOrder.setLabelView(546*PX, 24*PX, 204*PX, 33*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 24, "查看更多订单")
        let right:UIImageView = UIImageView(frame:CGRect(x:162*PX,y:4*PX,width:14*PX,height:24*PX))
        right.image = UIImage(named:"rightIcon")
        checkOrder.addSubview(right)
        orderView.addSubview(checkOrder)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 80*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayEB())
        orderView.addSubview(line)
        
        // 设置待付款
        let orderView1:QZHUIView = QZHUIView()
        orderView1.setupViews(x: 0*PX, y: 81*PX, width: 142*PX, height: 149*PX, bgColor: UIColor.white)
        orderView1.tag = 1
        orderView1.addOnClickLister(target: self, action: #selector(self.gotoMyOrder(_:)))
        orderView.addSubview(orderView1)
        let icon1:UIImageView = UIImageView(frame:CGRect(x:50*PX,y:113*PX,width:42*PX,height:36*PX))
        icon1.image = UIImage(named:"userDFK")
        orderView.addSubview(icon1)
        let title1:QZHUILabelView = QZHUILabelView()
        title1.setLabelView(30*PX, 171*PX, 82*PX, 33*PX, NSTextAlignment.center, UIColor.white, myColor().Gray6(), 24, "待付款")
        orderView.addSubview(title1)
        payNum.setLabelView(28*PX, -18*PX, 32*PX, 32*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 22, "0")
        payNum.layer.borderColor = myColor().blue007aff().cgColor
        payNum.layer.borderWidth = 2*PX
        payNum.layer.cornerRadius = 16*PX
        payNum.layer.masksToBounds = true
        payNum.isHidden = true
        icon1.addSubview(payNum)
        
        // 设置待发货
        let orderView2:QZHUIView = QZHUIView()
        orderView2.setupViews(x: 142*PX, y: 81*PX, width: 142*PX, height: 149*PX, bgColor: UIColor.white)
        orderView2.tag = 2
        orderView2.addOnClickLister(target: self, action: #selector(self.gotoMyOrder(_:)))
        orderView.addSubview(orderView2)
        let icon2:UIImageView = UIImageView(frame:CGRect(x:193*PX,y:112*PX,width:42*PX,height:38*PX))
        icon2.image = UIImage(named:"userDFH")
        orderView.addSubview(icon2)
        let title2:QZHUILabelView = QZHUILabelView()
        title2.setLabelView(173*PX, 171*PX, 82*PX, 33*PX, NSTextAlignment.center, UIColor.white, myColor().Gray6(), 24, "待发货")
        orderView.addSubview(title2)
        sendGoodsNum.setLabelView(28*PX, -18*PX, 32*PX, 32*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 22, "0")
        sendGoodsNum.layer.borderColor = myColor().blue007aff().cgColor
        sendGoodsNum.layer.borderWidth = 2*PX
        sendGoodsNum.layer.cornerRadius = 16*PX
        sendGoodsNum.layer.masksToBounds = true
        sendGoodsNum.isHidden = true
        icon2.addSubview(sendGoodsNum)
        
        // 设置待收货
        let orderView3:QZHUIView = QZHUIView()
        orderView3.setupViews(x: 284*PX, y: 81*PX, width: 142*PX, height: 149*PX, bgColor: UIColor.white)
        orderView3.tag = 3
        orderView3.addOnClickLister(target: self, action: #selector(self.gotoMyOrder(_:)))
        orderView.addSubview(orderView3)
        let icon3:UIImageView = UIImageView(frame:CGRect(x:340*PX,y:112*PX,width:42*PX,height:38*PX))
        icon3.image = UIImage(named:"userDSH")
        orderView.addSubview(icon3)
        let title3:QZHUILabelView = QZHUILabelView()
        title3.setLabelView(316*PX, 171*PX, 82*PX, 33*PX, NSTextAlignment.center, UIColor.white, myColor().Gray6(), 24, "待收货")
        orderView.addSubview(title3)
        forGoodsNum.setLabelView(28*PX, -18*PX, 32*PX, 32*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 22, "0")
        forGoodsNum.layer.borderColor = myColor().blue007aff().cgColor
        forGoodsNum.layer.borderWidth = 2*PX
        forGoodsNum.layer.cornerRadius = 16*PX
        forGoodsNum.layer.masksToBounds = true
        forGoodsNum.isHidden = true
        icon3.addSubview(forGoodsNum)
        
        // 设置评价
        let orderView4:QZHUIView = QZHUIView()
        orderView4.setupViews(x: 426*PX, y: 81*PX, width: 142*PX, height: 149*PX, bgColor: UIColor.white)
        orderView4.tag = 4
        orderView4.addOnClickLister(target: self, action: #selector(self.gotoMyOrder(_:)))
        orderView.addSubview(orderView4)
        let icon4:UIImageView = UIImageView(frame:CGRect(x:479*PX,y:112*PX,width:42*PX,height:38*PX))
        icon4.image = UIImage(named:"userDPJ")
        orderView.addSubview(icon4)
        let title4:QZHUILabelView = QZHUILabelView()
        title4.setLabelView(459*PX, 171*PX, 82*PX, 33*PX, NSTextAlignment.center, UIColor.white, myColor().Gray6(), 24, "待评价")
        orderView.addSubview(title4)
        commentNum.setLabelView(28*PX, -18*PX, 32*PX, 32*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 22, "0")
        commentNum.layer.borderColor = myColor().blue007aff().cgColor
        commentNum.layer.borderWidth = 2*PX
        commentNum.layer.cornerRadius = 16*PX
        commentNum.layer.masksToBounds = true
        commentNum.isHidden = true
        icon4.addSubview(commentNum)
        
        // 设置退款／售后
        let orderView5:QZHUIView = QZHUIView()
        orderView5.setupViews(x: 568*PX, y: 81*PX, width: 182*PX, height: 149*PX, bgColor: UIColor.white)
        orderView5.tag = 5
        orderView5.addOnClickLister(target: self, action: #selector(self.gotoMyOrder(_:)))
        orderView.addSubview(orderView5)
        let icon5:UIImageView = UIImageView(frame:CGRect(x:639*PX,y:110*PX,width:44*PX,height:42*PX))
        icon5.image = UIImage(named:"userSH")
        orderView.addSubview(icon5)
        let title5:QZHUILabelView = QZHUILabelView()
        title5.setLabelView(597*PX, 171*PX, 128*PX, 33*PX, NSTextAlignment.center, UIColor.white, myColor().Gray6(), 24, "退款／售后")
        orderView.addSubview(title5)
        afterSalesNum.setLabelView(26*PX, -15*PX, 32*PX, 32*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 22, "0")
        afterSalesNum.layer.borderColor = myColor().blue007aff().cgColor
        afterSalesNum.layer.borderWidth = 2*PX
        afterSalesNum.layer.cornerRadius = 16*PX
        afterSalesNum.layer.masksToBounds = true
        afterSalesNum.adjustsFontSizeToFitWidth = true
        afterSalesNum.minimumScaleFactor = 0.5
        afterSalesNum.isHidden = true
        icon5.addSubview(afterSalesNum)
    }
    
    // 设置基本操作列表
    func setupOperation(){
        //self.setupOperationList(y: 638*PX, textStr: "销售订单", action: #selector(self.salesOrder))
        //self.setupOperationList(y: 719*PX, textStr: "索要发票", action: #selector(self.salesOrder))
        //self.setupOperationList(y: 800*PX, textStr: "我的发票信息", action: #selector(self.salesOrder))
        self.setupOperationList(y: 638*PX, textStr: "我的收货地址", action: #selector(self.gotoAddress))//881
        
        self.setupOperationList(y: 719*PX, textStr: "市场推广", action: #selector(self.gotoMarket))//962
        self.setupOperationList(y: 800*PX, textStr: "我的评价", action: #selector(self.gotoCommnt))//1043
        
        body.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 881*PX, bgColor: myColor().grayF0())
    }
    
    // 设置单条的操作项
    func setupOperationList(y:CGFloat,textStr:String,action:Selector){
        let thisView:QZHUIView  = QZHUIView()
        thisView.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: 81*PX, bgColor: UIColor.white)
        thisView.addOnClickLister(target: self, action: action)
        body.addSubview(thisView)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 80*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        thisView.addSubview(line)
        
        
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(20*PX, 20*PX, 300*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, textStr)
        thisView.addSubview(title)
        
        let icon:UIImageView = UIImageView(frame:CGRect(x:708*PX,y:28*PX,width:14*PX,height:24*PX))
        icon.image = UIImage(named:"rightIcon")
        thisView.addSubview(icon)
    }
}

// MARK: - 绑定数据源
extension QZHPersonalCenterViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
}

// MARK: - 监听方法
extension QZHPersonalCenterViewController{
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        //navigationController?.pushViewController(vc, animated: true)
    }
    // 个人信息
    func gotoUserInfo(){
        if self.loginBtn.isHidden{
            let nav = QZHPersonInfoViewController()
            present(nav, animated: true, completion: nil)
        }else{
            loginUser()
        }
    }
    
    
    // 设置
    func gotoSETUP(){
        let nav = QZHSetUpViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 我的订单
    func gotoMyOrder(_ sender:UITapGestureRecognizer){
        if self.loginBtn.isHidden{
            let _this = sender.view
            QZHOrderListModel.orderType = (_this?.tag)!
            if QZHOrderListModel.orderType == 8{
                QZHOrderListModel.orderType = 0
            }
            let nav = QZHOrderViewController()
            present(nav, animated: true, completion: nil)
        }else{
            loginUser()
        }
    }
    
    // 我的收藏
    func gotoCollection(){
        //QZHCollectViewController
        if self.loginBtn.isHidden{
            let nav = QZHCollectViewController()
            present(nav, animated: true, completion: nil)
        }else{
            loginUser()
        }
    }
    
    // 我的足迹
    func gotoMyFootPrint(){
        //QZHMyFootPrintViewController
        
        
        if self.loginBtn.isHidden{
            let nav = QZHMyFootPrintViewController()
            present(nav, animated: true, completion: nil)
        }else{
            loginUser()
        }
    }
    
    //  关注店铺
    func gotoFocuseStore(){
        if self.loginBtn.isHidden{
            let nav = QZHFocusStoreViewController()
            present(nav, animated: true, completion: nil)
        }else{
            loginUser()
        }
    }
    
    // 销售订单
    func salesOrder(){}
    
    // 收货地址
    func gotoAddress(){
        
        if self.loginBtn.isHidden{
            let nav = QZHSelAddressViewController()
            present(nav, animated: true, completion: nil)
        }else{
            loginUser()
        }
    }
    
    // 市场推广
    func gotoMarket(){
        if self.loginBtn.isHidden{
            let nav = QZH_CYSQMainViewController()
            nav.selectedIndex = 2
            present(nav, animated: true, completion: nil)
        }else{
            loginUser()
        }
    }
    
    // 我的评价
    func gotoCommnt(){
        if self.loginBtn.isHidden{
            let nav = QZHEvaluationViewController()
            present(nav, animated: true, completion: nil)
        }else{
            loginUser()
        }
    }
    
    // 登录
    func loginUser(){
        let nav = QZHOAuthViewController()
        present(nav, animated: true, completion: nil)
    }
    
}
