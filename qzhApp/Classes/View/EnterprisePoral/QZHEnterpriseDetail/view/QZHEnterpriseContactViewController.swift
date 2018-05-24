//
//  QZHEnterpriseContactViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/17.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHEnterpriseContactViewController: QZHBaseViewController {
    // 企业信息视图模型
    lazy var listViewModel = QZHEnterpriseDetailViewModels()
    
    //联系人
    var contactLabel:QZHUILabelView = QZHUILabelView()
    
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
    
    override func loadData() {
        listViewModel.loadInfo { (detail, info, isSuccess) in
            if !isSuccess{}else{
                self.contactLabel.text = detail[0].status.nickName
                
                self.telLabel.text = info[0].status.tel
                if info[0].status.tel != ""{
                    
                    let parentView: UIView = self.telLabel.superview!
                    let _btn:UIButton = parentView.viewWithTag(1) as! UIButton
                    _btn.setBackgroundImage(UIImage(named:"telIcon_sel"), for: .normal)
                    _btn.restorationIdentifier = info[0].status.tel
                    _btn.addTarget(self, action: #selector(self.callTel(_:)), for: .touchUpInside)
                }
                
                self.moblieLabel.text = detail[0].status.mobile
                if detail[0].status.mobile != ""{
                    let parentView: UIView = self.moblieLabel.superview!
                    let _btn:UIButton = parentView.viewWithTag(2) as! UIButton
                    _btn.setBackgroundImage(UIImage(named:"telIcon_sel"), for: .normal)
                    _btn.restorationIdentifier = detail[0].status.mobile
                    _btn.addTarget(self, action: #selector(self.callTel(_:)), for: .touchUpInside)
                    
                    let _btn1:UIButton = parentView.viewWithTag(1) as! UIButton
                    _btn1.setBackgroundImage(UIImage(named:"SMSICon_sel"), for: .normal)
                    _btn1.restorationIdentifier = detail[0].status.mobile
                    _btn1.addTarget(self, action: #selector(self.sendSMS(_:)), for: .touchUpInside)
                }
                
                self.emmailLabel.text = info[0].status.email
                if info[0].status.email != ""{
                    let parentView: UIView = self.emmailLabel.superview!
                    let _btn:UIButton = parentView.viewWithTag(1) as! UIButton
                    _btn.setBackgroundImage(UIImage(named:"sendEmailIcon_sel"), for: .normal)
                    _btn.restorationIdentifier = info[0].status.email
                    _btn.addTarget(self, action: #selector(self.sendEmail(_:)), for: .touchUpInside)
                }
                
                self.areaLabel.text = detail[0].status.pca
                
                
                /*if detail[0].status.pca != ""{
                    self.areaLabel.text = QZHArea().getPCA(codes:detail[0].status.pca!)
                }else{
                    self.areaLabel.text = detail[0].status.pca
                }*/
                
                
                self.addressLabel.text = detail[0].status.address
                self.addressLabel.height = self.addressLabel.autoLabelHeight(detail[0].status.address!, font: 28, width: 420*PX)
                if self.addressLabel.height > 28*PX{
                    self.addressLabel.y = self.addressLabel.y-26*PX + (110*PX-self.addressLabel.height)/2
                }
                
                
                self.faxLabel.text = info[0].status.fax
                
                self.zoopCodeLabel.text = info[0].status.zipCode
                
            }
        }
    }
   
}

// MARK: - 设置界面
extension QZHEnterpriseContactViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        tabbelView?.isHidden = true
        navigationBar.isHidden = true
        let line:QZHUILabelView = QZHUILabelView()
        
        line.divider(0, y: 0, width: Int(SCREEN_WIDTH), height: 1, color: myColor().grayF0())
        view.addSubview(line)
        
        setupViewUI()
    }
    
    // 设置界面
    func setupViewUI(){
        var bodyView:QZHUIScrollView = QZHUIScrollView()
        bodyView.setupScrollerView(x: 0, y: 2, width: 750*PX, height: SCREEN_HEIGHT-210*PX-1, background: UIColor.white)
        bodyView.contentSize = CGSize(width:750*PX,height:750*PX+8)
        view.addSubview(bodyView)
        
        // 联系人
        let contactView:QZHUIView = QZHUIView()
        self.setupListView(selfView: contactView, y: 0, title: "联系人：", icon: "contactIcon", childView: contactLabel, childViewWidth: 420*PX)
        bodyView.addSubview(contactView)
        
        //公司电话
        let telView:QZHUIView = QZHUIView()
        self.setupListView(selfView: telView, y: 80*PX+1, title: "公司电话:", icon: "phoneIcon", childView: telLabel, childViewWidth:  320*PX)
        self.setupBtn(telView, 640*PX, 19*PX, 42*PX, height: 42*PX, icon: "telIcon", tags: 1)
        bodyView.addSubview(telView)
        
        //手机
        let moblieView:QZHUIView = QZHUIView()
        self.setupListView(selfView: moblieView, y: 160*PX+2, title: "手机：", icon: "mobileIcon", childView: moblieLabel, childViewWidth: 290*PX)
        self.setupBtn(moblieView, 567*PX, 19*PX, 42*PX, height: 42*PX, icon: "telIcon", tags: 2)
        self.setupBtn(moblieView, 639*PX, 19.5*PX, 43*PX, height: 41*PX, icon: "SMSICon", tags: 1)
        bodyView.addSubview(moblieView)
        
        //邮件
        let emilView:QZHUIView = QZHUIView()
        self.setupListView(selfView: emilView, y: 240*PX+3, title: "邮件" , icon: "emailIcon", childView: emmailLabel, childViewWidth:  320*PX)
        self.setupBtn(emilView, 640*PX, 24*PX, 42*PX, height: 32*PX, icon: "sendEmailIcon", tags: 1)
        bodyView.addSubview(emilView)
        
        //地区
        let areaView:QZHUIView = QZHUIView()
        self.setupListView(selfView: areaView, y: 320*PX+4, title: "地区：", icon: "regionIcon", childView: areaLabel, childViewWidth: 420*PX)
        bodyView.addSubview(areaView)
        
        //详细地址
        let addressView:QZHUIView = QZHUIView()
        self.setupListView(selfView: addressView, y: 400*PX+5, height: 110*PX+1, title: "详细地址：", icon: "addressIcon", childView: addressLabel, childViewWidth: 420*PX, childViewHeight: 28*PX)
        addressLabel.numberOfLines = 2
        addressLabel.lineBreakMode = NSLineBreakMode.byCharWrapping
        bodyView.addSubview(addressView)
        
        //传真
        let faxView:QZHUIView = QZHUIView()
        self.setupListView(selfView: faxView, y: 510*PX+6, title: "传真：", icon: "faxIcon", childView: faxLabel, childViewWidth: 420*PX)
        bodyView.addSubview(faxView)
        
        //邮件
        let zoopCodeView:QZHUIView = QZHUIView()
        self.setupListView(selfView: zoopCodeView, y: 590*PX+7, title: "邮编：", icon: "zoopCodeIcon", childView: zoopCodeLabel, childViewWidth: 420*PX)
        bodyView.addSubview(zoopCodeView)
    }
    
    // 列表项 UI 样式设置
    func setupListView(selfView:QZHUIView,y:CGFloat,height:CGFloat = 80*PX+1,title:String,icon:String,childView:QZHUILabelView,childViewWidth:CGFloat,childViewHeight:CGFloat = 28*PX){
        selfView.frame = CGRect(x:40*PX,y:y,width:670*PX,height:height)
        selfView.backgroundColor = UIColor.white
        
        let iconView:UIImageView = UIImageView()
        iconView.frame = CGRect(x:0,y:20*PX,width:40*PX,height:40*PX)
        iconView.image = UIImage(named:icon)
        selfView.addSubview(iconView)
        
        let titleLabel:QZHUILabelView = QZHUILabelView()
        titleLabel.setLabelView(60*PX, 25*PX, 180*PX, 30*PX, NSTextAlignment.left, UIColor.clear, UIColor.black, 30, title)
        selfView.addSubview(titleLabel)
        
        childView.setLabelView(250*PX, 26*PX, childViewWidth, childViewHeight, NSTextAlignment.left, UIColor.clear, UIColor.black, 28, "")
        selfView.addSubview(childView)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.divider(0, y: Int(height-1), width: Int(710*PX), height: 1, color: myColor().grayF0())
        selfView.addSubview(line)
    }
    
    //发短信 打电话 发邮件 按钮
    func setupBtn(_ parentView:QZHUIView ,_ x:CGFloat,_ y:CGFloat = 26*PX,_ width:CGFloat = 42*PX,height:CGFloat = 42*PX,icon:String,tags:Int){
        let btn:QZHUIButton = QZHUIButton()
        btn.frame = CGRect(x:x,y:y,width:width,height:height)
        btn.setBackgroundImage(UIImage(named:icon), for: .normal)
        btn.tag = tags
        parentView.addSubview(btn)
    }
    
    //打电话
    func callTel(_ sender:QZHUIButton){
        PublicFunction().telCall(sender.restorationIdentifier!, ownself: self)
        print(sender.restorationIdentifier!)
    }
    
    //发短信
    func sendSMS(_ sender:QZHUIButton){
        PublicFunction().sendTexting(sender.restorationIdentifier!, ownself: self)
    }
    
    //发邮件
    func sendEmail(_ sender:QZHUIButton){
        PublicFunction().emailSend(sender.restorationIdentifier!, ownself: self)
    }
}
