//
//  CustomerInfo.swift
//  qzh_ios
//
//  Created by sbxmac on 2017/11/10.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

class CompanyInfo:UIViewController{
    //参数Id
    var paramId:Int = -1
    var paramName:String=""
    /***********************/
    @IBOutlet weak var header: headerController!
       
    @IBOutlet weak var companyInfo: srcollView!
    @IBOutlet weak var companyInfoContact: srcollView!
    @IBOutlet weak var companyProuduct: srcollView!
    //页码
    struct Variables {
        static var pageNo:Int=0
        static var width:CGFloat=0
        static var height:CGFloat=0
    }
    
    //企业产品字典
    var companyProducts:[NSDictionary]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PublicFunction().setStatusbackgroundColor(myColor().blue4187c2())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CompanyInfo.pageNo=1
        
        //页面大小信息
        header.set_blue(PublicFunction().flattenHTML(paramName) as NSString, ownSelf: self)
        //头部选项卡
        var top=header.height+header.y
        let tab:viewControllers=viewControllers()
        self.setTab(y:Int(top),width: Int(SCREEN_WIDTH), ownSelf: tab)
        self.view.addSubview(tab)
        
        top+=tab.height
        
        
        //企业简介部分
        companyInfo.body_Size(y:Int(top), width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT-top))
        companyInfo.backgroundColor=UIColor.white
        
        //详细信息部分
        companyInfoContact.body_Size(y:Int(top), width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT-top))
        companyInfoContact.backgroundColor=UIColor.white
        
        //企业产品部分
        companyProuduct.body_Size(y:Int(top), width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT-top))
        companyProuduct.backgroundColor=UIColor.white
        
        self.view.restorationIdentifier="customerInfo"
        
        
        companyInfo.isHidden=true
        companyInfoContact.isHidden=false
        companyProuduct.isHidden=true
        
        self.getData_CompanyInfo()
        self.getData_CompanyProducts()
        self.showView(tabItemTag: 0)
    }
    //头部选项卡设置
    func setTab(y:Int,width:Int,ownSelf:viewControllers){
        ownSelf.setBgViewContent(x: 0, y: y, width: width, height: Int(PX*80)+1, bgColor:UIColor.white)
        let tabView:viewControllers=viewControllers()
        tabView.setBgViewContent(x: 0, y: 0, width: width, height: Int(PX*80)+1, bgColor: UIColor.white)
        let titleArray:[String]=["企业介绍","联系方式","企业产品"]
        for i in 0..<titleArray.count{
            let item:labelView=labelView()
            self.setTabItem(x:CGFloat((Int(SCREEN_WIDTH-2)/titleArray.count+1)*i),width: CGFloat(Int(SCREEN_WIDTH-2)/titleArray.count), title: titleArray[i], ownself: item)
            if i==0{
                self.selTabItemCss(item)
            }
            if i != titleArray.count-1{
                let lines:labelView=labelView()
                lines.divider(Int(item.width), y: Int(PX*10), width:1, height: Int(PX*60), color: myColor().grayE())
                item.addSubview(lines)
            }
            item.tag=i
            tabView.addSubview(item)
        }
        ownSelf.addSubview(tabView)
    }
    func  setTabItem(x:CGFloat,width:CGFloat,title:String,ownself:labelView){
        ownself.setLabelView(Int(x), y: 0, width: Int(width), height: Int(PX*79)+1, align: NSTextAlignment.center, bgColor: UIColor.white, txtColor: UIColor.black, text: title)
        ownself.setBigSize()
        let line:labelView=labelView()
        line.divider(0, y: Int(PX*80), width: Int(width+1), height: 1, color: myColor().grayE())
        line.restorationIdentifier="bottom"
        ownself.addSubview(line)
        ownself.restorationIdentifier="unSel"
        ownself.isUserInteractionEnabled=true
        let tabAction=UITapGestureRecognizer(target:self,action:#selector(selTabItemCss(_:)))
        ownself.addGestureRecognizer(tabAction)
    }
    func selTabItemCss(_ sender:AnyObject){
        var ownView:labelView
        if sender.superclass==UILabel.self{
            ownView = sender as! labelView
        }else{
            let this:UITapGestureRecognizer = sender as! UITapGestureRecognizer
            ownView = this.view as! labelView
        }
        if ownView.restorationIdentifier=="unSel"{
            let selViewArray:[labelView]=ownView.subviews as! [labelView]
            ownView.textColor=myColor().blue4187c2()
            for i in 0..<selViewArray.count{
                if selViewArray[i].restorationIdentifier=="bottom"{
                    selViewArray[i].backgroundColor=myColor().blue4187c2()
                }
            }
            //ownView.backgroundColor=myColor().grayFA()
            ownView.restorationIdentifier="sel"
            self.tabItemCss(ownSelf: ownView)
            self.showView(tabItemTag: ownView.tag)
        }
        
    }
    func tabItemCss(ownSelf:labelView){
        if ownSelf.superview?.superclass != nil{
            let itemArray:[labelView]=ownSelf.superview?.subviews as! [labelView]
            for i in 0..<itemArray.count{
                if itemArray[i].tag != ownSelf.tag{
                    itemArray[i].restorationIdentifier="unSel"
                    itemArray[i].backgroundColor=UIColor.white
                    itemArray[i].textColor=UIColor.black
                    let labelArray:[labelView]=itemArray[i].subviews as! [labelView]
                    for j in 0..<labelArray.count{
                        if labelArray[j].restorationIdentifier=="bottom"{
                            labelArray[j].backgroundColor=myColor().grayE()
                        }
                    }
                    
                }
            }
        }
    }
    func showView(tabItemTag:Int){
        switch tabItemTag {
        case 0:
            companyInfo.isHidden=false
            companyInfoContact.isHidden=true
            companyProuduct.isHidden=true
            break;
        case 1:
            companyInfo.isHidden=true
            companyInfoContact.isHidden=false
            companyProuduct.isHidden=true
            break;
        case 2:
            companyInfo.isHidden=true
            companyInfoContact.isHidden=true
            companyProuduct.isHidden=false
            break;
        default:
            break;
        }
    }
    
    //企业简介部分
    func setInftroduction(width:Int,ownSelf:srcollView,InfoDic:Dictionary<String,AnyObject>){
        var ownHeight:Int=Int(PX*30)
        
        ownSelf.backgroundColor=UIColor.white
        //企业图片 logo
        var logoImg:UIImage=UIImage()
        let logopath:String = InfoDic["logo"] as! String
        if logopath==""{
            logoImg=UIImage(named:"logoIcon")!
        }else{
            logoImg=UIImage(data:PublicFunction().imgFromURL(logopath))!
        }
        logoImg=logoImg.specifiesWidth(PX*300)
        let logoView:imgClass=imgClass()
        logoView.frame=CGRect(x:(width-Int(PX*300+2))/2,y:ownHeight,width:Int(logoImg.size.width+2),height:Int(logoImg.size.height+2))
        logoView.image=logoImg
        logoView.layer.borderWidth=1
        logoView.layer.borderColor=myColor().blue4187c2().cgColor
        ownSelf.addSubview(logoView)
        
         ownHeight=ownHeight+Int(logoView.height)+Int(PX*44)
        
        let title3:labelView=labelView()
        title3.setCoustomCompanyInfoTitle(ownHeight, width: width-Int(PX*60), title: "公司简介")
        ownSelf.addSubview(title3)
        
        ownHeight=ownHeight+Int(PX*30)
        var companyIntroduction:String=InfoDic["purchasing"]as! String//暂无字段
        if companyIntroduction==""{
            companyIntroduction="暂无完善资料"
        }
        let txt3:labelView = labelView()
        txt3.setCoustomCompanyInfoTxt(ownHeight, width: width-Int(PX*60), height: Int(txt3.getLabelHeight(companyIntroduction, font: UIFont.systemFont(ofSize: 12), width: CGFloat(width-Int(PX*60)))), title: companyIntroduction)
        txt3.numberOfLines=0
        txt3.sizeToFit()
        ownSelf.addSubview(txt3)
        
        ownHeight=ownHeight+Int(txt3.height)+Int(PX*60)
        
       
        let title1:labelView=labelView()
        title1.setCoustomCompanyInfoTitle(ownHeight, width: width-Int(PX*60), title: "主营产品")
        ownSelf.addSubview(title1)
        
        ownHeight=ownHeight+Int(PX*30)
        var proName:String=InfoDic["mainproduct"] as! String
        if proName==""{
            proName="暂无完善资料"
        }
        let txt1:labelView = labelView()
        txt1.setCoustomCompanyInfoTxt(ownHeight, width: width-Int(PX*60), height: Int(txt1.getLabelHeight(proName, font: UIFont.systemFont(ofSize: 12), width: CGFloat(width-Int(PX*60)))), title: proName)
        txt1.numberOfLines=0
        txt1.sizeToFit()
        ownSelf.addSubview(txt1)
        
        
        ownHeight=ownHeight+Int(txt1.height)+Int(PX*60)
        let title2:labelView=labelView()
        title2.setCoustomCompanyInfoTitle(ownHeight, width: width-Int(PX*60), title: "主购产品")
        ownSelf.addSubview(title2)
        
        ownHeight=ownHeight+Int(PX*30)
        var proNamePur:String=InfoDic["purchasing"] as! String
        if proNamePur==""{
            proNamePur="暂无完善资料"
        }
        let txt2:labelView = labelView()
        txt2.setCoustomCompanyInfoTxt(ownHeight, width: width-Int(PX*60), height: Int(txt2.getLabelHeight(proNamePur, font: UIFont.systemFont(ofSize: 12), width: CGFloat(width-Int(PX*60)))), title: proNamePur)
        txt2.numberOfLines=0
        txt2.sizeToFit()
        ownSelf.addSubview(txt2)
        
        ownHeight=ownHeight+Int(txt2.height)
        
        ownSelf.contentSize = CGSize(width:width,height:ownHeight)
    }
    
    //企业产品列表瀑布流加载
    func rollingLoad(body:srcollView){
        //customerInfo.pageNo=customerInfo.pageNo+1
        self.getData_CompanyProducts()
    }
    
    //产品详情页
    func goProDetail(_ sender:AnyObject){
        let this:UITapGestureRecognizer=sender as! UITapGestureRecognizer
        let thisView = this.view
        let _proId:Int=(thisView?.tag)!
        //functionAll().goToProDetailZPJY(proId: proId,ownSelf: self)
    }
    
    //企业详细信息部分
    func setCompanyInfo(width:Int,companyInfoDic:Dictionary<String,AnyObject>,ownSelf:srcollView){
        ownSelf.backgroundColor=UIColor.white
        var ownHeight:Int=0
        var ownleft:Int=0
        
        //联系人
        let contactView:viewControllers=viewControllers()
        ownleft=contactView.setCompanyInfoLists(width: width, y: 0, img: "contactIcon", title: "联系人:")
        let contactName:labelView=labelView()
        contactName.setLabelView(ownleft, y: Int(PX*25), width: width-ownleft, height: Int(PX*30), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: companyInfoDic["cperson"] as! String)
        contactName.setFontSize(size: 28)
        contactView.addSubview(contactName)
        ownSelf.addSubview(contactView)
        
        //电话
        let telView:viewControllers=viewControllers()
        ownleft=telView.setCompanyInfoLists(width: width, y: Int(contactView.y+contactView.height), img: "phoneIcon", title: "公司电话:")
        let telNum:labelView=labelView()
        telNum.setLabelView(ownleft, y: Int(PX*25), width: width-ownleft, height:  Int(PX*30), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: companyInfoDic["tel"] as! String)
        telNum.setFontSize(size: 28)
        telView.addSubview(telNum)
        let telImg:imgClass=imgClass()
        telImg.frame=CGRect(x:Int(telView.width-PX*40),y:Int(PX*20),width:Int(PX*40),height:Int(PX*40))
        telImg.image=UIImage(named:"telIcon")
        telImg.restorationIdentifier =  companyInfoDic["tel"] as? String
        telImg.isUserInteractionEnabled=true
        let listsAction=UITapGestureRecognizer(target:self,action:#selector(telCall(_:)))
        telImg.addGestureRecognizer(listsAction)
        telView.addSubview(telImg)
        ownSelf.addSubview(telView)
        
        //手机
        let phoneView:viewControllers=viewControllers()
        ownleft=phoneView.setCompanyInfoLists(width: width, y: Int(telView.y+telView.height), img: "mobileIcon", title: "手机:")
        let phneNum:labelView=labelView()
        phneNum.setLabelView(ownleft, y: Int(PX*25), width: width-ownleft, height:  Int(PX*30), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: companyInfoDic["mobile"] as! String)
        phneNum.setFontSize(size: 28)
        phoneView.addSubview(phneNum)
        let phoneImg:imgClass=imgClass()
        phoneImg.frame=CGRect(x:Int(phoneView.width-PX*111),y:Int(PX*20),width:Int(PX*40),height:Int(PX*40))
        phoneImg.image=UIImage(named:"telIcon")
        phoneImg.restorationIdentifier = companyInfoDic["mobile"] as! String
        phoneImg.isUserInteractionEnabled=true
        let phoneImgAction=UITapGestureRecognizer(target:self,action:#selector(telCall(_:)))
        phoneImg.addGestureRecognizer(phoneImgAction)
        phoneView.addSubview(phoneImg)
        let textingImg:imgClass=imgClass()
        textingImg.frame=CGRect(x:Int(phoneView.width-PX*41),y:Int(PX*20),width:Int(PX*41),height:Int(PX*40))
        textingImg.image=UIImage(named:"SMSICon")
        textingImg.restorationIdentifier = companyInfoDic["mobile"] as! String
        textingImg.isUserInteractionEnabled=true
        let textingImgAction=UITapGestureRecognizer(target:self,action:#selector(texting(_:)))
        textingImg.addGestureRecognizer(textingImgAction)
        phoneView.addSubview(textingImg)
        ownSelf.addSubview(phoneView)
        
        //邮件
        let emailView:viewControllers=viewControllers()
        ownleft=emailView.setCompanyInfoLists(width: width, y:Int(phoneView.y+phoneView.height), img: "emailIcon", title: "邮件:")
        let emailTxt:labelView=labelView()
        emailTxt.setLabelView(ownleft, y: Int(PX*25), width: width-ownleft, height:  Int(PX*30), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: companyInfoDic["email"] as! String)
        emailTxt.setFontSize(size: 28)
        emailView.addSubview(emailTxt)
        let emailImg:imgClass=imgClass()
        emailImg.frame=CGRect(x:Int(phoneView.width-PX*43),y:Int(PX*25),width:Int(PX*42),height:Int(PX*32))
        emailImg.image=UIImage(named:"sendEmailIcon")
        emailImg.restorationIdentifier = companyInfoDic["email"] as! String
        emailImg.isUserInteractionEnabled=true
        let emailAction=UITapGestureRecognizer(target:self,action:#selector(emailSend(_:)))
        emailImg.addGestureRecognizer(emailAction)
        emailView.addSubview(emailImg)
        ownSelf.addSubview(emailView)
        
        let regionView:viewControllers=viewControllers()
        ownleft=regionView.setCompanyInfoLists(width: width, y: Int(emailView.y+emailView.height), img: "regionIcon", title: "地区:")
        let regionTxt:labelView=labelView()
        var region:String=""
        if companyInfoDic["province"]as! String != ""{
            region="\(region as! String)\(companyInfoDic["province"]as! String)"
        }
        if companyInfoDic["province"]as! String != companyInfoDic["city"]as! String{
            region="\(region as! String)\(companyInfoDic["city"]as! String)"
        }
        region="\(region as! String)\(companyInfoDic["area"]as! String)"
        
        regionTxt.setLabelView(ownleft, y: Int(PX*25), width: width-ownleft, height:  Int(PX*30), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: region)
        regionTxt.setFontSize(size: 28)
        regionView.addSubview(regionTxt)
        ownSelf.addSubview(regionView)
        
        //详细地址
        let addressView:viewControllers=viewControllers()
        ownleft=addressView.setCompanyInfoLists(width: width, y: Int(regionView.y+regionView.height), img: "addressIcon", title: "详细地址:")
        let addressTxt:labelView=labelView()
        addressTxt.setLabelView(ownleft, y: Int(PX*25), width: width-ownleft, height:  Int(PX*30), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: companyInfoDic["address"] as! String)
        addressTxt.setFontSize(size: 28)
        addressView.addSubview(addressTxt)
        ownSelf.addSubview(addressView)
        
        //传真
        let faxView:viewControllers=viewControllers()
        ownleft=faxView.setCompanyInfoLists(width: width, y: Int(addressView.y+addressView.height), img: "faxIcon", title: "传真:")
        let faxTxt:labelView=labelView()
        faxTxt.setLabelView(ownleft, y: Int(PX*25), width: width-ownleft, height:  Int(PX*30), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: companyInfoDic["fax"] as! String)
        faxTxt.setFontSize(size: 28)
        faxView.addSubview(faxTxt)
        ownSelf.addSubview(faxView)
        
        //邮编
        let zipCodeView:viewControllers=viewControllers()
        ownleft=zipCodeView.setCompanyInfoLists(width: width, y: Int(faxView.y+faxView.height), img: "zoopCodeIcon", title: "邮编:")
        let zipCodeTxt:labelView=labelView()
        zipCodeTxt.setLabelView(ownleft, y: Int(PX*25), width: width-ownleft, height:  Int(PX*30), align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: companyInfoDic["zipcode"] as! String)
        zipCodeTxt.setFontSize(size: 28)
        zipCodeView.addSubview(zipCodeTxt)
        ownSelf.addSubview(zipCodeView)
        
        ownHeight=ownHeight+Int(zipCodeView.y+zipCodeView.height)
        
        ownSelf.contentSize = CGSize(width:width,height:ownHeight)
    }
    
    //电话拨打
    func telCall(_ sender:AnyObject){
        let this:UITapGestureRecognizer=sender as!UITapGestureRecognizer
        let thisView:UIView=this.view!
        PublicFunction().telCall(thisView.restorationIdentifier!,ownself:self)
    }
    
    //发短信
    func texting(_ sender:AnyObject){
        let this:UITapGestureRecognizer=sender as!UITapGestureRecognizer
        let thisView:UIView=this.view!
        PublicFunction().sendTexting(thisView.restorationIdentifier!,ownself:self)
    }
    //发送Email
    func emailSend(_ sender:AnyObject){
        let this:UITapGestureRecognizer=sender as!UITapGestureRecognizer
        let thisView:UIView=this.view!
        PublicFunction().emailSend(thisView.restorationIdentifier!,ownself:self)
    }
    
    
    //请求企业数据
    func getData_CompanyInfo(){
        let url="portal/myStore/productIntroduce/\(self.paramId)"
        NetworkRequest().getRequest(url, params: [:], urlType: 1,success:{
            (response)->Void in
            if response["status"] as! Int != 200{
                PublicFunction().alertPrompt("数据异常", ownSelf: self)
            }else{
                let data:Dictionary<String,AnyObject> = response["data"] as! Dictionary<String, AnyObject>
                self.setInftroduction(width: Int(SCREEN_WIDTH), ownSelf: self.companyInfo, InfoDic: PublicFunction().setNULLInDIC(data))
            }
        },failture: {
            (error)->Void in
            PublicFunction().alertPrompt("网路异常", ownSelf: self)
        })
        
        let urls="portal/myStore/productIntroduce/\(self.paramId)"
        NetworkRequest().getRequest(urls, params: [:], urlType: 1,success:{
            (response)->Void in
            if response["status"] as! Int != 200{
                PublicFunction().alertPrompt("数据异常", ownSelf: self)
            }else{
                let data:Dictionary<String,AnyObject> = response["data"] as! Dictionary<String, AnyObject>
                self.setCompanyInfo(width: Int(SCREEN_WIDTH), companyInfoDic: PublicFunction().setNULLInDIC(data), ownSelf: self.companyInfoContact )
            }
        },failture: {
            (error)->Void in
            PublicFunction().alertPrompt("网路异常", ownSelf: self)
        })
    }
    func getData_CompanyProducts(){
        let _proList=["id":111,"proName":"全开 正度 厚／硬卡纸 背景纸 模型纸 250g 400g 大张色卡纸","proSpec":"250g 浅灰 1卷","proPrice":25.20,"pic":""] as [String:AnyObject]
        for i in 0..<10{
            let listView:viewControllers=viewControllers()
            var listHeight:Int=Int(companyProuduct.contentSize.height)
            listHeight=listView.setlistOfCompanyPro(listDic: _proList, y: listHeight)
            companyProuduct.addSubview(listView)
            let listChildren:[UIView]=listView.subviews
            for child:UIView in listChildren{
                //收藏的点击事件
                if child.restorationIdentifier == "sc"{
                    child.addOnClickLister(target: self, action: #selector(collectionAdd(_:)))
                }
                if child.restorationIdentifier == "car"{
                    child.addOnClickLister(target: self, action: #selector(addToCar(_:)))
                }
            }
            companyProuduct.contentSize=CGSize(width:Int(SCREEN_WIDTH),height:listHeight)
        }
    }
    
    
    //加入收藏
    func collectionAdd(_ sender:UIGestureRecognizer){
        let thisView:UIImageView = sender.view as!UIImageView
        let proId:Int=(thisView.superview?.tag)!
        if thisView.tag == 0{
            thisView.image=UIImage(named:"collectionIconSel")
            PublicFunction().alertPrompt("加入收藏", ownSelf: self)
            thisView.tag=1
        }else{
            thisView.image=UIImage(named:"collectionIcon")
            PublicFunction().alertPrompt("取消收藏", ownSelf: self)
            thisView.tag=0
        }
    }
    
    //加入购物车
    func addToCar(_ sender:AnyObject){
        PublicFunction().alertPrompt("加入购物车", ownSelf: self)
    }
    //加入购物车
    func addToYourCar(param:Dictionary<String, AnyObject>){
        
        let userInfoDics:Dictionary<String,AnyObject>=CacheFunc().getUserInfo() as! Dictionary<String, AnyObject>
        let url="hyzx/joinShopCar.action"
        
        NetworkRequest().postRequest(url, params: ["productId":param["id"]as! Int,"detailCount":param["minorder"],"sellMemberId":param["memberId"],"pprId":param["wmid"] as Any,"specIds":param["specChildren"],"specNames":param["guige"],"meId":userInfoDics["memberId"],"apId":userInfoDics["acounId"] as Any], urlType: 1, success: {
            (response)->Void in
            print(response)
        }, failture: {
            (error)->Void in
            print(error)
            PublicFunction().alertPrompt("网络异常(加入购物车)", ownSelf: self)
        })
        
    }
}

extension CompanyInfo{
    class var pageNo:Int{
        get{
            return Variables.pageNo
        }
        set{
            Variables.pageNo=newValue
        }
    }
    class var width:CGFloat{
        get{
            return Variables.width
        }
        set{
            Variables.width=newValue
        }
    }
    class var height:CGFloat{
        get{
            return Variables.height
        }
        set{
            Variables.height=newValue
        }
    }
    
}
