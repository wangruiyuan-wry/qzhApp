//
//  QZHEvaluationViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/26.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHEvaluationViewController: QZHBaseViewController {
    
    // 用户信息视图模型懒加载
    var userInfo = QZHPersonalCenterMyViewModel()
    
    // 列表视图模型懒加载
    var status = QZHEvaluationListViewModel()
    
    // 用户图像
    var userPhoto:UIImageView = UIImageView()
    
    // 用户名称
    var userName:QZHUILabelView = QZHUILabelView()
    
    // 暂无评论
    var noList:QZHUIView = QZHUIView()
    
    override func loadData() {
        setStatusBarBackgroundColor(color: .white)
        self.userInfo.getMyInfo { (isSuccess,isLogin,shouldRefresh) in
            //结束刷新控件
            self.refreahController?.endRefreshing()
            if isSuccess && isLogin{
                let userInfos = self.userInfo.personInfo[0].status
                if userInfos.headPortrait == ""{}else{
                    if let url = URL(string: userInfos.headPortrait) {
                        self.userPhoto.downloadedFrom(url: url)
                    }else{
                        self.userPhoto.image = UIImage(named:"noHeader")
                    }
                }
                
                self.userName.text = userInfos.nikeName
                
            }
        }
        
        self.status.loadList(pullup: self.isPulup) { (isSuccess, shouldRefresh) in
            //结束刷新控件
            self.refreahController?.endRefreshing()
            
            //恢复上拉刷新标记
            self.isPulup = false
            
            //刷新表
            if shouldRefresh {
                if self.status.listStatus.count > 0{
                    self.tabbelView?.reloadData()
                    self.noList.isHidden = true
                    self.tabbelView?.isHidden = false
                }else{
                    self.noList.isHidden = false
                    self.tabbelView?.isHidden = true
                }
                
                
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadData()
    }
}

// MARK: - 设置页面 UI 样式
extension QZHEvaluationViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        tabbelView?.separatorStyle = .none
        tabbelView?.y = 250*PX
        tabbelView?.height = SCREEN_HEIGHT - 250*PX
        tabbelView?.backgroundColor = UIColor.clear
        //注册 tableView
        tabbelView?.register(UINib(nibName:"QZHEvaluationViewCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        self.view.backgroundColor = myColor().grayF0()
        
        setupNav()
        
        setupUser()
    }
    
    // 设置头部导航
    func setupNav(){
        self.title  = "我的评价"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends))
    }
    
    // 设置用户信息
    func setupUser(){
        let userView:QZHUIView = QZHUIView()
        self.view.addSubview(userView)
        
        userView.setupViews(x: 0, y: 129*PX, width: SCREEN_WIDTH, height: 100*PX, bgColor: UIColor.white)
        
        userPhoto.frame = CGRect(x:20*PX,y:21*PX,width:60*PX,height:60*PX)
        userPhoto.image = UIImage(named:"noHeader")
        userPhoto.layer.cornerRadius = 30*PX
        userPhoto.layer.masksToBounds = true
        userView.addSubview(userPhoto)
        
        userName.setLabelView(100*PX, 31*PX, 300*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, "")
        userName.lineBreakMode = .byTruncatingTail
        userView.addSubview(userName)
        
        let btn:QZHUILabelView = QZHUILabelView()
        userView.addSubview(btn)
        btn.setLabelView(610*PX, 20*PX, 120*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 24, "写评价")
        btn.layer.borderColor = myColor().blue007aff().cgColor
        btn.layer.borderWidth = 1*PX
        btn.addOnClickLister(target: self, action: #selector(self.gotoDPJ))
        
        let pjTitle:QZHUILabelView = QZHUILabelView()
        pjTitle.setLabelView(0, 249*PX, SCREEN_WIDTH, 81*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 28, "全部评价")
        self.view.addSubview(pjTitle)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 330*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().blue007aff())
        self.view.addSubview(line)
        
        noList.setupNoList(y: 330*PX, str: "你还没有评价过～～～～～")
        self.view.addSubview(noList)
    }
}

// MARK: - 绑定数据源
extension QZHEvaluationViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.status.listStatus.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 413*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHEvaluationViewCell
        
        let list = self.status.listStatus[indexPath.row].status
        let comments = self.status.repliesStatus[indexPath.row]
        
        cell.creatTime.text = comments[0].status.createTime.components(separatedBy: " ")[0]
        cell.proSpec.text = "产品规格：\(list.goodsSpec)"
        
        cell.commentLabel.text = comments[0].status.goodsDescripe
        if list.goodsPic == ""{
            cell.proImg.image = UIImage(named:"noPic")
        }else{
            if let url = URL(string: list.goodsPic) {
                cell.proImg.downloadedFrom(url: url)
            }else{
                cell.proImg.image = UIImage(named:"noPic")
            }
        }
        cell.ProName.text = list.goodsName
        cell.price.text = "\(list.goodsPrice.roundTo(places: 2))"
        cell.price.setRealWages(cell.price.text!, big: 28, small: 20, fg: ".")
        
        cell.setStar(list.goodsComment)
        
        cell.proView.restorationIdentifier = list._id
        cell.check.restorationIdentifier = list._id
        cell.AddComment.restorationIdentifier = list._id
        cell.AddComment.addOnClickLister(target: self, action: #selector(self.add(_:)))
        cell.proView.addOnClickLister(target: self, action: #selector(self.check(_:)))
        cell.check.addOnClickLister(target: self, action: #selector(self.check(_:)))
        
        return cell
    }
}

// MARK: - 绑定监听方法
extension QZHEvaluationViewController{
    
    // 后退
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 消息中心
    func showFriends(){
        let vc = QZHDemoViewController()
        // navigationController?.pushViewController(vc, animated: true)
    }
    
    // 带评价订单
    func gotoDPJ(){
        QZHOrderListModel.orderType = 4
        let nav = QZHOrderViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 追加评价
    func add(_ sender:UITapGestureRecognizer){
        let _this:UIView = sender.view as! UIView
        QZHEvaluationInfoModel._id = _this.restorationIdentifier!
        QZHCommentModel._id = _this.restorationIdentifier!
        let nav = QZHAddComentViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 查看评价
    func check(_ sender:UITapGestureRecognizer){
        let _this:UIView = sender.view as! UIView
        QZHEvaluationInfoModel._id = _this.restorationIdentifier!
        let nav = QZHEvaluationInfoViewController()
        present(nav, animated: true, completion: nil)
    }
}
