 //
//  viewController.swift
//  qzh_ios
//
//  Created by sbxmac on 2017/10/20.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

class viewControllers: UIView {
     //有头部有底部的view容器
    func body_Size(y:Int,width:Int,height:Int){
        self.frame=CGRect(x:0,y:y,width:width,height:height)
        self.backgroundColor=UIColor(red:238/255,green:238/255,blue:238/255,alpha:1)
        
    }
    
    //设置普通的view容器
    func setViewContent(x:Int,y:Int,width:Int,height:Int){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.backgroundColor=UIColor.white
    }
    
    //设置带背景色的view容器
    func setBgViewContent(x:Int,y:Int,width:Int,height:Int,bgColor:UIColor){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.backgroundColor=bgColor
    }
    
    //设置会员中心每个细分按钮
    func setUserList(y:Int,width:Int){
        self.frame=CGRect(x:0,y:y,width:width,height:40)
        self.backgroundColor=UIColor.white
        self.isUserInteractionEnabled=true
    }
    
    //设置边框阴影
    func setShadow(color:UIColor,opacity:CGFloat,offset:CGSize,radius:CGFloat){
        self.layer.shadowColor=color.cgColor
        self.layer.shadowOffset=offset
        self.layer.shadowOpacity=Float(opacity)
        self.layer.shadowRadius=radius
    }
    
    //设置我的收入页面列表View
    func setMySlarlyList(y:Int,width:Int,title:String,txt:String){
        self.setViewContent(x: 0, y: y, width: width, height: 26)
        let line:labelView=labelView()
        let left:labelView=labelView()
        left.setLeftLabel(title,width:width)
        self.addSubview(left)
        let right:labelView=labelView()
        right.setRightLabel(txt, width: width)
        self.addSubview(right)
        line.divider(10, y: 25, width: width-18, height: 1, color: myColor().grayE())
        self.addSubview(line)
    }
    
    //我的积分／我的代金券页面列表View设置
    func setMyIntergralLabelViewAdd(y:Int,width:Int,numStr:Int,txt:String,date:String){
        self.setViewContent(x: 0, y: y, width: width, height: 41)
        let line:labelView=labelView()
        line.divider(0, y: 40, width: width, height: 1, color: myColor().grayE())
        self.addSubview(line)
        
        let leftLabel:labelView=labelView()
        leftLabel.setLabelView(10, y: 4, width: 100, height: 32, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: myColor().blue01a5fa(), text: "+\(numStr)")
        leftLabel.setBodyTxtSize()
        self.addSubview(leftLabel)
        
        let middleLabel:labelView=labelView()
        middleLabel.setLabelView(80, y: 4, width: 110, height: 32, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text:date)
        middleLabel.setBodyTxtSize()
        self.addSubview(middleLabel)
        
        let rightLabel:labelView=labelView()
        rightLabel.setLabelView(200, y: 4, width: width-210, height: 32, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor:UIColor.black, text: txt)
        rightLabel.setBodyTxtSize()
        rightLabel.numberOfLines=2
        self.addSubview(rightLabel)
        
    }
    func setMyIntergralLabelViewSubtract(y:Int,width:Int,numStr:Int,txt:String,date:String){
            self.setViewContent(x: 0, y: y, width: width, height: 41)
            let line:labelView=labelView()
            line.divider(0, y: 40, width: width, height: 1, color: myColor().grayE())
            self.addSubview(line)
            
            let leftLabel:labelView=labelView()
            leftLabel.setLabelView(10, y: 4, width: 110, height: 32, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: myColor().redfe000(), text: "\(numStr)")
            leftLabel.setBodyTxtSize()
            self.addSubview(leftLabel)
        
            let middleLabel:labelView=labelView()
            middleLabel.setLabelView(80, y: 4, width: 110, height: 32, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text:date)
            middleLabel.setBodyTxtSize()
            self.addSubview(middleLabel)
            
            let rightLabel:labelView=labelView()
            rightLabel.setLabelView(200, y: 4, width: width-210, height: 32, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor:UIColor.black, text: txt)
            rightLabel.setBodyTxtSize()
            rightLabel.numberOfLines=2
            self.addSubview(rightLabel)
    }
    
    //添加联系人列表listView
    func setAddpersonList(x:Int,y:Int,width:Int,userPhoto:String,name:String,phoneNum:String,ownself:UIViewController,id:Int){
        self.frame=CGRect(x:x,y:y,width:width,height:41)
        let lines:labelView=labelView()
        lines.divider(0, y: 40, width: width, height: 1, color: myColor().grayE())
        lines.restorationIdentifier="lines"
        self.addSubview(lines)
        
        let radioView:imgClass=imgClass(frame:CGRect(x:0,y:15,width:10,height:10)) 
        var radioImg:UIImage=UIImage(named:"radio_0")!
        radioImg=radioImg.specifiesWidth(10)
        radioView.image=radioImg
        radioView.restorationIdentifier="radio"
        self.addSubview(radioView)
        
        let userPhotoView:imgClass=imgClass(frame:CGRect(x:25,y:5,width:30,height:30)) as! imgClass
        var userPhotoImg:UIImage=UIImage(named:userPhoto)!
        userPhotoImg=userPhotoImg.specifiesWidth(30)
        userPhotoView.image=userPhotoImg
        userPhotoView.setRoundImg(15)
        userPhotoView.setBlueBorder(1)
        self.addSubview(userPhotoView)
        
        let userNameView:labelView=labelView()
        userNameView.setLabelView(65, y: 5, width: 120, height: 30, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: name)
        userNameView.numberOfLines=2
        userNameView.setBodyTxtSize()
        userNameView.restorationIdentifier="name"
        self.addSubview(userNameView)
        
        let phoneNumView:labelView=labelView()
        phoneNumView.setLabelView(185, y: 5, width: width-195, height: 30, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: phoneNum)
        phoneNumView.numberOfLines=2
        phoneNumView.setBodyTxtSize()
        phoneNumView.restorationIdentifier="tel"
        self.addSubview(phoneNumView)
        
        self.restorationIdentifier="uncheck"
        self.tag=id
        self.isUserInteractionEnabled=true
        self.isMultipleTouchEnabled=true
        self.isExclusiveTouch=true
        let selAction=UITapGestureRecognizer(target:self,action:#selector(selAddpersonList(_ :)))
        self.addGestureRecognizer(selAction)
    }
    func selAddpersonList(_ sender:viewControllers){
        let checkFlag:String=self.restorationIdentifier!
        let childArray:[UIView]=self.subviews
        for i in 0..<childArray.count{
            if checkFlag == "uncheck"{
                self.restorationIdentifier="check"
                if childArray[i].superclass  == UIImageView.self{
                    let imageView:UIImageView=childArray[i] as! UIImageView
                    if(imageView.restorationIdentifier == "radio"){
                        imageView.image=UIImage(named:"radio_bule_sel")
                    }
                }else{
                    let labelViews:UILabel=childArray[i] as! UILabel
                    if labelViews.restorationIdentifier != "lines"{
                        labelViews.textColor=myColor().blue00a7fb()
                    }
                }
            }else{
                self.restorationIdentifier="uncheck"
                if childArray[i].superclass  == UIImageView.self{
                    let imageView:UIImageView=childArray[i] as! UIImageView
                    if(imageView.restorationIdentifier == "radio"){
                        imageView.image=UIImage(named:"radio_0")
                    }
                }else{
                    let labelViews:UILabel=childArray[i] as! UILabel
                    if labelViews.restorationIdentifier != "lines"{
                        labelViews.textColor=UIColor.black
                    }
                }
            }
            
        }
    }
    
    //我的客户页面头部选项卡
    func setTabItemCSS(ownSelf:viewControllers){
        if ownSelf.superview?.subviews != nil{
            let allViews:[viewControllers]=ownSelf.superview?.subviews as! [viewControllers]
            for index in 0..<allViews.count{
                if allViews[index].tag != ownSelf.tag{
                    if allViews[index].restorationIdentifier=="sel"{
                        let viewArray:[labelView]=allViews[index].subviews as! [labelView]
                        for i in 0..<viewArray.count{
                            if viewArray[i].restorationIdentifier=="txt"{
                                viewArray[i].textColor=UIColor.black
                            }else{
                                viewArray[i].backgroundColor=myColor().grayD9()
                            }
                        }
                        allViews[index].backgroundColor=UIColor.white
                        allViews[index].restorationIdentifier="unSel"
                    }
                }
            }
        }
    }
    
    //我的客户列表项
    func listMyCustomer(y:Int,width:Int,customerDic:NSDictionary,classId:Int)->Int{
        var ownHeight:Int=width/5
        
        let customerId:Int=customerDic.object(forKey: "id") as! Int
        let customerName:String=customerDic.object(forKey: "companyName") as! String
        var customerInfo:String=customerDic.object(forKey: "info") as! String
        var customerInfos:String=customerDic.object(forKey: "infos") as! String
        if classId==0{
            customerInfo=("主营：\(customerInfo)")
        }else{
            customerInfo=("主购：\(customerInfos)")
        }
        

        let line:labelView=labelView()
        line.divider(10, y: ownHeight+10, width: width-20, height: 1, color: myColor().grayE())
        self.addSubview(line)
        
        let imgView:imgClass=imgClass(frame:CGRect(x:10,y:5,width:width/5,height:width/5))
        
        var customerPic:String=customerDic.object(forKey: "pic") as! String
        if customerPic==""{
            imgView.image=UIImage(named:"noPic")
        }else{
            if let url = URL(string: customerPic) {
                imgView.downloadedFrom(url: url)
            }else{
                imgView.image = UIImage(named:"noPic")
            }
        }
        self.addSubview(imgView)
        
        let nameLabel:labelView=labelView()
        nameLabel.setLabelView(ownHeight+15, y: 5, width: width-ownHeight-25, height: ownHeight/4, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: customerName)
        nameLabel.setBodyTxtSize()
        self.addSubview(nameLabel)
        
        let infoLabel:labelView=labelView()
        infoLabel.setLabelView(ownHeight+15, y: 20, width: width-ownHeight-25, height: ownHeight/2, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: myColor().gray80(), text: customerInfo)
        infoLabel.setBodyTxtSize()
        self.addSubview(infoLabel)
        
        self.frame=CGRect(x:0,y:y,width:width,height:ownHeight)
        
        self.tag = customerId
        self.restorationIdentifier=customerName
        self.backgroundColor=UIColor.white
        return ownHeight+y+11
    }
    func btnIConCustomer(x:Int,width:Int,imgIcon:String,title:String,btnName:String){
        self.frame=CGRect(x:x,y:0,width:width,height:15)
        
        let imgView:imgClass=imgClass()
        imgView.frame=CGRect(x:0,y:2,width:10,height:10)
        var img=UIImage(named:imgIcon)!
        img = img.reSizeImage(CGSize(width:10,height:10))
        imgView.image=img
        self.addSubview(imgView)
        
        let titleLabel:labelView=labelView()
        titleLabel.setLabelView(Int(imgView.width)+3, y: 2, width: width-Int(imgView.width)-3, height: 11, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: title)
        titleLabel.font=UIFont.systemFont(ofSize: 8)
        self.addSubview(titleLabel)
        
        self.restorationIdentifier=btnName
    }
    
   

    //地址管理列表项
    func setAddressList(y:Int,width:Int,listDic:NSDictionary)->Int{
        self.backgroundColor=UIColor.white
        var selfHeight:Int=0
        
        let nameLabel:labelView=labelView()
        nameLabel.setLabelView(10, y: 0, width: (width-20)/2, height: 30, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: listDic.object(forKey: "name") as! String)
        nameLabel.setBodyTxtSize()
        
        let telLabel:labelView=labelView()
        telLabel.setLabelView(width/2, y: 0, width: (width-20)/2, height: 30, align: NSTextAlignment.right, bgColor: UIColor.clear, txtColor: UIColor.black, text: listDic.object(forKey: "tel") as! String)
        telLabel.setBodyTxtSize()
        selfHeight=selfHeight+30
        
        let addressLabel:labelView=labelView()
        addressLabel.setLabelView(10, y: selfHeight, width: width-20, height: 30, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: listDic.object(forKey: "address") as! String)
        addressLabel.setBodyTxtSize()
        selfHeight=selfHeight+30
        
        let line:labelView=labelView()
        line.divider(0, y: selfHeight, width: width, height: 1, color:myColor().grayD0())
        selfHeight=selfHeight+1
        
        let bottomView:viewControllers=viewControllers()
        bottomView.frame=CGRect(x:10,y:selfHeight,width:width-20,height:30)
        bottomView.restorationIdentifier="bottom"
        //默认地址
        let mrBtn:viewControllers=viewControllers()
        mrBtn.frame=CGRect(x:0,y:0,width:Int(bottomView.width/3),height:30)
        
        let mrIconView:imgClass=imgClass()
        var mrIcon:UIImage=UIImage()
        let mrLabel:labelView=labelView()
        if listDic.object(forKey: "ifDefault") as! Int==1{
            mrIconView.restorationIdentifier="sel"
            mrIcon=UIImage(named:"greenRadioSel")!
            mrIcon=mrIcon.specifiesHeight(12)
            mrLabel.setLabelView(Int(mrIcon.size.width+2), y: 5, width: Int(bottomView.width/3-mrIcon.size.width-2), height: 20, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: "默认地址")
        }else{
            mrIconView.restorationIdentifier="unSel"
            mrIcon=UIImage(named:"radioSel_0")!
            mrIcon=mrIcon.specifiesWidth(12)
            mrLabel.setLabelView(Int(mrIcon.size.width+2), y: 5, width: Int(bottomView.width/3-mrIcon.size.width-2), height: 20, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: myColor().gray80(), text: "设为默认地址")
        }
        mrLabel.setSmallTxtSize()
        mrIconView.frame=CGRect(x:0,y:9,width:Int(mrIcon.size.width),height:12)
        mrIconView.image=mrIcon
        mrBtn.addSubview(mrIconView)
        mrBtn.addSubview(mrLabel)
        mrBtn.restorationIdentifier="default"
        mrBtn.tag = listDic.object(forKey: "id") as! Int
        bottomView.addSubview(mrBtn)
        
        //编辑
        let editBtn:viewControllers=viewControllers()
        editBtn.frame=CGRect(x:Int(bottomView.width/3),y:0,width:Int(bottomView.width/3),height:30)
        let editView:imgClass=imgClass()
        var editIcon:UIImage=UIImage(named:"editIcon")!
        editIcon=editIcon.specifiesHeight(12)
        let editLabel:labelView=labelView()
        let editWidth:Int=Int(bottomView.width/3)-Int(editIcon.size.width+2+editLabel.getLabelWidth("编辑", font: UIFont.systemFont(ofSize: 12), height: 20))
        editView.frame=CGRect(x:editWidth/2,y:9,width:Int(editIcon.size.width),height:12)
        editView.image=editIcon
        editLabel.setLabelView(editWidth/2+Int(editIcon.size.width)+2, y: 5, width: Int(editLabel.getLabelWidth("编辑", font: UIFont.systemFont(ofSize: 12), height: 20)), height: 20, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: myColor().gray80(), text: "编辑")
        editLabel.setSmallTxtSize()
        editBtn.addSubview(editLabel)
        editBtn.addSubview(editView)
        editBtn.tag = listDic.object(forKey: "id") as! Int
        editBtn.restorationIdentifier="edit"
        bottomView.addSubview(editBtn)
        
        //删除
        let delBtn:viewControllers=viewControllers()
        delBtn.frame=CGRect(x:Int(bottomView.width-bottomView.width/3),y:0,width:Int(bottomView.width/3),height:30)
        let delView:imgClass=imgClass()
        var delIocn:UIImage=UIImage(named:"delAsborder")!
        delIocn=delIocn.specifiesHeight(12)
        let delLabel:labelView=labelView()
        let delWidth:Int=Int(bottomView.width/3)-Int(delIocn.size.width+2+delLabel.getLabelWidth("删除", font: UIFont.systemFont(ofSize: 12), height: 20))
        delView.frame=CGRect(x:delWidth-Int(delIocn.size.width+2),y:9,width:Int(editIcon.size.width),height:12)
        delView.image=delIocn
        delLabel.setLabelView(delWidth, y: 5, width: Int(delLabel.getLabelWidth("删除", font: UIFont.systemFont(ofSize: 12), height: 20)), height: 20, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: myColor().gray80(), text: "删除")
        delLabel.setSmallTxtSize()
        delBtn.addSubview(delLabel)
        delBtn.addSubview(delView)
        delBtn.tag = listDic.object(forKey: "id") as! Int
        delBtn.restorationIdentifier="del"
        bottomView.addSubview(delBtn)
        
        selfHeight=selfHeight+30

        
        self.frame=CGRect(x:0,y:y,width:width,height:selfHeight)
        self.addSubview(nameLabel)
        self.addSubview(telLabel)
        self.addSubview(addressLabel)
        self.addSubview(line)
        self.addSubview(bottomView)
        
        
        selfHeight=selfHeight+10+y
        
        return selfHeight
    }
    
    
    //评分图片
    func setScoreView(x:Int,y:Int,width:Int,height:Int){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.tag=0
        for i in 1...5{
            let imgView:imgClass=imgClass()
            var img=UIImage(named:"start")
            img=img?.specifiesWidth(16)
            imgView.image=img
            imgView.frame=CGRect(x:28*i,y:4,width:16,height:16)
            imgView.tag=i
            
            imgView.isUserInteractionEnabled=true
            imgView.addOnClickLister(target: self, action: #selector(scoreAction(_:)))
            self.addSubview(imgView)
        }
    }
    //评星等级
    func scoreAction(_ sender:AnyObject){
        
        let this:imgClass=(sender as! UITapGestureRecognizer).view as! imgClass
        let parentView:viewControllers=this.superview as! viewControllers
        let childrenView:[imgClass]=parentView.subviews as! [imgClass]
        for i in 0..<childrenView.count{
            if childrenView[i].tag<=this.tag{
                let img=UIImage(named:"startSel")
                childrenView[i].image=img
                //this.image=img
            }else if childrenView[i].tag>this.tag{
                let img=UIImage(named:"start")
                childrenView[i].image=img
            }
        }
        parentView.tag=this.tag
    }
    
    //下单处理列表
    func setListOfOrder(y:Int,width:Int,orderDic:Dictionary<String,AnyObject>)->Int{
        self.tag=orderDic["id"] as! Int
        
        var ownHeight:Int=0
        //卖家名称---订单状态
        let topView:viewControllers=viewControllers()
        topView.width=CGFloat(width-20)
        topView.x=10
        topView.y=0
        //订单状态
        let stateView:labelView=labelView()
        var topHeight:CGFloat=stateView.getLabelHeight(orderDic["status"] as! String, font: UIFont.systemFont(ofSize: 13), width: topView.width/3-5)
        stateView.setLabelView(Int(topView.width-topView.width/3+5), y: 5, width: Int(topView.width/3-5), height: Int(topHeight), align: NSTextAlignment.right, bgColor: UIColor.clear, txtColor: UIColor.black, text:  orderDic["status"] as! String)
        stateView.setSmallTxtSize()
        topView.addSubview(stateView)
        topHeight=topHeight+10
        //卖家公司名称
        let companyNameView:viewControllers=viewControllers()
        companyNameView.setViewContent(x: 0, y: 0, width: Int(topView.width/3*2), height: Int(topHeight))
        let companyIconView:imgClass=imgClass()
        companyIconView.frame=CGRect(x:0,y:Int(topHeight-15)/2,width:15,height:15)
        companyIconView.image=UIImage(named:"orederStoreIcon")
        companyNameView.addSubview(companyIconView)
        let companyName:labelView=labelView()
        companyName.setLabelView(Int(companyIconView.width+5), y: 0, width: Int(companyNameView.width-companyIconView.width-5), height: Int(topHeight), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: orderDic["companyName"] as! String)
        companyName.setBodyTxtSize()
        companyNameView.addSubview(companyName)
        topView.height=topHeight
        topView.addSubview(companyNameView)
        self.addSubview(topView)
        ownHeight=ownHeight+Int(topHeight)
        
        //订单中的产品列表
        let proArray:NSArray=orderDic["proList"] as! NSArray
        for i in 0..<proArray.count{
            let proListView:viewControllers=viewControllers()
            ownHeight=proListView.setListProOfOrder(y: ownHeight, width: width-20, proDic: proArray[i] as! Dictionary<String, AnyObject>)
            self.addSubview(proListView)
        }
        
        //订单中总的信息
        let orderInfoView:labelView=labelView()
        orderInfoView.setLabelView(10, y: ownHeight+2, width: width-20, height: 35, align: NSTextAlignment.right, bgColor: UIColor.clear, txtColor: myColor().gray7F(), text: "共\(orderDic["proCunt"] as! Int)件产品，实付款： ¥\(String(format:"%.2f",orderDic["proPrice"] as! CGFloat))")
        orderInfoView.setSomeTxtColor(orderInfoView.text!, textColor: myColor().gray7F(),separator: "¥", lightColor: myColor().redfe000())
        orderInfoView.setBodyTxtSize()
        self.addSubview(orderInfoView)
        ownHeight=ownHeight+Int(orderInfoView.height)+2
        
        //分割线
        let line:labelView=labelView()
        line.divider(0, y: ownHeight, width: width, height: 1, color: myColor().GrayD8())
        self.addSubview(line)
        ownHeight=ownHeight+1
        
        //根据订单状态进行操作
        let orderState:Int=orderDic["orderState"] as!Int
        let operationBtn:PublicButton=PublicButton()
        operationBtn.tag=orderDic["id"] as!Int
        operationBtn.restorationIdentifier="\(orderState)"
        operationBtn.setBtn(width/5*4-10, y: ownHeight+10, width:width/5, height: 25, bgColor: UIColor.white, title: "", txtColor:myColor().blue02a7f9(), borderColor: myColor().grayD9())
        operationBtn.setTitleSize(11)
        operationBtn.isHidden = true
        
        let delBtn:PublicButton=PublicButton()
        delBtn.tag=orderDic["id"] as!Int
        delBtn.restorationIdentifier="delete"
        delBtn.setBtn(width/5*3-20, y: ownHeight+10, width:width/5, height: 25, bgColor: UIColor.white, title: "删除订单", txtColor:myColor().blue02a7f9(), borderColor: myColor().grayD9())
        delBtn.setTitleSize(11)
        delBtn.isHidden = true
        if orderState==10{
            operationBtn.setTitle("再来一单", for: .normal)
            operationBtn.isHidden=false
            delBtn.isHidden = false
            
        }else if orderState==2{
            operationBtn.setTitle("支付订单", for: .normal)
            operationBtn.isHidden=false
        }else if orderState==3{
            operationBtn.setTitle("确认线下付款", for: .normal)
            operationBtn.isHidden=false
        }else if orderState==4{

        }else if orderState==5{
            
        }else if orderState==6{
            
        }else if orderState==7{
            operationBtn.setTitle("确认收货", for: .normal)
            operationBtn.isHidden=false
        }else if orderState==8{
            operationBtn.setTitle("确认付款", for: .normal)
            operationBtn.isHidden=false
        }else if orderState==9{
            
        }else if orderState==31{
           
        }else if orderState==23{
            
        }else if orderState==41{
            
        }else if orderState==42{
            operationBtn.setTitle("确认收货", for: .normal)
            operationBtn.isHidden=false
        }else if orderState==50{
            
        }else if orderState==51{
            
        }else if orderState==52{
            operationBtn.setTitle("支付尾款", for: .normal)
            operationBtn.isHidden=false
        }else if orderState == -1{
            delBtn.isHidden = false
            delBtn.x=CGFloat(width/5*4-10)
        }
        
        if delBtn.isHidden==false{
            self.addSubview(delBtn)
            ownHeight=ownHeight+Int(operationBtn.height)+20
        }
        if operationBtn.isHidden==false{
            self.addSubview(operationBtn)
            ownHeight=ownHeight+Int(operationBtn.height)+20
        }
        
        self.body_Size(y: y+5, width: width, height: ownHeight)
        self.backgroundColor=UIColor.white
        
        return ownHeight+y+5
    }
    func setListProOfOrder(y:Int,width:Int,proDic:Dictionary<String,AnyObject>)->Int{
        var ownHeight:Int=0
        
        //商品图片
        let imgView:imgClass=imgClass()
        imgView.frame=CGRect(x:0,y:2,width:width/4,height:width/4)
        imgView.setBorder(myColor().grayFA(), width: 0.5)
        if proDic["proPic"] as! String == ""{
            imgView.image=UIImage(named:"noPic")
        }else{
            imgView.image=UIImage(data:PublicFunction().imgFromURL(proDic["proPic"] as! String))
            if let url = URL(string: proDic["proPic"] as! String) {
                imgView.downloadedFrom(url: url)
            }else{
                imgView.image = UIImage(named:"noPic")
            }
        }
        self.addSubview(imgView)
        //名称
        let proNameView:labelView=labelView()
        proNameView.setLabelView(width/4+5, y: 2, width: width/4*3-5, height: width/8, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: proDic["proaName"] as! String)
        proNameView.numberOfLines=2
        proNameView.setBodyTxtSize()
        self.addSubview(proNameView)
        
        //数量
        let numView:labelView=labelView()
        numView.setLabelView(width/4+5, y: width/4-17, width: width/4*3-5, height: 15, align: NSTextAlignment.right, bgColor: UIColor.clear, txtColor: UIColor.black, text: "X \( proDic["proCount"] as! Int)")
        numView.setBodyTxtSize()
        self.addSubview(numView)
        self.frame=CGRect(x:10,y:y,width:width,height:ownHeight)
        
        ownHeight=width/4+4
        
        return ownHeight+Int(y)
    }
    
    
    //订单详情支付金额列表
    func setOrderDetailPrice(y:Int,width:Int,title:String,price:CGFloat){
        let titleLabel:labelView=labelView()
        titleLabel.setLabelView(10, y: y, width: Int(width-20)/4, height: 30, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: title)
        titleLabel.setBodyTxtSize()
        self.addSubview(titleLabel)
        
        let priceView:labelView=labelView()
        priceView.setLabelView(Int(width-20)/4+15, y: y, width: Int(width-20)/4*3-15, height: 30, align: NSTextAlignment.right, bgColor: UIColor.clear, txtColor: myColor().redfe000(), text: "¥\(String(format:"%.2f",price ))")
        priceView.setBodyTxtSize()
        
        self.addSubview(priceView)
    }
    
    
    /***************************************************企业门户*************************************************************/
    
    //黑色透明背景层
    func blackBackground(y:CGFloat,width:CGFloat,height:CGFloat){
        self.setBgViewContent(x:0, y: Int(y), width: Int(width), height: Int(height), bgColor: UIColor.black)
        self.backgroundColor=UIColor(red:0/255,green:0/255,blue:0/255,alpha:0.5)
        self.isHidden=true
    }
    //企业门户首页列表
    func listCompany(y:Int,customerDic:Dictionary<String,AnyObject>)->Int{
        var ownHeight:Int=Int(PX*260)
        self.frame=CGRect(x: Int(PX*30),y:y,width:Int(SCREEN_WIDTH-PX*60),height:Int(PX*260))
        let customerId:Int=customerDic[ "id"] as! Int
        let customerName:String=customerDic["company"] as! String
        var customerInfo:String=customerDic["mainproduct"] as! String
        var customerTel:String=customerDic["tel"]as! String
        var address:String=""
        if customerDic["province"] as! String == customerDic["city"] as! String{
            address="\(customerDic["city"] as! String)\(customerDic["area"] as! String)\(customerDic["address"] as! String)"
        }else{
            address="\(customerDic["province"] as! String)\(customerDic["city"] as! String)\(customerDic["area"] as! String)\(customerDic["address"] as! String)"
        }
        //var customerInfos:String=customerDic.object(forKey: "") as! String
        
        customerInfo=("主营：\(customerInfo)")
        
        let line:labelView=labelView()
        line.divider(0, y: ownHeight, width: Int(SCREEN_WIDTH-PX*60), height: 1, color: myColor().grayE())
        self.addSubview(line)
        
        let imgView:imgClass=imgClass(frame:CGRect(x:0,y:Int(PX*30),width:Int(PX*200),height:Int(PX*200)))
        
        var customerPic:String=customerDic["picurl"] as! String
        if customerPic==""{
            imgView.image=UIImage(named:"logoIcon")
        }else{
            if let url = URL(string: customerPic) {
                imgView.downloadedFrom(url: url)
            }else{
                imgView.image = UIImage(named:"noPic")
            }
        }
        self.addSubview(imgView)
        
        let labelWidth:Int=Int(self.width-imgView.width-PX*30)
        let nameLabel:labelView=labelView()
        nameLabel.setLabelView(Int(self.width)-labelWidth, y: Int(PX*30), width: labelWidth, height: Int(PX*30), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor:myColor().gray3(), text: customerName)
        nameLabel.setFontSize(size: 30)
        self.addSubview(nameLabel)
        
        let infoLabel:labelView=labelView()
        infoLabel.setLabelView(Int(self.width)-labelWidth, y: Int(PX*74), width: labelWidth, height: Int(PX*30), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: myColor().Gray8(), text: customerInfo)
        infoLabel.setFontSize(size: 26)
        self.addSubview(infoLabel)
        
        let telLabel:labelView=labelView()
        telLabel.setLabelView(Int(self.width)-labelWidth, y: Int(PX*134), width: labelWidth, height: Int(PX*30), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: myColor().gray3(), text: "联系电话：\(customerTel)")
        telLabel.setFontSize(size: 26)
        self.addSubview(telLabel)
        
        let addressImg:UIImageView=UIImageView()
        addressImg.frame=CGRect(x:Int(self.width)-labelWidth,y:Int(PX*195),width:Int(PX*20),height:Int(PX*26))
        addressImg.image=UIImage(named:"locationIcon")
        self.addSubview(addressImg)
        let addressLabel:labelView=labelView()
        addressLabel.setLabelView(Int(self.width)-labelWidth+Int(PX*30), y: Int(PX*197), width: labelWidth-Int(PX*30), height: Int(PX*26), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: myColor().gray3(), text:address)
        addressLabel.setFontSize(size: 26)
        self.addSubview(addressLabel)
        
        self.tag = customerId
        self.restorationIdentifier=customerName
        self.backgroundColor=UIColor.white
        return ownHeight+y+11
    }
    //企业门户联系我们列表
    func setCompanyInfoLists(width:Int,y:Int,img:String,title:String)->Int{
        self.setBgViewContent(x: Int(PX*40), y: y, width: width-Int(PX*80), height: Int(PX*80)+1, bgColor: UIColor.clear)
        
        let line:labelView=labelView()
        line.divider(0, y: Int(PX*80), width: width-Int(PX*40), height: 1, color: myColor().grayE())
        self.addSubview(line)
        
        let imgView:imgClass=imgClass()
        imgView.frame=CGRect(x:0,y:Int(PX*20),width:Int(PX*40),height:Int(PX*40))
        imgView.image=UIImage(named:img)
        self.addSubview(imgView)
        
        let titleLabel:labelView=labelView()
        titleLabel.setLabelView(Int(imgView.width+PX*20), y:Int(PX*25), width: Int(PX*140), height: Int(PX*30), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: title)
        titleLabel.setFontSize(size: 30)
        self.addSubview(titleLabel)
        return Int(titleLabel.width+titleLabel.x+PX*50)
    }
    //企业门户产品列表
    func setlistOfCompanyPro(listDic:Dictionary<String,AnyObject>,y:Int) ->Int{
        let ownHeight:Int=Int(PX*240)+1
        self.setBgViewContent(x: 0, y: y, width: Int(SCREEN_WIDTH), height: ownHeight, bgColor: UIColor.white)
        
        let _imgView:UIImageView=UIImageView()
        _imgView.frame=CGRect(x:Int(PX*30),y:Int(PX*20),width:Int(PX*200),height:Int(PX*200))
        if listDic["pic"] as! String == "" {
            _imgView.image=UIImage(named:"logoIcon")
        }else{            
            if let url = URL(string: listDic["pic"] as! String) {
                _imgView.downloadedFrom(url: url)
            }else{
                _imgView.image = UIImage(named:"noPic")
            }
        }
        self.addSubview(_imgView)
        
        let _line:labelView=labelView()
        _line.divider(Int(PX*260), y: ownHeight-1, width: Int(SCREEN_WIDTH-PX*260), height: 1, color: myColor().grayE())
        self.addSubview(_line)
        
        let nameLabel:labelView=labelView()
        nameLabel.setLabelView(Int(PX*260), y: Int(PX*20), width: Int(SCREEN_WIDTH-PX*290), height:Int(PX*80), align: .left, bgColor:UIColor.white, txtColor: myColor().gray3(), text: listDic["proName"] as! String)
        nameLabel.setFontSize(size: 28)
        nameLabel.lineBreakMode=NSLineBreakMode.byCharWrapping//设置文本多行显示
        nameLabel.numberOfLines=3
        self.addSubview(nameLabel)
        
        let specLabel:labelView=labelView()
        specLabel.setLabelView(Int(PX*260), y: Int(nameLabel.y+nameLabel.height+20*PX), width: Int(SCREEN_WIDTH-PX*290), height: Int(PX*30), align: .left, bgColor: UIColor.white, txtColor: myColor().Gray8(), text: listDic["proSpec"] as! String)
        specLabel.setFontSize(size: 26)
        self.addSubview(specLabel)
        
        let _priceLabel:labelView=labelView()
        _priceLabel.setLabelView(Int(PX*260), y: ownHeight-Int(PX*45)-1, width: Int(PX*200), height:Int(PX*30), align: .left,bgColor: UIColor.white, txtColor: myColor().redFf4300(), text: "¥\(String(describing: listDic["proPrice"] as! NSNumber))")
        _priceLabel.setFontSize(size: 36)
        self.addSubview(_priceLabel)
        
        let scIcon:UIImageView=UIImageView()
        scIcon.frame=CGRect(x:Int(SCREEN_WIDTH-172*PX),y:Int(_priceLabel.y),width:Int(PX*36),height:Int(30*PX))
        scIcon.image=UIImage(named:"collectionIcon")
        scIcon.restorationIdentifier="sc"
        scIcon.tag=0
        self.addSubview(scIcon)
        
        let carIcon:UIImageView=UIImageView()
        carIcon.frame=CGRect(x:Int(SCREEN_WIDTH-86*PX),y:Int(_priceLabel.y-4*PX),width:Int(PX*36),height:Int(34*PX))
        carIcon.image=UIImage(named:"carIcon")
        carIcon.restorationIdentifier="car"
        carIcon.tag=listDic["id"] as! Int
        self.addSubview(carIcon)
        
        self.tag=listDic["id"] as! Int
        return ownHeight+y
    }
}

extension UIView{
    var x:CGFloat{
        get{
            return frame.origin.x
        }
        set(newVal){
            var tmpFrame:CGRect=frame
            tmpFrame.origin.x=newVal
            frame=tmpFrame
        }
    }
    
    var y:CGFloat{
        get{
            return frame.origin.y
        }
        set(newVal){
            var tmpFrame:CGRect=frame
            tmpFrame.origin.y=newVal
            frame=tmpFrame
        }
    }
    
    var width:CGFloat{
        get{
            return frame.size.width
        }
        set(newVal){
            var tmpFrame:CGRect=frame
            tmpFrame.size.width=newVal
            frame=tmpFrame
        }
    }
    
    var height:CGFloat{
        get{
            return frame.size.height
        }
        set(newVal){
            var tmpFrame:CGRect=frame
            tmpFrame.size.height=newVal
            frame=tmpFrame
        }
    }
    
    var centerX: CGFloat{
        get{
            return center.x
        }
        set(newCenterX){
            center = CGPoint(x: newCenterX, y: center.y)
        }
    }

    var centerY: CGFloat{
        get{
            return center.y
        }
        set(newCenterY){
            center = CGPoint(x: center.x, y: newCenterY)
        }
    }

    var origin: CGPoint{
        get{
            return CGPoint(x: x, y: y)
        }
        set(newOrigin){
            x = newOrigin.x
            y = newOrigin.y
        }
    }

    var size: CGSize{
        get{
            return CGSize(width: width, height: height)
        }
        set(newSize){
            width = newSize.width
            height = newSize.height
        }
    }

    var left: CGFloat{
        get{
            return x
        }
        set(newLeft){
            x = newLeft
        }
    }

    var right: CGFloat{
        get{
            return x + width
        }
        set(newNight){
            x = newNight - width
        }
    }

    var top: CGFloat{
        get{
            return y
        }
        set(newTop){
            y = newTop
        }
    }

    var bottom: CGFloat{
        get{
            return  y + height
        }
        set(newBottom){
            y = newBottom - height
        }
    }
    
    func addOnClickLister(target:AnyObject,action:Selector){
        let gr=UITapGestureRecognizer(target:target,action:action)
        gr.numberOfTapsRequired=1
        isUserInteractionEnabled=true
        addGestureRecognizer(gr)
    }
}

