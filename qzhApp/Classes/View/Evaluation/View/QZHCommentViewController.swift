//
//  QZHCommentViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/27.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHCommentViewController: QZHBaseViewController {

    // 订单详情列表视图懒加载
    lazy var orderDetailStatus = QZHOrderDetailListViewModel()
    
    // 提交评价视图模型
    lazy var Status = QZHEvaluationListViewModel()
    
    var serviceView:QZHUIView = QZHUIView()
    var proView:QZHUIView = QZHUIView()
    var noList:QZHUIView = QZHUIView()
    
    // 操作结果显示
    var timer:Timer!
    var resultView:QZHUIView = QZHUIView()
    
    override func loadData() {
        self.orderDetailStatus.loadOrderDetail { (isSuccess) in
            if !isSuccess{
                self.tabbelView?.isHidden = true
                self.noList.isHidden = false
            }else{
                self.tabbelView?.isHidden = false
                self.noList.isHidden = true
                
                self.tabbelView?.reloadData()
            }
        }
    }
    
}

// MARK: - 设置页面UI样式
extension QZHCommentViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        tabbelView?.separatorStyle = .none
        tabbelView?.y = 48*PX
        tabbelView?.height = SCREEN_HEIGHT - 152*PX
        tabbelView?.backgroundColor = UIColor.clear
        //注册 tableView
        tabbelView?.register(UINib(nibName:"QZHCommentCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        self.view.backgroundColor = myColor().grayF0()
        
        setupNav()
        setFoot()
        noList.setupNoList(y: 129*PX, str: "数据加载异常！！！")
        self.view.addSubview(noList)
    }
    
    // 设置头部导航
    func setupNav(){
        self.title  = "发表评价"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        
        let btn:QZHUILabelView = QZHUILabelView()
        btn.setLabelView(0, SCREEN_HEIGHT-104*PX, SCREEN_WIDTH, 104*PX, NSTextAlignment.center, myColor().blue007aff(), UIColor.white, 28, "提交")
        btn.addOnClickLister(target: self, action: #selector(self.save))
        self.view.addSubview(btn)
    }
    
    func setFoot(){
        let foot:QZHUIView = QZHUIView()
        foot.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 259*PX, bgColor: UIColor.white)
        tabbelView?.tableFooterView = foot
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 230*PX, width: SCREEN_WIDTH, height: 29*PX, color: myColor().grayF0())
        foot.addSubview(line)
        
        let storeIcon:UIImageView = UIImageView(frame:CGRect(x:20*PX,y:24*PX,width:35*PX,height:33*PX))
        storeIcon.image = UIImage(named:"EvaluationStoreIcon")
        foot.addSubview(storeIcon)
        
        let storeTitle:QZHUILabelView = QZHUILabelView()
        storeTitle.setLabelView(75*PX, 20*PX, 150*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, "店铺评分")
        foot.addSubview(storeTitle)
        
        let proTitle:QZHUILabelView = QZHUILabelView()
        proTitle.setLabelView(20*PX, 90*PX, 120*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 28, "商品描述")
        foot.addSubview(proTitle)
        
        proView.setupViews(x: 171*PX, y: 91*PX, width: 559*PX, height: 35*PX, bgColor: UIColor.clear)
        foot.addSubview(proView)
        proView.tag = 5
        let proleft = 75*PX
        for i in 0..<5{
            let starView:UIImageView = UIImageView(frame:CGRect(x:proleft*CGFloat(i),y:0,width:35*PX,height:35*PX))
            starView.image = UIImage(named:"star")
            starView.tag = i + 1
            proView.addSubview(starView)
            starView.addOnClickLister(target: self, action: #selector(self.setStar(_:)))
        }
        
        let serviceTitle:QZHUILabelView = QZHUILabelView()
        serviceTitle.setLabelView(20*PX, 160*PX, 120*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 28, "商品描述")
        foot.addSubview(serviceTitle)
        
        serviceView.setupViews(x: 171*PX, y: 162*PX, width: 559*PX, height: 35*PX, bgColor: UIColor.clear)
        foot.addSubview(serviceView)
        serviceView.tag = 5
        for i in 0..<5{
            let starView:UIImageView = UIImageView(frame:CGRect(x:proleft*CGFloat(i),y:0,width:35*PX,height:35*PX))
            starView.image = UIImage(named:"star")
            starView.tag = i + 1
            serviceView.addSubview(starView)
            starView.addOnClickLister(target: self, action: #selector(self.setStar(_:)))
        }
    }
}

// MARK: - 绑定数据源
extension QZHCommentViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderDetailStatus.orderSubStatus.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 421*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHCommentCell
        let pro = self.orderDetailStatus.orderSubStatus[indexPath.row].status
        cell.tag = pro.goodsId
        if pro.picPath == ""{
            cell.proImg.image = UIImage(named:"noPic")
        }else{
            if let url = URL(string: pro.picPath) {
                cell.proImg.downloadedFrom(url: url)
            }else{
                cell.proImg.image = UIImage(named:"noPic")
            }
        }
        return cell
    }

}

// MARK: - 绑定监听方法
extension QZHCommentViewController{
    // 后退
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 星级评分
    func setStar(_ sender:UITapGestureRecognizer){
        let _this:UIView = sender.view!
        let children:[UIImageView] = _this.superview?.subviews as! [UIImageView]
        for child in children{
            if _this.tag < child.tag{
                child.image = UIImage(named:"star3")
            }else{
                child.image = UIImage(named:"star")
            }
        }
        _this.superview?.tag = _this.tag
    }
    
    // 操作结果图层消失
    func resultViewXS(){
        resultView.isHidden = true
        resultView.subviews.map{ $0.removeFromSuperview()}
    }
    
    // 提交
    func save(){
        let cells = self.tabbelView?.visibleCells as! [QZHCommentCell]
        var data = "["
        for cell in cells{
            if data != "["{
                data = "\(data),"
            }
            data = "\(data){"
            data = "\(data)\"goodsId\":\(cell.tag),"
            data = "\(data)\"goodsComment\":\(cell.starView.tag),"
            data = "\(data)\"goodsDescripe\":\"\(cell.commentView.text!)\""
            data = "\(data)}"
        }
        data = "\(data)]"
        QZHCommentModel.data = data
        QZHCommentModel.seviceComment = self.serviceView.tag
        QZHCommentModel.productComment = self.proView.tag
        self.Status.comment { (isSuccess) in
            if isSuccess{
                self.resultView.opertionSuccess("发表评价成功", isSuccess)
                self.view.addSubview(self.resultView)
                self.resultView.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
                self.dismiss(animated: true, completion: nil)
            }else{
                self.resultView.opertionSuccess("发表失败", isSuccess)
                self.view.addSubview(self.resultView)
                self.resultView.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
            }
        }
        
    }
}
