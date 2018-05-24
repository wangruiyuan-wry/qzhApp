//
//  QZHOrderList_AfterSaleViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/30.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHOrderList_AfterSaleViewController: QZHBaseViewController {

    // 订单列表视图模型懒加载
    lazy var orderListStatus = QZHOrderListViewModel()
    lazy var listStatus = QZH_CYSQCarSettlementListViewModel()
    
    override func loadData() {
        getData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData()
    }
    
    func getData(){
        QZHOrderListModel.status = 8
        self.orderListStatus.getOrderList(pullup: self.isPulup) { (isSuccess, shouldRefresh) in
            //结束刷新控件
            self.refreahController?.endRefreshing()
            
            //恢复上拉刷新标记
            self.isPulup = false
            
            //刷新表
            if shouldRefresh {
                
                self.tabbelView?.reloadData()
                
            }
            
        }
    }
}

// MARK: - 设置页面 UI 样式
extension QZHOrderList_AfterSaleViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        navigationBar.isHidden = true
        tabbelView?.separatorStyle = .none
        tabbelView?.frame = CGRect(x:0, y: 1, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-210*PX-2)
        
        //注册 tableView
        tabbelView?.register(UINib(nibName:"QZHOrderListTableViewCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        let line:QZHUILabelView = QZHUILabelView()
        
        line.divider(0, y: 0, width: Int(SCREEN_WIDTH), height: 1, color: myColor().grayF0())
        view.addSubview(line)
    }
}

// MARK: - 绑定tableView数据源
extension QZHOrderList_AfterSaleViewController{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 81*PX
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.orderListStatus.OrderMainList.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 182*PX
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = QZHOrderListFooter.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:162*PX))
        footerView.backgroundColor = myColor().grayF0()
        let _mainOrder = self.orderListStatus.OrderMainList[section].status
        footerView.restorationIdentifier = _mainOrder.payNumber
        footerView.setupFooter(_mainOrder.orderCountTotal, _mainOrder.orderAmountTotal)
        var statusStr:String = ""
        switch self.orderListStatus.OrderMainList[section].status.status {
        case 0:
            if self.orderListStatus.OrderMainList[section].status.payType != 3{
                footerView.canelOrderBtn.isHidden = false
                footerView.canelOrderBtn.restorationIdentifier =  _mainOrder.orderNumber
                footerView.canelOrderBtn.addOnClickLister(target: self, action: #selector(self.canelOrder(_:)))
                footerView.canelOrderBtn.x = 420*PX
            }
            footerView.payOrderBtn.isHidden = false
            footerView.payOrderBtn.restorationIdentifier =  _mainOrder.payNumber
            footerView.payOrderBtn.addOnClickLister(target: self, action: #selector(self.pay(_:)))
        case 1:
            footerView.applyRefundBtn.isHidden = false
            footerView.applyRefundBtn.restorationIdentifier =  _mainOrder.orderNumber
            footerView.applyRefundBtn.addOnClickLister(target: self, action: #selector(self.afterSales(_:)))
            footerView.applyRefundBtn.x = 420*PX
            footerView.remindDeliveryBtn.isHidden = false
            footerView.remindDeliveryBtn.restorationIdentifier =  _mainOrder.orderNumber
            footerView.remindDeliveryBtn.addOnClickLister(target: self, action: #selector(self.TXFH(_:)))
        case 2:
            footerView.confirmGoodsBtn.isHidden = false
            footerView.confirmGoodsBtn.restorationIdentifier =  _mainOrder.orderNumber
            footerView.confirmGoodsBtn.addOnClickLister(target: self, action: #selector(self.commite(_:)))
        case 3:
            statusStr = "交易成功"
            if _mainOrder.orderComment == 0{
                footerView.commentBtn.isHidden = false
                footerView.commentBtn.restorationIdentifier =  _mainOrder.orderNumber
                footerView.commentBtn.addOnClickLister(target: self, action: #selector(self.comment(_:)))
                footerView.delBtn.x = 420*PX
            }else{
                
            }
            
            //footerView.delBtn.x = 420*PX
            footerView.delBtn.restorationIdentifier =  _mainOrder.orderNumber
            footerView.delBtn.addOnClickLister(target: self, action: #selector(self.delOrder(_:)))
            footerView.delBtn.isHidden = false
        case 4:
            statusStr = "待审核"
        case 5:
            statusStr = "退货中"
        case 6:
            statusStr = "交易关闭"
            footerView.delBtn.isHidden = false
            footerView.delBtn.restorationIdentifier =  _mainOrder.orderNumber
            footerView.delBtn.addOnClickLister(target: self, action: #selector(self.delOrder(_:)))
        case 7:
            statusStr = "交易关闭"
            footerView.delBtn.isHidden = false
            footerView.delBtn.restorationIdentifier =  _mainOrder.orderNumber
            footerView.delBtn.addOnClickLister(target: self, action: #selector(self.delOrder(_:)))
        default:
            statusStr = ""
        }
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = QZHOrderListHeader.init(frame:CGRect(x:0,y:0,width:SCREEN_WIDTH,height:81*PX))
        var statusStr:String = ""
        switch self.orderListStatus.OrderMainList[section].status.status {
        case 0:
            statusStr = "等待买家付款"
        case 1:
            statusStr = "等待卖家发货"
        case 2:
            statusStr = "卖家已发货"
        case 3:
            statusStr = "交易成功"
        case 4:
            statusStr = "待审核"
        case 5:
            statusStr = "退货中"
        case 6:
            statusStr = "交易关闭"
        case 7:
            statusStr = "交易关闭"
        default:
            statusStr = ""
        }
        headerView.setupStoreName(self.orderListStatus.OrderMainList[section].status.supplyMemberName, statusStr)
        headerView.shop.tag = self.orderListStatus.OrderMainList[section].status.supplyMemberId
        headerView.shop.addOnClickLister(target: self, action: #selector(self.goToStore(_:)))
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 181*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHOrderListTableViewCell
        let proInfo = self.orderListStatus.OrderSubList[indexPath.section][indexPath.row].status
        let orderMain = self.orderListStatus.OrderMainList[indexPath.section].status
        cell.restorationIdentifier = orderMain.orderNumber
        
        if proInfo.picPath == ""{
            cell.proImg.image = UIImage(named:"noPic")
        }else{
            if let url = URL(string: proInfo.picPath) {
                cell.proImg.downloadedFrom(url: url)
            }else{
                cell.proImg.image = UIImage(named:"noPic")
            }
        }
        
        cell.proName.text = proInfo.productName
        cell.proSpec.text = proInfo.specDesc
        
        if proInfo.proPrice.roundTo(places: 2) != 0 && proInfo.proPrice.roundTo(places: 2) != 0.0{
            cell.sellPrice.text = "\(proInfo.proPrice.roundTo(places: 2))"
            //cell.sellPrice.width = cell.sellPrice.autoLabelWidth(cell.sellPrice.text!, font: 38, height: cell.sellPrice.height)
            cell.sellPrice.setRealWages(cell.sellPrice.text!, big: 28, small: 20, fg: ".")
            
            cell.price.text = "¥\(proInfo.originalPrice.roundTo(places: 2))"
            cell.price.x = cell.sellPrice.width + cell.sellPrice.x + 10*PX
            let attriText = NSAttributedString(string:cell.price.text!,attributes:[NSStrikethroughStyleAttributeName:1])
            cell.price.attributedText = attriText
        }else{
            cell.sellPrice.text = "\(proInfo.originalPrice.roundTo(places: 2))"
            //cell.sellPrice.width = cell.sellPrice.autoLabelWidth(cell.sellPrice.text!, font: 38, height: cell.sellPrice.height)
            cell.sellPrice.setRealWages(cell.sellPrice.text!, big: 28, small: 20, fg: ".")
            
            cell.price.text = "¥\(proInfo.originalPrice.roundTo(places: 2))"
            cell.price.x = cell.sellPrice.width + cell.sellPrice.x + 10*PX
            let attriText = NSAttributedString(string:cell.price.text!,attributes:[NSStrikethroughStyleAttributeName:1])
            cell.price.attributedText = attriText
        }
        
        cell.proCount.text = "x\(proInfo.pCount)"
        
        cell.addOnClickLister(target: self, action: #selector(self.gotoOrderDetail(_:)))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListStatus.OrderSubList[section].count
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
    
}

// MARK: - 方法监听
extension QZHOrderList_AfterSaleViewController{
    
    // 进入店铺
    func goToStore(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHStoreInfoModel.memberID = (this?.tag)!
        let vc = QZHStoreIndexViewController()
        
        present(vc, animated: true, completion: nil)
    }
    
    // 进入订单详情
    func gotoOrderDetail(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHOrderDetailModel.orderNumber = (this?.restorationIdentifier)!
        QZHOrderDetailModel.fromPage = "list"
        let nav = QZHOrderDetailViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 去支付
    func pay(_ sender:UITapGestureRecognizer){
        QZHOrderDetailModel.fromPage = "listPay"
        QZH_CYSQCarSettlementModel.payNumber = ((sender.view)?.restorationIdentifier)!
        
        payNow()
        //let nav = QZHPayViewController()
        //nav.modalPresentationStyle = .overCurrentContext
        //self.present(nav, animated: true, completion: nil)
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
        QZHOrderListModel.orderNumber = ((sender.view)?.restorationIdentifier)!
        QZHOrderListModel.statusInfo = "cancelDeal"
        QZHOrderListModel.flag = "back"
        self.orderListStatus.editOrderStatus { (isSuccess, msg) in
            UIAlertController.showAlert(message: msg, in: self)
            self.getData()
            self.tabbelView?.reloadData()
        }
    }
    
    // 删除订单
    func delOrder(_ sender:UITapGestureRecognizer){
        QZHOrderListModel.orderNumber = ((sender.view)?.restorationIdentifier)!
        QZHOrderListModel.flag = ""
        self.orderListStatus.delOrder { (isSuccess, msg) in
            UIAlertController.showAlert(message: msg, in: self)
            self.getData()
            self.tabbelView?.reloadData()
        }
    }
    
    // 追加评论
    func addComment(_ sender:UITapGestureRecognizer){
        QZHOrderListModel.orderNumber = ((sender.view)?.restorationIdentifier)!
    }
    
    // 申请售后
    func afterSales(_ sender:UITapGestureRecognizer){
        QZHOrderListModel.orderNumber = ((sender.view)?.restorationIdentifier)!
        UIAlertController.showAlert(message: "联系客服", in: self)
    }
    
    // 确认收货
    func commite(_ sender:UITapGestureRecognizer){
        QZHOrderListModel.orderNumber = ((sender.view)?.restorationIdentifier)!
        QZHOrderListModel.flag = ""
        QZHOrderListModel.statusInfo = "returnRequest"
        self.orderListStatus.editOrderStatus { (isSuccess, msg) in
            UIAlertController.showAlert(message: msg, in: self)
            self.getData()
            self.tabbelView?.reloadData()
            
        }
    }
    
    // 提醒发货
    func TXFH(_ sender:UITapGestureRecognizer){
        QZHOrderListModel.orderNumber = ((sender.view)?.restorationIdentifier)!
        UIAlertController.showAlert(message: "联系客服", in: self)
    }
    
    // 评价
    func comment(_ sender:UITapGestureRecognizer){
        let this:UIView = sender.view!
        QZHCommentModel.orderNum = this.restorationIdentifier!
        QZHOrderDetailModel.orderNumber = this.restorationIdentifier!
        let nav = QZHCommentViewController()
        present(nav, animated: true, completion: nil)
    }
    
}
