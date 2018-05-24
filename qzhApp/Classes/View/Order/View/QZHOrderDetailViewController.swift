//
//  QZHOrderDetailViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/8.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHOrderDetailViewController: QZHBaseViewController {
    
    lazy var listStatus = QZH_CYSQCarSettlementListViewModel()
    
    // 订单详情列表视图懒加载
    lazy var orderDetailStatus = QZHOrderDetailListViewModel()
    
    // 订单列表视图模型懒加载
    lazy var orderListStatus = QZHOrderListViewModel()
    
    // 头部状态显示
    var statusLabe:QZHUILabelView = QZHUILabelView()
    
    // 头部状态时间
    var statusTimeLabe:QZHUILabelView = QZHUILabelView()
    
    // 收货人姓名
    var personLabe:QZHUILabelView = QZHUILabelView()
    
    // 收货人电话
    var personPhoneLabe:QZHUILabelView = QZHUILabelView()
    
    //收货地址
    var addressLabe:QZHUILabelView = QZHUILabelView()
    
    // 订单号
    var orderNumberLabe:QZHUILabelView = QZHUILabelView()
    
    // 订单创建时间
    var orderTimeLabe:QZHUILabelView = QZHUILabelView()
    
    // 付款方式
    var payTypeView:QZHUIView = QZHUIView()
    var payTypeLabe:QZHUILabelView = QZHUILabelView()
    
    // 
    var orderInfoView:QZHUIView = QZHUIView()
    var orderInfoHeight:CGFloat = 0.0
    
    // 表头
    var tabHeader:QZHUIView = QZHUIView()
    
    // 底部
    var tabFooter:QZHUIView = QZHUIView()
    
    // 底部操作栏
    var bottom:QZHUIView = QZHUIView()
    
    // 删除订单
    var delBtn:QZHUILabelView = QZHUILabelView()
    
    // 追加评论
    var addCommentBtn:QZHUILabelView = QZHUILabelView()
    
    // 确认收货
    var confirmGoodsBtn:QZHUILabelView = QZHUILabelView()
    
    // 申请售后
    var applyAfterSaleBtn:QZHUILabelView = QZHUILabelView()
    
    // 取消订单
    var canelOrderBtn:QZHUILabelView = QZHUILabelView()
    
    // 去付款
    var payOrderBtn:QZHUILabelView = QZHUILabelView()
    
    // 提醒发货
    var remindDeliveryBtn:QZHUILabelView = QZHUILabelView()
    
    // 申请退款
    var applyRefundBtn:QZHUILabelView = QZHUILabelView()
    
    // 评价
    var commentBtn:QZHUILabelView = QZHUILabelView()
    
    override func loadData() {
        QZHOrderDetailModel.addressFlag = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    func getData(){
        self.orderDetailStatus.loadOrderDetail { (isSuccess) in
            self.refreahController?.endRefreshing()
            if isSuccess{
                self.tabbelView?.reloadData()
                let orderMain = self.orderDetailStatus.orderMainStatus[0].status
                let Address = self.orderDetailStatus.addressDetailStatus[0].status
                
                var statusStr:String = ""
                switch orderMain.status{
                case 0:
                    statusStr = "等待买家付款"
                    if orderMain.payType != 3{
                        self.canelOrderBtn.isHidden = false
                        self.canelOrderBtn.restorationIdentifier =  orderMain.orderNumber
                        self.canelOrderBtn.addOnClickLister(target: self, action: #selector(self.canelOrder(_:)))
                        self.canelOrderBtn.x = 420*PX
                    }
                    self.payOrderBtn.isHidden = false
                    self.payOrderBtn.restorationIdentifier =  orderMain.payNumber
                    self.payOrderBtn.addOnClickLister(target: self, action: #selector(self.pay(_:)))
                case 1:
                    statusStr = "等待卖家发货"
                    self.applyRefundBtn.isHidden = false
                    self.applyRefundBtn.restorationIdentifier =  orderMain.orderNumber
                    self.applyRefundBtn.addOnClickLister(target: self, action: #selector(self.afterSales(_:)))
                    self.applyRefundBtn.x = 420*PX
                    self.remindDeliveryBtn.isHidden = false
                    self.remindDeliveryBtn.restorationIdentifier =  orderMain.orderNumber
                    self.remindDeliveryBtn.addOnClickLister(target: self, action: #selector(self.TXFH(_:)))
                case 2:
                    statusStr = "卖家已发货"
                    self.confirmGoodsBtn.isHidden = false
                    self.confirmGoodsBtn.restorationIdentifier =  orderMain.orderNumber
                    self.confirmGoodsBtn.addOnClickLister(target: self, action: #selector(self.commite(_:)))
                case 3:
                    statusStr = "交易成功"
                    if orderMain.orderComment == 0{
                        self.commentBtn.isHidden = false
                        self.commentBtn.restorationIdentifier = orderMain.orderNumber
                        self.commentBtn.addOnClickLister(target: self, action: #selector(self.comment(_:)))
                        self.delBtn.x = 420*PX
                    }else{
                        
                    }
                    
                    //footerView.delBtn.x = 420*PX
                    self.delBtn.restorationIdentifier =  orderMain.orderNumber
                    self.delBtn.addOnClickLister(target: self, action: #selector(self.delOrder(_:)))
                    self.delBtn.isHidden = false
                case 4:
                    statusStr = "待审核"
                case 5:
                    statusStr = "退货中"
                case 6:
                    statusStr = "交易关闭"
                    self.delBtn.isHidden = false
                    self.delBtn.restorationIdentifier =  orderMain.orderNumber
                    self.delBtn.addOnClickLister(target: self, action: #selector(self.delOrder(_:)))
                case 7:
                    statusStr = "交易关闭"
                    self.delBtn.isHidden = false
                    self.delBtn.restorationIdentifier =  orderMain.orderNumber
                    self.delBtn.addOnClickLister(target: self, action: #selector(self.delOrder(_:)))
                default:
                    statusStr = ""
                }
                QZHOrderListModel.orderNumber = orderMain.orderNumber
                QZH_CYSQCarSettlementModel.payNumber = orderMain.payNumber
                self.statusLabe.text = statusStr
                self.statusTimeLabe.text = self.orderDetailStatus.time
            
                
                if !QZHOrderDetailModel.addressFlag{
                    
                    if Address.personName != "" {
                        self.personLabe.text = "收货人：\(Address.personName)"
                    }
                    
                    self.personPhoneLabe.text = Address.phone
                    if Address.area != "" || Address.detailedAddress != ""{
                        self.addressLabe.text = "收货地址：\(Address.area)\(Address.detailedAddress)"
                    }

                }else{
                    
                    if Address.personName != "" {
                        self.personLabe.text = "\(QZH_CYSQCarSettlementModel.person)"
                    }
                    
                    self.personPhoneLabe.text = QZH_CYSQCarSettlementModel.phone
                    if Address.area != "" || Address.detailedAddress != ""{
                        self.addressLabe.text = "\(QZH_CYSQCarSettlementModel.address)"
                    }
                }
                
                
                
                
                let logStatus = self.orderDetailStatus.orderLogStatus
                //self.orderInfoHeight = 82*PX
                self.orderInfo()
                self.orderNumberLabe.text = orderMain.orderNumber
                if orderMain.payType == 1{
                    self.payTypeLabe.text = "现金支付"
                }/*else if orderMain.payType == 1{
                    self.payTypeLabe.text = "订金支付"
                }*/else if orderMain.payType == 3{
                    self.payTypeLabe.text = "账期支付"
                }
                
                for i in 0..<logStatus.count{
                    self.orderInfoHeight = self.orderStatus(y: self.orderInfoHeight, titleStr: "\(logStatus[i].status.operateDesc)：", timeStr: logStatus[i].status.operateTime)
                }
            }
        }

    }

    
}

// MARK: - 设置页面 UI 样式
extension QZHOrderDetailViewController{
    override func setupUI() {
        super.setupUI()
        
        tabbelView?.register(UINib(nibName:"QZHOrderDetailCell",bundle:nil), forCellReuseIdentifier: cellId)
        tabbelView?.separatorStyle = .none
        tabbelView?.y = 128*PX
        tabbelView?.height = SCREEN_HEIGHT - 208*PX
        tabbelView?.backgroundColor = myColor().grayF0()
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                tabbelView?.y = 176*PX
                tabbelView?.height = SCREEN_HEIGHT - 324*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        
        tabHeader.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 303*PX, bgColor: myColor().grayF0())
        tabbelView?.tableHeaderView = tabHeader
        tabFooter.setupViews(x: 0, y: 0*PX, width: SCREEN_WIDTH, height: 221, bgColor: myColor().grayF0())
        tabbelView?.tableFooterView = tabFooter
        
        setupNav()
        
        setupStatus()
        setupAddress()
        
        orderInfo()
        
        setupBtn()
        
    }
    
    // 设置头部导航条
    func setupNav(){
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        self.title = "订单详情"
    }
    
    // 设置订单状态
    func setupStatus(){
        let statusView:QZHUIView = QZHUIView()
        statusView.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 122*PX,bgColor:UIColor(patternImage:UIImage(named:"Order_detailStatuaBg")!))
        tabHeader.addSubview(statusView)
        
        statusView.addSubview(statusLabe)
        statusLabe.setLabelView(20*PX, 40*PX, 300*PX, 42*PX, NSTextAlignment.left, UIColor.clear, UIColor.white, 30, "")
        
        statusView.addSubview(statusTimeLabe)
        statusTimeLabe.setLabelView(330*PX, 45*PX, 390*PX, 33*PX, NSTextAlignment.right, UIColor.clear, UIColor.white, 24, "")
    }
    
    // 设置收货人信息
    func setupAddress(){
        let personView:QZHUIView = QZHUIView()
        personView.setupViews(x: 0, y: 122*PX, width: SCREEN_WIDTH, height: 160*PX, bgColor: UIColor.white)
        tabHeader.addSubview(personView)
        
        personLabe.setLabelView(20*PX, 20*PX, 330*PX, 37, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 26, "收货人：")
        personView.addSubview(personLabe)
        
        personPhoneLabe.setLabelView(386*PX, 20*PX, 300*PX, 37*PX, NSTextAlignment.right, UIColor.clear, myColor().gray3(), 26, "")
        personView.addSubview(personPhoneLabe)
        
        addressLabe.setLabelView(20*PX, 74*PX, 666*PX, 80*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 26, "收货地址：")
        addressLabe.numberOfLines = 2
        addressLabe.lineBreakMode = .byTruncatingTail 
        personView.addSubview(addressLabe)
        // 修改地址
        let editAddress:QZHUIView = QZHUIView()
        editAddress.setupViews(x: 690*PX, y: 30*PX, width: 60*PX, height: 100*PX, bgColor: UIColor.white)
        editAddress.addOnClickLister(target: self, action: #selector(self.editAddress(_:)))
        personView.addSubview(editAddress)
        let editImg:UIImageView = UIImageView(frame:CGRect(x:11*PX,y:35*PX,width:18*PX,height:30*PX))
        editImg.image = UIImage(named:"rightOpen1")
        editAddress.addSubview(editImg)
        
    }
    
    // 订单基本信息
    func orderInfo(){
        tabFooter.addSubview(orderInfoView)
        orderInfoView.setupViews(x: 0, y: 20*PX, width: SCREEN_WIDTH, height: 221*PX, bgColor: UIColor.white)
        
        let orderNumberTitle:QZHUILabelView = QZHUILabelView()
        orderNumberTitle.setLabelView(20*PX, 25*PX, 150*PX, 33*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 24, "订单编号：")
        orderInfoView.addSubview(orderNumberTitle)
        orderNumberLabe.setLabelView(160*PX, 25*PX, 450*PX, 33*PX ,NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 24, "")
        orderInfoView.addSubview(orderNumberLabe)
        
        let copy:QZHUILabelView = QZHUILabelView()
        copy.setLabelView(650*PX, 18*PX, 80*PX, 28*PX, NSTextAlignment.center, UIColor.clear, myColor().gray9(), 20, "复制")
        copy.layer.borderWidth = 1*PX
        copy.layer.borderColor = myColor().gray9().cgColor
        copy.addOnClickLister(target: self, action: #selector(self.copyPasteBoard))
        orderInfoView.addSubview(copy)
        
        orderInfoHeight = 82*PX
        
        payTypeView.setupViews(x: 0, y: orderInfoHeight, width: SCREEN_WIDTH, height: 81*PX, bgColor: UIColor.clear)
        orderInfoView.addSubview(payTypeView)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 0, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        payTypeView.addSubview(line)
        
        let payTitle:QZHUILabelView = QZHUILabelView()
        payTitle.setLabelView(20*PX, 25*PX, 150*PX, 33*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 24, "付款方式:")
        payTypeView.addSubview(payTitle)
        
        payTypeLabe.setLabelView(160*PX, 25*PX, 450*PX, 33*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 24, "")
        payTypeView.addSubview(payTypeLabe)
    }
    
    func orderStatus(y:CGFloat,titleStr:String,timeStr:String)->CGFloat{
        var top = y
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(20*PX, y, 150*PX, 33*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 24, titleStr)
        orderInfoView.addSubview(title)
        
        let info:QZHUILabelView = QZHUILabelView()
        info.setLabelView(160*PX, y, 450*PX, 33*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 24, timeStr)
        orderInfoView.addSubview(info)
        
        top = top + 57*PX
        payTypeView.y = top
        
        return top
    }
    
    // 设置操作按钮
    func setupBtn(){
        // 设置地步操作栏
        bottom.setupViews(x: 0, y: SCREEN_HEIGHT-80*PX, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                bottom.setupViews(x: 0, y: SCREEN_HEIGHT-144*PX, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
            }
            
        } else {
            // Fallback on earlier versions
        }
        self.view.addSubview(bottom)
        
        // 删除订单
        delBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "删除订单")
        delBtn.layer.borderColor = myColor().grayD().cgColor
        delBtn.layer.borderWidth = 1*PX
        delBtn.isHidden = true
        bottom.addSubview(delBtn)
        
        // 追加评论
        addCommentBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 26, "追加评价")
        addCommentBtn.layer.borderColor = myColor().blue007aff().cgColor
        addCommentBtn.layer.borderWidth = 1*PX
        addCommentBtn.isHidden = true
        bottom.addSubview(addCommentBtn)
        
        // 确认收货
        confirmGoodsBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 26, "确认收货")
        confirmGoodsBtn.layer.borderColor = myColor().blue007aff().cgColor
        confirmGoodsBtn.layer.borderWidth = 1*PX
        confirmGoodsBtn.isHidden = true
        bottom.addSubview(confirmGoodsBtn)
        
        // 申请售后
        applyAfterSaleBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "申请售后")
        applyAfterSaleBtn.layer.borderColor = myColor().grayD().cgColor
        applyAfterSaleBtn.layer.borderWidth = 1*PX
        applyAfterSaleBtn.isHidden = true
        bottom.addSubview(applyAfterSaleBtn)
        
        // 取消订单
        canelOrderBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "取消订单")
        canelOrderBtn.layer.borderColor = myColor().grayD().cgColor
        canelOrderBtn.layer.borderWidth = 1*PX
        canelOrderBtn.isHidden = true
        bottom.addSubview(canelOrderBtn)
        
        // 去付款
        payOrderBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 26, "去付款")
        payOrderBtn.layer.borderColor = myColor().blue007aff().cgColor
        payOrderBtn.layer.borderWidth = 1*PX
        payOrderBtn.isHidden = true
        bottom.addSubview(payOrderBtn)
        
        // 提醒发货
        remindDeliveryBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 26, "提醒发货")
        remindDeliveryBtn.layer.borderColor = myColor().blue007aff().cgColor
        remindDeliveryBtn.layer.borderWidth = 1*PX
        remindDeliveryBtn.isHidden = true
        bottom.addSubview(remindDeliveryBtn)
        
        // 申请退款
        applyRefundBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "申请退款")
        applyRefundBtn.layer.borderColor = myColor().grayD().cgColor
        applyRefundBtn.layer.borderWidth = 1*PX
        applyRefundBtn.isHidden = true
        bottom.addSubview(applyRefundBtn)
        
        // 评价
        commentBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 26, "评价")
        commentBtn.layer.borderColor = myColor().blue007aff().cgColor
        commentBtn.layer.borderWidth = 1*PX
        commentBtn.isHidden = true
        bottom.addSubview(commentBtn)
    }
}

// MARK: - 数据源绑定
extension QZHOrderDetailViewController{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 81*PX
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.orderDetailStatus.orderMainStatus.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80*PX
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = QZH_CYSQCarTableViewHeader.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:81*PX))
        headerView.setupOrderListHeaderStoreName(self.orderDetailStatus.orderMainStatus[0].status.supplyMemberName)
        headerView.storeIcon.tag = self.orderDetailStatus.orderMainStatus[0].status.supplyMemberId
        
        let shop:QZHUIView = QZHUIView()
        shop.setupViews(x: 0, y: 0, width: 540*PX, height: 80*PX, bgColor: UIColor.clear)
        headerView.addSubview(shop)
        shop.addOnClickLister(target: self, action: #selector(self.gotToShop(_:)))
        
        let contactView:QZHUIView = QZHUIView()
         headerView.addSubview(contactView)
        contactView.setupViews(x: 540*PX, y: 0, width: 190*PX, height: 80*PX, bgColor: UIColor.clear)
        contactView.tag =  self.orderDetailStatus.orderMainStatus[0].status.supplySalesmanId
        contactView.addOnClickLister(target: self, action:  #selector(self.contactSupply(_:)))
        
        let contactTitle:QZHUILabelView = QZHUILabelView()
        contactTitle.setLabelView(0, 24*PX, 150*PX, 33*PX, NSTextAlignment.right, UIColor.clear, myColor().gray3(), 24, "联系卖家")
        contactView.addSubview(contactTitle)
        let contactICon:UIImageView = UIImageView(frame:CGRect(x:164*PX,y:27*PX,width:26*PX,height:26*PX))
        contactICon.image = UIImage(named:"Order_DetailContact")
        contactView.addSubview(contactICon)
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView:QZHUIView = QZHUIView()
        footView.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(20*PX, 24*PX, 80*PX, 33*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, "需付款")
        footView.addSubview(title)
        //self.orderDetailStatus.orderMainStatus[0].status.supplyMemberId
        let price:QZHUILabelView = QZHUILabelView()
        let width = price.autoLabelWidth("\(self.orderDetailStatus.orderMainStatus[0].status.orderAmountTotal.roundTo(places: 2))", font: 38, height: 50*PX)
        price.setLabelView(SCREEN_WIDTH - width - 20*PX, 14*PX, width, 50*PX, NSTextAlignment.right, UIColor.clear, myColor().redFf4300(), 32, "\(self.orderDetailStatus.orderMainStatus[0].status.orderAmountTotal.roundTo(places: 2))")
        price.setRealWages(price.text!, big: 32, small: 24, fg: ".")
        footView.addSubview(price)
        
        let icon:QZHUILabelView = QZHUILabelView()
        icon.setLabelView(price.x - 20*PX, 25*PX, 20*PX, 35*PX, NSTextAlignment.right, UIColor.clear, myColor().redFf4300(), 24, "¥")
        footView.addSubview(icon)
        
        return footView
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 181*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHOrderDetailCell
        let proInfo = self.orderDetailStatus.orderSubStatus[indexPath.row].status
        
        if proInfo.picPath != ""{
            if let url = URL(string: proInfo.picPath) {
                cell.proImg.downloadedFrom(url: url)
            }else{
                cell.proImg.image = UIImage(named:"noPic")
            }
        }else{
            cell.proImg.image = UIImage(named:"noPic")
        }
        
        cell.proNAme.text = proInfo.productName
        
        cell.proSpec.text = proInfo.specDesc
        
        cell.count.text = "x\(proInfo.pCount)"
        
        if proInfo.proPrice == 0.0 || proInfo.proPrice == 0{
            cell.proprice.text = "\(proInfo.originalPrice.roundTo(places: 2))"
            cell.proprice.setRealWages(cell.proprice.text!, big: 28, small: 20, fg: ".")
            cell.proprice.width = cell.proprice.autoLabelWidth("\(proInfo.originalPrice.roundTo(places: 2))", font: 38, height: 40*PX)
        }else{
            cell.proprice.text = "\(proInfo.proPrice.roundTo(places: 2))"
            cell.proprice.setRealWages(cell.proprice.text!, big: 28, small: 20, fg: ".")
            cell.proprice.width = cell.proprice.autoLabelWidth("\(proInfo.proPrice.roundTo(places: 2))", font: 38, height: 40*PX)
            
            cell.oldPrice.text = "¥\(proInfo.originalPrice.roundTo(places: 2))"
            let attriText = NSAttributedString(string:cell.oldPrice.text!,attributes:[NSStrikethroughStyleAttributeName:1])
            cell.oldPrice.attributedText = attriText
            cell.oldPrice.width = cell.oldPrice.autoLabelWidth("\(proInfo.originalPrice.roundTo(places: 2))", font: 30, height: 40*PX)
        }
        cell.tag = proInfo.goodsId
        
        cell.addOnClickLister(target: self, action: #selector(self.goToProDetail1(_:)))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.orderDetailStatus.orderSubStatus.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight:CGFloat = 81*PX
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    
    // 删除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //tableView.deleteRows(at: [indexPath], with: .top)
    }
}

// MARK: - 监听方法
extension QZHOrderDetailViewController{
    //返回
    func close(){
        if QZHOrderDetailModel.fromPage == "list"{
            dismiss(animated: true, completion: nil)
        }else if QZHOrderDetailModel.fromPage == "Pay"{
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    // 修改地址
    func editAddress(_ sender:UITapGestureRecognizer){
        let nav = QZHSelAddressViewController()
        self.present(nav, animated: true, completion: nil)
    }
    
    // 产品详情
    func goToProDetail1(_ sender:UITapGestureRecognizer){
        let _this = sender.view
        QZHProductDetailModel.goodsId = (_this?.tag)!
        
        let nav = QZHProductDetailViewController()
        present(nav, animated: true, completion: nil)
        
    }

    // 进入店铺
    func gotToShop(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHStoreInfoModel.memberID = (this?.tag)!
        
        print("店铺ID:\(QZHStoreInfoModel.memberID)")
        let vc = QZHStoreIndexViewController()
        
        present(vc, animated: true, completion: nil)
    }
    
    // 联系卖家
    func contactSupply(_ sender:UITapGestureRecognizer){
        let this = sender.view
        //selfQZHStoreInfoModel.memberID = this?.tag
    }
    
    // 复制
    func copyPasteBoard() {
        
        let str:String! = orderNumberLabe.text!
        
        //就这两句话就实现了
        let paste = UIPasteboard.general
        paste.string = str
        
        
    }
    
    // 去支付
    func pay(_ sender:UITapGestureRecognizer){
        QZHOrderDetailModel.fromPage = "listPay"
        //let nav = QZHPayViewController()
        //nav.modalPresentationStyle = .overCurrentContext
        //self.present(nav, animated: true, completion: nil)
        
        payNow()
    }
    // 立即付款
    func payNow(){
        
        self.listStatus.paynow(completion: { (isSuccess,urlString) in
            if let url = URL(string: urlString) {
                print(url)
                //根据iOS系统版本，分别处理
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:],
                                              completionHandler: {
                                                (success) in
                    })
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
            if QZHOrderListModel.from == 11{
                let nav = QZHOrderViewController()
                self.present(nav, animated: true, completion: nil)
            }else if QZHOrderListModel.from == 0{
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    // 取消订单
    func canelOrder(_ sender:UITapGestureRecognizer){
        QZHOrderListModel.statusInfo = "cancelDeal"
        self.orderListStatus.editOrderStatus { (isSuccess, msg) in
            UIAlertController.showAlert(message: msg, in: self)
            self.getData()
            self.tabbelView?.reloadData()
        }
    }
    
    // 删除订单
    func delOrder(_ sender:UITapGestureRecognizer){
        self.orderListStatus.delOrder { (isSuccess, msg) in
            UIAlertController.showAlert(message: msg, in: self)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // 追加评论
    func addComment(_ sender:UITapGestureRecognizer){
    }
    
    // 申请售后
    func afterSales(_ sender:UITapGestureRecognizer){
        UIAlertController.showAlert(message: "联系客服", in: self)
    }
    
    // 确认收货
    func commite(_ sender:UITapGestureRecognizer){
        QZHOrderListModel.statusInfo = "returnRequest"
        self.orderListStatus.editOrderStatus { (isSuccess, msg) in
            UIAlertController.showAlert(message: msg, in: self)
            self.getData()
            self.tabbelView?.reloadData()
        }
    }
    
    // 提醒发货
    func TXFH(_ sender:UITapGestureRecognizer){
        UIAlertController.showAlert(message: "联系客服", in: self)
    }

    
    // 评价
    func comment(_ sender:UITapGestureRecognizer){
        let this:UIView = sender.view!
        QZHCommentModel.orderNum = this.restorationIdentifier!
        let nav = QZHCommentViewController()
        present(nav, animated: true, completion: nil)
    }
}
