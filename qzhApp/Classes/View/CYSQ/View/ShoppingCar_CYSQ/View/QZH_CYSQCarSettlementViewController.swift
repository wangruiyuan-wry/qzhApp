//
//  QZH_CYSQCarSettlementViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/19.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZH_CYSQCarSettlementViewController: QZHBaseViewController {
    
    // 结算列表视图模型懒加载
    lazy var listStatus = QZH_CYSQCarSettlementListViewModel()
    
    // 表头设置
    var tableHeader:QZHUIView = QZHUIView()
    
    // 收货地址
    var nameLabel:QZHUILabelView = QZHUILabelView()
    var phoneLabel:QZHUILabelView = QZHUILabelView()
    var addressLabel:QZHUILabelView = QZHUILabelView()
    
    // 底部工具栏
    var bottom:QZHUIView = QZHUIView()
    
    // 合计金额
    var totalSum:QZHUILabelView = QZHUILabelView()
    
    // 付款方式
    var payTypeLabel:QZHUILabelView = QZHUILabelView()
    var payWayView:QZHUIView = QZHUIView()
    var bgView:QZHUIView = QZHUIView()
    var paySel:[String:AnyObject] = [:]
    
    // 支付方式
    var  payMoneyType:QZHUILabelView = QZHUILabelView()
    
    override func loadData() {
        self.listStatus.getOrderList { (isSuccess,totalMoney) in
            self.tabbelView?.reloadData()
            QZH_CYSQCarSettlementModel.person = "收货人：\(self.listStatus.addressStatus[0].status.person)"
            QZH_CYSQCarSettlementModel.phone = self.listStatus.addressStatus[0].status.phone
            QZH_CYSQCarSettlementModel.address = "收货地址：\(self.listStatus.addressStatus[0].status.areaInfo)\(self.listStatus.addressStatus[0].status.detailAddress)"
            QZH_CYSQCarSettlementModel.addressId = self.listStatus.addressStatus[0].status.addressId
            
            self.nameLabel.text = QZH_CYSQCarSettlementModel.person
            
            self.phoneLabel.text = QZH_CYSQCarSettlementModel.phone
            
            self.addressLabel.text = QZH_CYSQCarSettlementModel.address
            
            self.totalSum.text = "\(totalMoney.roundTo(places: 2))"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.nameLabel.text = QZH_CYSQCarSettlementModel.person
        
        self.phoneLabel.text = QZH_CYSQCarSettlementModel.phone
        
        self.addressLabel.text = QZH_CYSQCarSettlementModel.address
    }
}

// MARK: - 页面 UI 样式设置
extension QZH_CYSQCarSettlementViewController{
    override func setupUI() {
        super.setupUI()
        
        self.isPush = true
        // 注册原型 cell
        tabbelView?.register(UINib(nibName:"QZHCarJYTableViewCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        tabbelView?.y = 128*PX
        tabbelView?.height = SCREEN_HEIGHT - 228*PX
        tabbelView?.backgroundColor = myColor().grayF0()
        tabbelView?.isEditing = false
        tabbelView?.allowsMultipleSelectionDuringEditing = true
        tabbelView?.separatorStyle = .none
        
        setupNav()
        
        setupTableHeader()
        
        setupBottom("0.00")
        
        
        setuppayWays()
    }
    
    // 设置表格头
    func setupTableHeader(){
        tableHeader.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 180*PX, bgColor: myColor().grayF0())
        tabbelView?.tableHeaderView = tableHeader
        let addressView:QZHUIView = QZHUIView()
        addressView.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 168*PX, bgColor: UIColor.white)
        tableHeader.addSubview(addressView)
        
        // 收货人姓名
        nameLabel.setLabelView(20*PX, 20*PX, 350*PX, 37*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 26, "收货人：")
        addressView.addSubview(nameLabel)
        
        // 电话号码
        phoneLabel.setLabelView(364*PX, 20*PX, 300*PX, 37*PX, NSTextAlignment.right, UIColor.white, myColor().gray3(), 26, "")
        addressView.addSubview(phoneLabel)
        
        // 收货地址
        addressLabel.setLabelView(20*PX, 77*PX, 666*PX, 80*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 26, "收货地址：")
        addressLabel.numberOfLines = 2
        addressLabel.lineBreakMode = .byWordWrapping
        addressView.addSubview(addressLabel)
        
        // 修改地址
        let editAddress:QZHUIView = QZHUIView()
        editAddress.setupViews(x: 690*PX, y: 30*PX, width: 60*PX, height: 100*PX, bgColor: UIColor.white)
        editAddress.addOnClickLister(target: self, action: #selector(self.editAddress(_:)))
        addressView.addSubview(editAddress)
        let editImg:UIImageView = UIImageView(frame:CGRect(x:11*PX,y:35*PX,width:18*PX,height:30*PX))
        editImg.image = UIImage(named:"rightOpen1")
        editAddress.addSubview(editImg)
    }
    
    // 设置导航条
    func setupNav(){
        self.title = "确认订单"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon2", target: self, action: #selector(self.close),color:UIColor.white)
    }
    
    // 设置底部提交
    func setupBottom(_ total:String){
        bottom.setupViews(x: 0, y: SCREEN_HEIGHT-101*PX, width: SCREEN_WIDTH, height: 101*PX, bgColor: UIColor.white)
        self.view.addSubview(bottom)
        
        let lines:QZHUILabelView = QZHUILabelView()
        lines.dividers(0, y: 0, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        bottom.addSubview(lines)
        
        // 提交按钮
        let submitBtn:UIButton = UIButton()
        submitBtn.frame = CGRect(x:550*PX,y:1*PX,width:200*PX,height:100*PX)
        submitBtn.setTitle("提交订单", for: .normal)
        submitBtn.backgroundColor = myColor().blue007aff()
        submitBtn.tintColor = UIColor.white
        submitBtn.addTarget(self, action: #selector(self.submitOrder(_:)), for: .touchUpInside)
        bottom.addSubview(submitBtn)
        
        let totalWidth = totalSum.autoLabelWidth(total, font: 40, height: 50*PX)
        totalSum.setLabelView(530*PX-totalWidth, 25*PX, totalWidth, 50*PX, NSTextAlignment.right, UIColor.white, myColor().redFf4300(), 34, total)
        totalSum.setRealWages(total, big:34, small: 28, fg: ".")
        bottom.addSubview(totalSum)
        
        let priceIcon:QZHUILabelView = QZHUILabelView()
        priceIcon.setLabelView(510*PX-totalWidth, 30*PX, 20*PX, 40*PX, NSTextAlignment.right, UIColor.white, myColor().redFf4300(), 28, "¥")
        bottom.addSubview(priceIcon)
        
        let titleLabel:QZHUILabelView = QZHUILabelView()
        titleLabel.setLabelView(340*PX - totalWidth, 30*PX, 150*PX, 40*PX, NSTextAlignment.right, UIColor.white, myColor().gray3(), 28, "合计金额:")
        bottom.addSubview(titleLabel)
    }
    
    // 设置付款方式
    func setuppayWays(){
        bgView.blackBackground(y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        bgView.isHidden = true
        bgView.addOnClickLister(target: self, action: #selector(self.closePayWayView))
        self.view.addSubview(bgView)
        
        payWayView.setupViews(x: 0, y: SCREEN_HEIGHT-605*PX, width: SCREEN_WIDTH, height: 605*PX, bgColor: UIColor.white)
        self.view.addSubview(payWayView)
        payWayView.isHidden = true
        
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(0, 19*PX, SCREEN_WIDTH, 42*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 30, "付款方式")
        payWayView.addSubview(title)
        
        let canelBtn:QZHUILabelView = QZHUILabelView()
        canelBtn.setLabelView(0, 505*PX, 375*PX, 100*PX, NSTextAlignment.center, myColor().blue00b9ff(), UIColor.white, 32, "取消")
        canelBtn.addOnClickLister(target: self, action: #selector(self.closePayWayView))
        payWayView.addSubview(canelBtn)
        
        let okBtn:QZHUILabelView = QZHUILabelView()
        okBtn.setLabelView(375*PX, 505*PX, 375*PX, 100*PX, NSTextAlignment.center, myColor().blue007aff(), UIColor.white, 32, "确定")
        okBtn.addOnClickLister(target: self, action: #selector(self.payType(_:)))
        payWayView.addSubview(okBtn)
        
        let payType = [["name":"全额支付","TypeId":1],["name":"定金支付","TypeId":1],["name":"账期支付（30天）","TypeId":1],["name":"账期支付（45天）","TypeId":1],["name":"账期支付（60天）","TypeId":1]]
        
        var top = 80*PX
        for i in 0..<payType.count{
            top = self.setupPAyType(parent: payWayView, y: top, payType: payType[i] as [String : AnyObject],num:i)
        }
        
    }
    func setupPAyType(parent:QZHUIView,y:CGFloat,payType:[String:AnyObject],num:Int)->CGFloat{
        var top = y
        
        let btnView:QZHUIView = QZHUIView()
        btnView.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: 82*PX, bgColor: UIColor.white)
        btnView.tag = payType["TypeId"] as! Int
        parent.addSubview(btnView)
        btnView.restorationIdentifier = "btn"
        btnView.addOnClickLister(target: self, action: #selector(self.payTypeAction(_:)))
        
        let typeView:QZHUILabelView = QZHUILabelView()
        typeView.restorationIdentifier = "label"
        typeView.setLabelView(20*PX, 22*PX, 300*PX, 37*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 26, payType["name"] as! String)
        btnView.addSubview(typeView)
        
        let img:UIImageView = UIImageView(frame:CGRect(x:691*PX,y:28*PX,width:38*PX,height:24*PX))
        img.image = UIImage(named:"hookIcon")
        img.isHidden = true
        img.restorationIdentifier = "img"
        img.restorationIdentifier = typeView.text
        btnView.addSubview(img)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(20*PX, y: 80*PX, width: 730*PX, height: 1*PX, color: myColor().grayF0())
        line.restorationIdentifier = "line"
        btnView.addSubview(line)
        
        if num == 0{
            img.isHidden = false
            typeView.textColor = myColor().blue007aff()
        }
        
        top = top + 81*PX
        
        return top
    }
    
}

// MARK: - 数据源绑定
extension QZH_CYSQCarSettlementViewController{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 82*PX
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = self.listStatus.storeStatus.count
        count = count + 1
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 182*PX
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let index = section + 1
        if index == tableView.numberOfSections{
            let headerView = QZHUIView()
            headerView.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
            let title:QZHUILabelView = QZHUILabelView()
            title.setLabelView(20*PX, 20*PX, 150*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "付款方式:")
            headerView.addSubview(title)
            
            
            payTypeLabel.setLabelView(230*PX, 20*PX, 450*PX, 40*PX, NSTextAlignment.right, UIColor.white, myColor().Gray6(), 28, "全额支付")
            headerView.addSubview(payTypeLabel)
            
            let payBtn:UIImageView = UIImageView(frame:CGRect(x:708*PX,y:28*PX,width:14*PX,height:24*PX))
            payBtn.image = UIImage(named:"rightIcon")
            headerView.addSubview(payBtn)
            
            headerView.addOnClickLister(target: self, action: #selector(self.checkPayType(_sender:)))
            
            return headerView
        }else{
            let headerView = QZH_CYSQCarTableViewHeader.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:81*PX))
            headerView.setupOrderListHeaderStoreName(self.listStatus.storeStatus[section].status.storeName)
            headerView.storeIcon.tag = self.listStatus.storeStatus[section].status.storeId
            return headerView
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = QZH_CYSQCarTableViewFooter.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:182*PX))
        let index = section + 1
        if index != tableView.numberOfSections{
            footView.setupTotal(count: "\(self.listStatus.storeStatus[section].status.subTotalNum)", total: "\(self.listStatus.storeStatus[section].status.subTotalMoney)")
            return footView
        }else{
            footView.height = 0
            return footView
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 181*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHCarJYTableViewCell
        
        let proStatus = self.listStatus.proStatus[indexPath.section][indexPath.row]
        if proStatus.status.productInfo["picturePath"] as! String == ""{
            cell.proImg.image = UIImage(named:"noPic")
        }else{
            cell.proImg.image = UIImage(data:PublicFunction().imgFromURL(proStatus.status.productInfo["picturePath"] as! String))
        }
        
        cell.proName.text = proStatus.status.productInfo["productName"] as! String
        cell.proSpec.text = proStatus.status.specOptionName
        
        if proStatus.status.productInfo["promotionPrice"] is NSNull || proStatus.status.productInfo["promotionPrice"]as!Double == 0.0{
            cell.sellPrice.text = "\((proStatus.status.productInfo["promotionPrice"]! as!Double).roundTo(places: 2))"
            cell.price.text = "\((proStatus.status.productInfo["originalPrice"]! as!Double).roundTo(places: 2))"
            let attriText = NSAttributedString(string:cell.price.text!,attributes:[NSStrikethroughStyleAttributeName:1])
            cell.price.attributedText = attriText
            
        }else{
            cell.sellPrice.text = "\((proStatus.status.productInfo["originalPrice"]! as!Double).roundTo(places: 2))"
        }
        cell.price.x = 230*PX + cell.sellPrice.width
        
        cell.proCount.text = "x\(proStatus.status.productCount)"
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let index = section + 1
        if index == tableView.numberOfSections{
            return 0
        }else{
            return self.listStatus.proStatus[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //组头高度
        let sectionHeaderHeight:CGFloat = 80*PX
        //组尾高度
        let sectionFooterHeight:CGFloat = 181*PX
        
        //获取是否有默认调整的内边距
        let defaultEdgeTop:CGFloat = navigationController?.navigationBar != nil
            && self.automaticallyAdjustsScrollViewInsets ? 64 : 0
        
        //上边距相关
        var edgeTop = defaultEdgeTop
        if scrollView.contentOffset.y >= -defaultEdgeTop &&
            scrollView.contentOffset.y <= sectionHeaderHeight - defaultEdgeTop  {
            edgeTop = -scrollView.contentOffset.y
        }
        else if (scrollView.contentOffset.y>=sectionHeaderHeight - defaultEdgeTop) {
            edgeTop = -sectionHeaderHeight + defaultEdgeTop
        }
        
        //下边距相关
        var edgeBottom:CGFloat = 182*PX
        let b = scrollView.contentOffset.y + scrollView.frame.height
        let h = scrollView.contentSize.height - sectionFooterHeight
        
        if b <= h {
            edgeBottom = -182*PX
        }else if b > h && b < scrollView.contentSize.height {
            edgeBottom = b - h - 182*PX
        }
        
        //设置内边距
        scrollView.contentInset = UIEdgeInsetsMake(edgeTop, 0, edgeBottom, 0)
    }
    
    // 删除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //tableView.deleteRows(at: [indexPath], with: .top)
    }
}

// MARK: - 监听方法
extension QZH_CYSQCarSettlementViewController{
    
    // 返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 提交订单
    func submitOrder(_ sender:UIButton){}
    
    // 修改地址
    func editAddress(_ sender:UITapGestureRecognizer){
        let nav = QZHSelAddressViewController()
        self.present(nav, animated: true, completion: nil)
        
        /*self.dismiss(animated: true){
            self.present(nav, animated: true, completion: nil)
        }*/
    }
    
    // 选择支付方式
    func checkPayType(_sender:UITapGestureRecognizer){
        payWayView.isHidden = false
        bgView.isHidden = false
        
        let children = payWayView.subviews
        for child in children{
            if child.restorationIdentifier == "btn"{
                let viewArray = child.subviews
                for views in viewArray{
                    if views.restorationIdentifier == "label"{
                        (views as! QZHUILabelView).textColor = myColor().gray3()
                        if (views as! QZHUILabelView).text == payTypeLabel.text{
                            (views as! QZHUILabelView).textColor = myColor().blue007aff()
                        }
                    }else if views.restorationIdentifier != "line"{
                        views.isHidden = true
                        if views.restorationIdentifier == payTypeLabel.text{
                            views.isHidden = false
                        }
                    }
                }
            }
        }

    }
    
    // 点击选择付款方式
    func payTypeAction(_ sender:UITapGestureRecognizer){
        let _this = sender.view
        let children = payWayView.subviews
        for child in children{
            if child.restorationIdentifier == "btn"{
                let viewArray = child.subviews
                for views in viewArray{
                    if views.restorationIdentifier == "label"{
                        (views as! QZHUILabelView).textColor = myColor().gray3()
                    }else if views.restorationIdentifier != "line"{
                        views.isHidden = true
                    }
                }
            }
        }
        
        let thisChildren = _this?.subviews
        for thisChild in thisChildren!{
            if thisChild.restorationIdentifier == "label"{
                (thisChild as! QZHUILabelView).textColor = myColor().blue007aff()
                paySel.updateValue((thisChild as! QZHUILabelView).text as AnyObject, forKey: "name")
                paySel.updateValue((thisChild as! QZHUILabelView).tag as AnyObject, forKey: "TypeId")
            }else {
                thisChild.isHidden = false
            }
        }
    }
    
    // 关闭遮罩层以及付款方式
    func closePayWayView(){
        payWayView.isHidden = true
        bgView.isHidden = true
    }
    
    // 确定所选付款方式
    func payType(_ sender:UITapGestureRecognizer){
        closePayWayView()
        self.payTypeLabel.text = paySel["name"]! as! String
        self.payTypeLabel.tag = paySel["TypeId"]! as! Int
    }
}
