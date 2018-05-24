//
//  QZHCompanyContactViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/3.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHCompanyContactViewController: QZHBaseViewController {
    
    // 公司信息视图列表模型懒加载
     lazy var companyStatus = QZHMarketCompanyListViewModel()
    
    //联系人
    var contactLabel:QZHUILabelView = QZHUILabelView()
    
    // 职位
    var depLabel:QZHUILabelView = QZHUILabelView()
    
    //公司电话
    var telLabel:QZHUILabelView = QZHUILabelView()
    
    //手机
    var moblieLabel:QZHUILabelView = QZHUILabelView()
    
    //邮件
    var emmailLabel:QZHUILabelView = QZHUILabelView()
    
    //地区
    var areaLabel:QZHUILabelView = QZHUILabelView()
    
    //详细地址
    var addressLabel:QZHUILabelView = QZHUILabelView()
    
    //传真
    var faxLabel:QZHUILabelView = QZHUILabelView()
    
    //邮编
    var zoopCodeLabel:QZHUILabelView = QZHUILabelView()

    var bodyView:QZHUIView = QZHUIView()
    
    // 电话号码
    var phoneNum:QZHUIView = QZHUIView()
    var phoneNumCanel:QZHUILabelView = QZHUILabelView()
    var telNum:QZHUILabelView = QZHUILabelView()
    var mobileNum:QZHUILabelView = QZHUILabelView()
    
    override func loadData() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.companyStatus.loadCompany { (isSuccess) in
            self.contactLabel.text = self.companyStatus.Company[0].status.nickName
            self.depLabel.text = ""
            self.telLabel.text = self.companyStatus.CompanyInfo[0].status.tel
            self.moblieLabel.text = self.companyStatus.Company[0].status.mobile
            self.emmailLabel.text = self.companyStatus.CompanyInfo[0].status.email
            self.areaLabel.text = self.companyStatus.Company[0].status.pca
            
            self.addressLabel.text = self.companyStatus.Company[0].status.address
            //self.addressLabel.height = self.addressLabel.autoLabelHeight(self.companyStatus.Company[0].status.address, font: 28, width: self.addressLabel.width)
            let Height = self.addressLabel.autoLabelHeight(self.companyStatus.Company[0].status.address, font: 28, width: self.addressLabel.width)
            if Height > self.addressLabel.height{}else{
                self.addressLabel.height = Height
            }
            
            self.faxLabel.text = self.companyStatus.CompanyInfo[0].status.fax
        }
        
    }
   
}

// 设置界面
extension QZHCompanyContactViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        //注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationBar.isHidden = true
        tabbelView?.separatorStyle = .none
        tabbelView?.height = SCREEN_HEIGHT - 310*PX
        let line:QZHUILabelView = QZHUILabelView()
        //tabbelView?.backgroundColor = UIColor.red
        
        line.dividers(0, y: 0, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        view.addSubview(line)
        setupViewUI()
        
        tabbelView?.tableHeaderView = bodyView
        
        setupBottom()
    }
    
    // 设置底部操作栏
    func setupBottom(){
        let bottom:QZHUIView = QZHUIView()
        bottom.setupViews(x: 0, y: SCREEN_HEIGHT-310*PX, width: SCREEN_WIDTH, height: 100*PX, bgColor: myColor().blue007aff())
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                bottom.y = SCREEN_HEIGHT-388*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        self.view.addSubview(bottom)
        
        let line1:QZHUILabelView = QZHUILabelView()
        line1.dividers(250*PX, y: 10*PX, width: 1*PX, height: 80*PX, color: UIColor.white)
        bottom.addSubview(line1)
        
        let line2:QZHUILabelView = QZHUILabelView()
        line2.dividers(499*PX, y: 10*PX, width: 1*PX, height: 80*PX, color: UIColor.white)
        bottom.addSubview(line2)
        
        let _telImg:UIImageView = UIImageView(frame:CGRect(x:100*PX,y:25*PX,width:50*PX,height:50*PX))
        _telImg.image = UIImage(named:"Market_Tel")
        bottom.addSubview(_telImg)
        
        let _smImg:UIImageView = UIImageView(frame:CGRect(x:351*PX,y:27*PX,width:49*PX,height:47*PX))
        _smImg.image = UIImage(named:"Market_SM")
        bottom.addSubview(_smImg)
        
        let emailImg:UIImageView = UIImageView(frame:CGRect(x:600*PX,y:31*PX,width:50*PX,height:38*PX))
        emailImg.image = UIImage(named:"Market_Email")
        bottom.addSubview(emailImg)
        
        let telBtn:QZHUIView = QZHUIView()
        telBtn.setupViews(x: 10*PX, y: 0, width: 230*PX, height: 100*PX, bgColor: UIColor.clear)
        telBtn.addOnClickLister(target: self, action: #selector(self.callTel(_:)))
        bottom.addSubview(telBtn)
        
        let smBtn:QZHUIView = QZHUIView()
        smBtn.setupViews(x: 261*PX, y: 0, width: 228*PX, height: 100*PX, bgColor: UIColor.clear)
        smBtn.addOnClickLister(target: self, action: #selector(self.sendSMS(_:)))
        bottom.addSubview(smBtn)
        
        let emailBtn:QZHUIView = QZHUIView()
        emailBtn.setupViews(x: 510*PX, y: 0, width: 230*PX, height: 100*PX, bgColor: UIColor.clear)
        emailBtn.addOnClickLister(target: self, action: #selector(self.sendEmail(_:)))
        bottom.addSubview(emailBtn)
        
        phoneNum.setupViews(x: 200*PX, y: (SCREEN_HEIGHT - 242*PX)/2, width: 350*PX, height: 242*PX, bgColor: myColor().GrayF1F2F6())
        phoneNum.layer.borderColor = myColor().grayEB().cgColor
        phoneNum.layer.borderWidth = 1*PX
        phoneNum.layer.cornerRadius = 5*PX
        phoneNum.layer.masksToBounds = true
        phoneNum.isHidden = true
        phoneNumCanel.setLabelView(0, 162*PX, phoneNum.width, 80*PX, NSTextAlignment.center, myColor().blue007aff(), UIColor.white, 28, "取消拨打")
        phoneNumCanel.addOnClickLister(target: self, action: #selector(self.canelPhone))
        phoneNum.addSubview(phoneNumCanel)
        
        telNum.setLabelView(0, 0, phoneNum.width, 80*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 28, "")
        let lin1:QZHUILabelView = QZHUILabelView()
        lin1.dividers(0, y: 80*PX, width: phoneNum.width, height: 1*PX, color: myColor().grayEB())
        telNum.addSubview(lin1)
        telNum.addOnClickLister(target: self, action: #selector(self.call(_:)))
        phoneNum.addSubview(telNum)
        
        mobileNum.setLabelView(0, 81*PX, phoneNum.width, 80*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 28, "")
        let lin2:QZHUILabelView = QZHUILabelView()
        lin2.dividers(0, y: 161*PX, width: phoneNum.width, height: 1*PX, color: myColor().grayEB())
        mobileNum.addSubview(lin2)
        mobileNum.addOnClickLister(target: self, action: #selector(self.call(_:)))
        phoneNum.addSubview(mobileNum)
        self.view.addSubview(phoneNum)
    }
    
    // 设置选择电话号码
    func checkPhone(_ tel:String,_ mobile:String){
        phoneNum.isHidden = false
        telNum.text = "拨打：\(tel)"
        telNum.restorationIdentifier = tel
        
        mobileNum.text = "拨打：\(mobile)"
        mobileNum.restorationIdentifier = mobile
    }
    
    // 设置界面
    func setupViewUI(){
        bodyView.setupViews(x: 0, y: 1*PX, width: SCREEN_WIDTH, height: SCREEN_HEIGHT, bgColor: UIColor.white)
        
        // 联系人
        let contactView:QZHUIView = QZHUIView()
        self.setupListView(selfView: contactView, y: 0, title: "联系人", childView: contactLabel)
        bodyView.addSubview(contactView)
        
        let depView:QZHUIView = QZHUIView()
        self.setupListView(selfView: depView, y: 82*PX, title: "职位", childView: depLabel)
        bodyView.addSubview(depView)
        
        //公司电话
        let telView:QZHUIView = QZHUIView()
        self.setupListView(selfView: telView, y: 164*PX, title: "公司电话", childView: telLabel)
        bodyView.addSubview(telView)
        
        //手机
        let moblieView:QZHUIView = QZHUIView()
        self.setupListView(selfView: moblieView, y: 246*PX, title: "手机", childView: moblieLabel)
        bodyView.addSubview(moblieView)
        
        //邮件
        let emilView:QZHUIView = QZHUIView()
        self.setupListView(selfView: emilView, y: 328*PX, title: "邮件" , childView: emmailLabel)

        bodyView.addSubview(emilView)
        
        //地区
        let areaView:QZHUIView = QZHUIView()
        self.setupListView(selfView: areaView, y: 410*PX, title: "地区", childView: areaLabel )
        bodyView.addSubview(areaView)
        
        //详细地址
        let addressView:QZHUIView = QZHUIView()
        self.setupListView(selfView: addressView, y: 492*PX, height: 170*PX, title: "详细地址", childView: addressLabel,childViewHeight: 100*PX)
        addressLabel.numberOfLines = 2
        addressLabel.lineBreakMode = NSLineBreakMode.byCharWrapping
        bodyView.addSubview(addressView)
        
        //传真
        let faxView:QZHUIView = QZHUIView()
        self.setupListView(selfView: faxView, y: 664*PX, title: "传真", childView: faxLabel)
        bodyView.addSubview(faxView)
        
        bodyView.height =  760*PX
        
     }
    
    // 列表项 UI 样式设置
    func setupListView(selfView:QZHUIView,y:CGFloat,height:CGFloat = 80*PX,title:String,childView:QZHUILabelView,childViewHeight:CGFloat = 40*PX){
        selfView.frame = CGRect(x:0,y:y,width:SCREEN_WIDTH,height:height)
        selfView.backgroundColor = UIColor.white
    
        
        let titleLabel:QZHUILabelView = QZHUILabelView()
        titleLabel.setLabelView(19*PX, 21*PX, 150*PX, 30*PX, NSTextAlignment.left, UIColor.clear, myColor().gray9(), 28, title)
        selfView.addSubview(titleLabel)
        
        childView.setLabelView(156*PX, 15*PX, 575*PX,childViewHeight, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, "")
        selfView.addSubview(childView)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: height-2*PX, width: 750*PX, height: 2*PX, color: myColor().grayF0())
        selfView.addSubview(line)
    }
}

// MARK: - 数据源绑定
extension QZHCompanyContactViewController{
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

// MARK: - 监听方法
extension QZHCompanyContactViewController{
    
    //打电话
    func callTel(_ sender:QZHUIButton){
        let tel:String! = self.telLabel.text!
        let phone:String! = self.moblieLabel.text!
        if tel != "" && phone != ""{
            checkPhone(tel, phone)
        }else if tel == ""{
            PublicFunction().telCall(phone, ownself: self)
        }else if phone == "" {
            print(tel)
            PublicFunction().telCall(tel, ownself: self)
        }
    }
    
    // 拨打电话
    func call(_ sender:UITapGestureRecognizer){
        let this = sender.view
        PublicFunction().telCall((this?.restorationIdentifier)!, ownself: self)
    }
    
    // 取消拨打电话
    func canelPhone(){
        phoneNum.isHidden = true
    }
    
    //发短信
    func sendSMS(_ sender:QZHUIButton){
        let num:String! = self.moblieLabel.text!
        PublicFunction().sendTexting(num, ownself: self)
    }
    
    //发邮件
    func sendEmail(_ sender:QZHUIButton){
        let email:String! = self.emmailLabel.text!
        PublicFunction().emailSend(email, ownself: self)
    }
}
