//
//  QZHStoreInfoViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/7.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHStoreInfoViewController: QZHBaseViewController {
    // 店铺信息数据列表视图模型
    lazy var StoreInfo = QZHStoreIndexViewModel()
    
    // 店铺图片
    var logo:UIImageView = UIImageView()
    
    // 店铺名称
    var nameLabel:QZHUILabelView = QZHUILabelView()
    
    // 会员等级
    var vipLabel:QZHUILabelView = QZHUILabelView()
    
    // 会员图片
    var vipIcon:UIImageView = UIImageView()
    
    // 关注
    var careBtn:QZHUIView = QZHUIView()
    
    // 取消关注
    var careBtn1:QZHUIView = QZHUIView()
    
    // 好评率
    var rate:QZHUILabelView = QZHUILabelView()
    
    // 商品评价
    var proRate:QZHUILabelView = QZHUILabelView()
    
    // 服务评价
    var serviceRate:QZHUILabelView = QZHUILabelView()
    
    // 公司名称
    var companyName:QZHUILabelView = QZHUILabelView()
    
    // 行业
    var Industry:QZHUILabelView = QZHUILabelView()
    
    // 经营类型
    var businessType:QZHUILabelView = QZHUILabelView()
    
    // 所在地区
    var address:QZHUILabelView = QZHUILabelView()
    
    // 客服
    var customerService:QZHUILabelView = QZHUILabelView()
    
    // 是否关注
    var isAttents:Int = 0
    
    override func loadData() {
        // 店铺信息的获取
        StoreInfo.getStoreInfo { (other,isSuccess) in
            
            if isSuccess{
                // 店铺信息映射
                self.isAttents = other["isAttent"] as! Int
                
                // 图片
                if self.StoreInfo.storeInfo[0].status.storeLogo == ""{
                    self.logo.image = UIImage(named:"noPic")
                }else{
                    if let url = URL(string: self.StoreInfo.storeInfo[0].status.storeLogo) {
                        self.logo.downloadedFrom(url: url)
                    }else{
                        self.logo.image = UIImage(named:"noPic")
                    }
                }
                
                // 店铺名称
                self.nameLabel.text = self.StoreInfo.storeInfo[0].status.shortName
                
                // 会员等级
                if self.StoreInfo.storeInfo[0].status.memberLevel != ""{
                    self.vipIcon.isHidden = false
                    self.vipLabel.text = self.StoreInfo.storeInfo[0].status.memberLevel
                }
                
                // 关注
                print("self.isAttents:\(self.isAttents)")
                if self.isAttents == 0{
                    self.careBtn.isHidden = false
                    self.careBtn1.isHidden = true
                }else{
                    self.careBtn1.isHidden = false
                    self.careBtn.isHidden = true
                }
                
                // 好评率
                self.rate.text = "\(self.StoreInfo.storeInfo[0].status.rateAll)%"
                
                // 商品评价
                self.proRate.text = "\(self.StoreInfo.storeInfo[0].status.rateProduct)"
                
                // 服务评价
                self.serviceRate.text = "\(self.StoreInfo.storeInfo[0].status.rateService)"
                
                // 公司名称
                self.companyName.text = other["name"] as! String
                
                // 行业
                self.Industry.text = other["storeIndustryName"] as! String
                
                // 经营类型
                if self.StoreInfo.storeInfo[0].status.managementTypes == 1{
                    self.businessType.text = "经销批发"
                }else if  self.StoreInfo.storeInfo[0].status.managementTypes == 2{
                    self.businessType.text = "商业服务"
                }else if self.StoreInfo.storeInfo[0].status.managementTypes == 3{
                    self.businessType.text = "生产行"
                }else if self.StoreInfo.storeInfo[0].status.managementTypes == 4{
                    self.businessType.text = "招商代理"
                }else if self.StoreInfo.storeInfo[0].status.managementTypes == 5{
                    self.businessType.text = "政府组织／机构"
                }
                
                // 所在地
                self.address.text = other["areaName"] as! String
                
                // 客服
                self.customerService.text = self.StoreInfo.storeInfo[0].status.customerService.components(separatedBy: ",")[0]
            }
        }

    }
    
}

// MARK: - 页面 UI设置
extension QZHStoreInfoViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        // 去掉 tableview 分割线
        self.tabbelView?.separatorStyle = .none
        
        // 设置 tabbleView 背景色
        self.tabbelView?.backgroundColor = UIColor.white
        
        // 注册原型 cell
         tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        //tabbelView?.isHidden = true
        tabbelView?.y = 127*PX
        tabbelView?.height = SCREEN_HEIGHT - 127*PX
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                tabbelView?.top = 176*PX
                tabbelView?.height = SCREEN_HEIGHT - 243*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        // 设置导航条
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends),color:UIColor.white)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon2", target: self, action: #selector(self.close),color:UIColor.white)
        self.title = "店铺简介"
        
        setStoreInfo()
        
        setupRate()
        
        setupCompanyInfo()
        
        setCustomer()
    }
    
    // 设置店铺信息
    func setStoreInfo(){
        let storeInfo:QZHUIView = QZHUIView()
        storeInfo.setupViews(x: 0, y: 10*PX, width: SCREEN_WIDTH, height: 140*PX, bgColor: UIColor.white)
        self.tabbelView?.addSubview(storeInfo)
        
        // 设置店铺图片
        storeInfo.addSubview(logo)
        logo.frame = CGRect(x:20*PX,y:20*PX,width:100*PX,height:100*PX)
        logo.image = UIImage(named:"loadPic")
        
        // 设置店铺图片
        storeInfo.addSubview(nameLabel)
        nameLabel.setLabelView(140*PX, 28*PX, 400*PX, 42*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 30, "")
        
        // 设置会员
        storeInfo.addSubview(vipIcon)
        vipIcon.frame = CGRect(x:140*PX,y:85*PX,width:25*PX,height:25*PX)
        vipIcon.image = UIImage(named:"proVIPcon")
        vipIcon.isHidden = true
        
        storeInfo.addSubview(vipLabel)
        vipLabel.setLabelView(170*PX, 82*PX, 130*PX, 30*PX, NSTextAlignment.left, UIColor.white, myColor().yellowF5d96c(), 22, "")
        
        // 是否关注
        storeInfo.addSubview(careBtn)
        careBtn.setupViews(x: 620*PX, y: 44*PX, width: 110*PX, height: 60*PX, bgColor: myColor().blue007aff())
        careBtn.layer.cornerRadius = 6*PX
        careBtn.layer.borderColor = myColor().blue007aff().cgColor
        careBtn.layer.borderWidth = 1*PX
        careBtn.addOnClickLister(target: self, action: #selector(self.careClick))
        careBtn.tag = 0
        let careIcon:UIImageView = UIImageView(frame:CGRect(x:13*PX,y:15*PX,width:30*PX,height:30*PX))
        careIcon.image = UIImage(named:"storeCare")
        careBtn.addSubview(careIcon)
        let careTitle:QZHUILabelView = QZHUILabelView()
        careTitle.setLabelView(53*PX, 15*PX, 50*PX, 30*PX, NSTextAlignment.left, UIColor.clear, UIColor.white, 22, "关注")
        careBtn.addSubview(careTitle)
        careBtn.isHidden = false
        
        careBtn1.setupViews(x: 620*PX, y: 44*PX, width: 110*PX, height: 60*PX, bgColor: UIColor.white)
        careBtn1.layer.borderColor = myColor().blue007aff().cgColor
        careBtn1.layer.borderWidth = 1*PX
        careBtn1.layer.cornerRadius = 6*PX
        careBtn1.addOnClickLister(target: self, action: #selector(self.careClick))
        careBtn1.tag = 1
        let careTitle1:QZHUILabelView = QZHUILabelView()
        careTitle1.setLabelView(5*PX, 15*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().blue007aff(), 22, "已关注")
        careBtn1.addSubview(careTitle1)
        storeInfo.addSubview(careBtn1)
        careBtn.isHidden = true
    }
    
    // 评价
    func setupRate(){
        // 评价模块
        let rateView:QZHUIView = QZHUIView()
        rateView.setupViews(x: 0, y: 160*PX, width: SCREEN_WIDTH, height: 240*PX, bgColor: UIColor.white)
        self.tabbelView?.addSubview(rateView)
        
        // 好评率
        let title1:QZHUILabelView = QZHUILabelView()
        title1.setLabelView(20*PX, 20*PX, 120*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "好评率")
        rateView.addSubview(title1)
        rateView.addSubview(rate)
        rate.setLabelView(190*PX, 20*PX, 150*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "")
        
        // 商品评价
        let title2:QZHUILabelView = QZHUILabelView()
        title2.setLabelView(20*PX, 100*PX, 120*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "商品评价")
        rateView.addSubview(title2)
        rateView.addSubview(proRate)
        proRate.setLabelView(190*PX, 100*PX, 150*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().redFf4300(), 28, "")
        
        // 服务评价
        let title3:QZHUILabelView = QZHUILabelView()
        title3.setLabelView(20*PX, 180*PX, 120*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "服务评价")
        rateView.addSubview(title3)
        rateView.addSubview(serviceRate)
        serviceRate.setLabelView(190*PX, 180*PX, 150*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().redFf4300(), 28, "")
    }
    
    // 设置公司信息
    func setupCompanyInfo(){
        // 设置公司信息模块
        let companyInfo:QZHUIView = QZHUIView()
        companyInfo.setupViews(x: 0, y: 410*PX, width: SCREEN_WIDTH, height: 320*PX, bgColor: UIColor.white)
        self.tabbelView?.addSubview(companyInfo)
        
        // 公司名称
        let title1:QZHUILabelView = QZHUILabelView()
        title1.setLabelView(20*PX, 20*PX, 120*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "公司名称")
        companyInfo.addSubview(title1)
        companyInfo.addSubview(companyName)
        companyName.setLabelView(190*PX, 20*PX, 548*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "")
        
        // 行业
        let title2:QZHUILabelView = QZHUILabelView()
        title2.setLabelView(20*PX, 100*PX, 120*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "行业")
        companyInfo.addSubview(title2)
        companyInfo.addSubview(Industry)
        Industry.setLabelView(190*PX, 100*PX, 548*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "")
        
        // 经营类型
        let title3:QZHUILabelView = QZHUILabelView()
        title3.setLabelView(20*PX, 180*PX, 120*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "经营类型")
        companyInfo.addSubview(title3)
        companyInfo.addSubview(businessType)
        businessType.setLabelView(190*PX, 180*PX, 548*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "")
        
        // 所在地
        let title4:QZHUILabelView = QZHUILabelView()
        title4.setLabelView(20*PX, 260*PX, 120*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "所在地")
        companyInfo.addSubview(title4)
        companyInfo.addSubview(address)
        address.setLabelView(190*PX, 260*PX, 548*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "")
    }
    
    // 客服
    func setCustomer(){
        let customerView:QZHUIView = QZHUIView()
        customerView.setupViews(x: 0, y: 740*PX, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
        self.tabbelView?.addSubview(customerView)
        
        let title1:QZHUILabelView = QZHUILabelView()
        title1.setLabelView(20*PX, 20*PX, 120*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "客服")
        customerView.addSubview(title1)
        customerView.addSubview(customerService)
        
        customerService.setLabelView(190*PX, 20*PX, 400*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "")
        
        let icon:UIImageView = UIImageView(frame:CGRect(x:690*PX,y:20*PX,width:40*PX,height:40*PX))
        icon.image = UIImage(named:"customerServiceIcon")
        customerView.addSubview(icon)

    }
}

// MARK: - 数据源绑定
// MARK: - 绑定数据源
extension QZHStoreInfoViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 1
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 830*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = myColor().grayF0()
        return cell
    }
    
    /// 捕捉滚动条动作
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}

// MARK: - 监听方法
extension QZHStoreInfoViewController{
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        //navigationController?.pushViewController(vc, animated: true)
    }
    // 返回
    func close(){
       dismiss(animated: true, completion: nil)
    }
    
    // 是否关注
    func careClick(){
        if isAttents == 1{
            StoreInfo.delet(completion: { (isSuccess) in
                if isSuccess{
                    self.careBtn.isHidden = false
                    self.careBtn1.isHidden = true
                }else{
                    print("shiba")
                }
            })
        }else{
            StoreInfo.insert(completion: { (isSuccess) in
                if isSuccess{
                    self.careBtn.isHidden = true
                    self.careBtn1.isHidden = false
                }
                else{
                    print("shiba")
                }
            })
        }
    }
    
    // 客服
    func chat(_ sender:UITapGestureRecognizer){
        
    }
}
