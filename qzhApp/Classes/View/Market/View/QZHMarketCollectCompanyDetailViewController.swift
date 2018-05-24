//
//  QZHMarketCollectCompanyDetailViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/4.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHMarketCollectCompanyDetailViewController: QZHBaseViewController {
    
    // 企业详情视图模型懒加载
    lazy var company = QZHMarketCompanyListViewModel()
    
    var body:QZHUIView = QZHUIView()
    
    // 公司logo
    var logo:UIImageView = UIImageView()
    
    // 联系人
    var person:QZHUILabelView = QZHUILabelView()
    
    // 职位
    var depart:QZHUILabelView = QZHUILabelView()
    
    // 公司电话
    var tel:QZHUILabelView = QZHUILabelView()
    
    // 手机
    var moblie:QZHUILabelView = QZHUILabelView()
    
    // 邮件
    var email:QZHUILabelView = QZHUILabelView()
    
    // 地区
    var area:QZHUILabelView = QZHUILabelView()
    
    // 详细地址
    var address:QZHUILabelView = QZHUILabelView()
    
    // 传真
    var fax:QZHUILabelView = QZHUILabelView()
    
    // 公司简介
    var remark:QZHUILabelView = QZHUILabelView()
    var remarkTitle:QZHUILabelView = QZHUILabelView()
    
    // 主营产品
    var mainPro:QZHUILabelView = QZHUILabelView()
    var mainProTitle:QZHUILabelView = QZHUILabelView()
    
    // 主购产品
    var purPro:QZHUILabelView = QZHUILabelView()
    var purProTitle:QZHUILabelView = QZHUILabelView()
    
    // 录入方式
    var entry:QZHUILabelView = QZHUILabelView()
    
    // 创建时间
    var creatTime:QZHUILabelView = QZHUILabelView()
    
    // 修改时间
    var editTime:QZHUILabelView = QZHUILabelView()

    // 电话号码
    var phoneNum:QZHUIView = QZHUIView()
    var phoneNumCanel:QZHUILabelView = QZHUILabelView()
    var telNum:QZHUILabelView = QZHUILabelView()
    var mobileNum:QZHUILabelView = QZHUILabelView()
    
    // 
    var top:CGFloat = 0.0
    var foot:QZHUIView = QZHUIView()
    
    override func loadData() {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.company.loadCompany { (isSuccess) in
            self.tabbelView?.reloadData()
            let info = self.company.CompanyInfo[0].status
            let Companyinfo = self.company.Company[0].status
            
            self.person.text = Companyinfo.nickName
            self.depart.text = ""
            
            self.tel.text = info.tel
            self.moblie.text = Companyinfo.mobile
            
            self.email.text = info.email
            self.fax.text = info.fax
            
            let Height = self.address.autoLabelHeight(Companyinfo.address, font: 28, width: self.address.width)
            self.address.text = Companyinfo.address
            if Height > self.address.height{}else{
                self.address.height = Height
            }
            self.area.text = Companyinfo.pca

            if info.remark != "" {
                self.setupInfo(info.remark)
            }else{
                self.setupInfo("暂无公司简介")
            }
            
            if Companyinfo.purchasingProduct != ""{
                self.setupPurPro(Companyinfo.purchasingProduct)
            }else{
                self.setupPurPro("暂无主购产品")
            }
            
            if Companyinfo.mainProduct != ""{
                self.setupMainPro(Companyinfo.purchasingProduct)
            }else{
                self.setupMainPro("暂无主营产品")
            }
            
            self.entry.text = "手动录入"
            self.creatTime.text = info.createDate
            self.editTime.text = info.createDate
        }

    }
}

// MARK: - 设置页面 UI 样式
extension QZHMarketCollectCompanyDetailViewController{
    override func setupUI() {
        super.setupUI()
        //设置导航栏按钮
        //navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "编辑", target: self, action: #selector(close))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        
        self.title = QZHMarketCompanyInfoModel.companyName
        
        body.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT, bgColor: UIColor.white)
        
        tabbelView?.frame = CGRect(x:0, y: 128*PX, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-228*PX)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                tabbelView?.frame = CGRect(x:0, y: 176*PX, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-442*PX)
            }
            
        } else {
            // Fallback on earlier versions
        }
        tabbelView?.separatorStyle = .none
        tabbelView?.backgroundColor = UIColor.white
        
        //注册原型 cell
        tabbelView?.register(UINib(nibName:"QZHMarketCompanyCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        self.setupLogo()
        
        self.setupInfoViewUI()
        
        self.setupInfo("暂无简介")
        self.setupPurPro("暂无主购产品")
        self.setupMainPro("暂无主营产品")
        
        self.setupAddTime()
        
        tabbelView?.tableHeaderView = body
        self.setupBottom()
        
    }
    
    // 设置公司 Logo 
    func setupLogo(){
        logo.frame = CGRect(x:225*PX,y:30*PX,width:300*PX,height:300*PX)
        logo.image = UIImage(named:"loadPic")
        body.addSubview(logo)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 359*PX, width: 750*PX, height: 2*PX, color: myColor().grayF0())
        body.addSubview(line)
        
        body.height = 361*PX
    }
    
    // 设置基本信息
    func setupInfoViewUI(){
        // 联系人
        let contactView:QZHUIView = QZHUIView()
        self.setupListView(selfView: contactView, y: body.height, title: "联系人", childView: person)
        body.addSubview(contactView)
        body.height =  contactView.height + contactView.y
        
        
        let depView:QZHUIView = QZHUIView()
        self.setupListView(selfView: depView, y: body.height, title: "职位", childView: depart)
        body.addSubview(depView)
        body.height =  depView.height + depView.y
        
        //公司电话
        let telView:QZHUIView = QZHUIView()
        self.setupListView(selfView: telView, y: body.height, title: "公司电话", childView: tel)
        body.addSubview(telView)
        body.height =  telView.height + telView.y
        
        //手机
        let moblieView:QZHUIView = QZHUIView()
        self.setupListView(selfView: moblieView, y: body.height, title: "手机", childView: moblie)
        body.addSubview(moblieView)
        body.height =  moblieView.height + moblieView.y
        
        //邮件
        let emilView:QZHUIView = QZHUIView()
        self.setupListView(selfView: emilView, y: body.height, title: "邮件" , childView: email)
        body.height =  emilView.height + emilView.y
        body.addSubview(emilView)
        
        //地区
        let areaView:QZHUIView = QZHUIView()
        self.setupListView(selfView: areaView, y: body.height, title: "地区", childView: area)
        body.addSubview(areaView)
        body.height =  areaView.height + areaView.y
        
        //详细地址
        let addressView:QZHUIView = QZHUIView()
        self.setupListView(selfView: addressView, y: body.height, height: 170*PX, title: "详细地址", childView: address,childViewHeight: 130*PX)
        address.numberOfLines = 3
        address.lineBreakMode = NSLineBreakMode.byCharWrapping
        body.addSubview(addressView)
        body.height =  addressView.height + addressView.y
        
        //传真
        let faxView:QZHUIView = QZHUIView()
        self.setupListView(selfView: faxView, y: body.height, title: "传真", childView: fax)
        body.addSubview(faxView)
        
        body.height =  faxView.height + faxView.y
        top = body.height + 30*PX
        
    }
    
    // 列表项 UI 样式设置
    func setupListView(selfView:QZHUIView,y:CGFloat,height:CGFloat = 80*PX,title:String,childView:QZHUILabelView,childViewHeight:CGFloat = 40*PX){
        selfView.frame = CGRect(x:0,y:y,width:SCREEN_WIDTH,height:height)
        selfView.backgroundColor = UIColor.white
        
        
        let titleLabel:QZHUILabelView = QZHUILabelView()
        titleLabel.setLabelView(19*PX, 19*PX, 150*PX, 30*PX, NSTextAlignment.left, UIColor.clear, myColor().gray9(), 28, title)
        selfView.addSubview(titleLabel)
        
        childView.setLabelView(156*PX, 17*PX, 575*PX,childViewHeight, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, "")
        selfView.addSubview(childView)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: height-2*PX, width: 750*PX, height: 2*PX, color: myColor().grayF0())
        selfView.addSubview(line)
    }
    
    // 设置公司简介
    func setupInfo(_ text:String){
        remarkTitle.setLabelView(55*PX, top, 640*PX, 32*PX, NSTextAlignment.center, UIColor.clear, UIColor.black, 32, "公司简介")
        body.height = remarkTitle.height+remarkTitle.y
        body.addSubview(remarkTitle)
        
        remark.setLabelView(55*PX, body.height+30*PX, 640*PX, purPro.autoLabelHeight(text, font: 28, width: 640*PX)+29*PX, NSTextAlignment.center, UIColor.clear, UIColor.black, 28, text)
        remark.numberOfLines = 0
        remark.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        body.height = remark.height+remark.y
        body.addSubview(remark)
    }
    
    //设置主营产品
    func setupMainPro(_ text:String){
        mainProTitle.setLabelView(55*PX, body.height+60*PX, 640*PX, 32*PX, NSTextAlignment.center, UIColor.clear, UIColor.black, 32, "主营产品")
        body.addSubview(mainProTitle)
        
        mainPro.setLabelView(55*PX, mainProTitle.height+mainProTitle.y+30*PX, 640*PX, purPro.autoLabelHeight(text, font: 28, width: 640*PX)+29*PX, NSTextAlignment.center, UIColor.clear, UIColor.black, 28, text)
        mainPro.numberOfLines = 0
        mainPro.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        body.height = mainPro.height+mainPro.y
        body.addSubview(mainPro)
    }
    
    //设置主购产品
    func setupPurPro(_ text:String){
        purProTitle.setLabelView(55*PX, body.height+60*PX, 640*PX, 32*PX, NSTextAlignment.center, UIColor.clear, UIColor.black, 32, "主购产品")
        body.addSubview(purProTitle)
        
        purPro.setLabelView(55*PX, purProTitle.height+purProTitle.y+30*PX, 640*PX, purPro.autoLabelHeight(text, font: 28, width: 640*PX)+29*PX, NSTextAlignment.center, UIColor.clear, UIColor.black, 28, text)
        purPro.numberOfLines = 0
        purPro.lineBreakMode = NSLineBreakMode.byTruncatingTail 
        body.height = purPro.height+purPro.y
        body.addSubview(purPro)
    }
    
    // 设置录入方式时间
    func setupAddTime(){
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: body.height, width: SCREEN_WIDTH, height: 2*PX, color: myColor().grayF0())
        body.addSubview(line)
        body.height = line.y + line.height
        
        let entryMode:QZHUIView = QZHUIView()
        self.setupListView(selfView: entryMode, y: body.height, title: "录入方式", childView: entry)
        self.entry.textColor = myColor().Gray6()
        body.addSubview(entryMode)
        body.height =  entryMode.height + entryMode.y
        
        let creatTimeView:QZHUIView = QZHUIView()
        self.setupListView(selfView: creatTimeView, y: body.height, title: "创建时间", childView: creatTime)
        self.creatTime.textColor = myColor().Gray6()
        body.addSubview(creatTimeView)
        body.height =  creatTimeView.height + creatTimeView.y
        
        let editTimeView:QZHUIView = QZHUIView()
        self.setupListView(selfView: editTimeView, y: body.height, title: "修改时间", childView: editTime)
        self.editTime.textColor = myColor().Gray6()
        body.addSubview(editTimeView)
        body.height =  editTimeView.height + editTimeView.y + 35*PX
        
    }
    
    // 设置底部操作栏
    func setupBottom(){
        let bottom:QZHUIView = QZHUIView()
        bottom.setupViews(x: 0, y: SCREEN_HEIGHT-100*PX, width: SCREEN_WIDTH, height: 100*PX, bgColor: myColor().blue007aff())
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
}

// MARK: - 绑定数据源
extension QZHMarketCollectCompanyDetailViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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

// MARK: - 设置监听方法
extension QZHMarketCollectCompanyDetailViewController{
    //返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    //打电话
    func callTel(_ sender:QZHUIButton){
        let tel:String! = self.tel.text!
        let phone:String! = self.moblie.text!
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
        let num:String! = self.moblie.text!
        PublicFunction().sendTexting(num, ownself: self)
    }
    
    //发邮件
    func sendEmail(_ sender:QZHUIButton){
        let email:String! = self.email.text!
        PublicFunction().emailSend(email, ownself: self)
    }
}
