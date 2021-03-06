//
//  QZHHomeViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/8.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHHomeViewController: QZHBaseViewController {

    lazy var statusList = QZHHomeViewModels()
    
    // 轮播图容器
    lazy var cycleScrollView:WRCycleScrollView = {
        let frame = CGRect(x: 0, y:0, width: SCREEN_WIDTH, height: 340*PX)
        let cycleView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: nil, descs: nil)
        return cycleView
    }()
    
    // 社区商城
    var sqscView:QZHUIView = QZHUIView()
    
    // 产业商圈
    var cysqView:QZHUIView = QZHUIView()
    
    // 企业门户
    var qymhView:QZHUIView = QZHUIView()
    
    // 积分优购
    var jfygView:QZHUIView = QZHUIView()
    
    
    // 
    var body:QZHUIView = QZHUIView()
    
    // 加载的数据
    override func loadData(){
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        // 去掉 tableview 分割线
        self.tabbelView?.separatorStyle = .none
        
        
        
        statusList.loadHomeAd { (lbt, sqsc, cysq, qymh, jfyg, isSuccess,shouldRefresh) in
            //结束刷新控件
            self.refreahController?.endRefreshing()
            
            //刷新表
            if shouldRefresh {
                
                self.tabbelView?.reloadData()
                
            }
            
            
           
            if isSuccess{
                //设置轮播图
                var imgArray:[String] = []
                if lbt.count > 0{
                    for pic in StringAndDic().getJSONFromString(str: lbt[0].status.adPic){
                        imgArray.append(pic["pic"]as!String)
                    }
                    self.cycleScrollView.serverImgArray = imgArray as? [String]
                    
                }else{
                    self.cycleScrollView.localImgArray = ["noPic"]
                }
                
                // 设置社区商城
               /* let sqscArray:[UIView] = self.sqscView.subviews
                for i in 0..<sqsc.count {
                    let sqscChild:[UIView] = (sqscArray[i].subviews)
                    var sqscCount = 0
                    for j in 0..<sqscChild.count{
                        if sqscChild[j].restorationIdentifier == "title"{
                            (sqscChild[j]as! QZHUILabelView).text = sqsc[i].status.adTitle
                        }
                        if sqscChild[j].restorationIdentifier == "text"{
                            (sqscChild[j]as! QZHUILabelView).text = sqsc[i].status.adText
                        }
                        
                        let picJson1:[Dictionary<String,AnyObject>] = StringAndDic().getJSONFromString(str: sqsc[i].status.adPic) as [Dictionary<String, AnyObject>]
                        
                        if sqscChild[j].restorationIdentifier == "img"{
                            if picJson1[sqscCount]["pic"]as!String != ""{
                                if let url = URL(string: picJson1[sqscCount]["pic"]as!String) {
                                    (sqscChild[j] as! UIImageView).downloadedFrom(url: url)
                                }else{
                                    (sqscChild[j] as! UIImageView).image = UIImage(named:"noPic")
                                }
                            }
                            sqscCount += 1
                        }
                    }
                }*/
                
                // 设置产业商圈
                let cysqArray:[UIView] = self.cysqView.subviews
                for i in 0..<cysq.count{
                    let cysqChild:[UIView] = (cysqArray[i].subviews)
                    var cysqCount = 0
                    for j in 0..<cysqChild.count{
                        if cysqChild[j].restorationIdentifier == "title"{
                            (cysqChild[j]as! QZHUILabelView).text = cysq[i].status.adTitle
                        }
                        if cysqChild[j].restorationIdentifier == "text"{
                            (cysqChild[j]as! QZHUILabelView).text = cysq[i].status.adText
                        }
                        
                        let picJson2:[Dictionary<String,AnyObject>] = StringAndDic().getJSONFromString(str: cysq[i].status.adPic) as [Dictionary<String, AnyObject>]
                        
                        if cysqChild[j].restorationIdentifier == "img"{
                            if picJson2[cysqCount].keys.contains("class_id"){
                                cysqChild[j].tag = Int.init(picJson2[cysqCount]["class_id"]as! String)!
                                cysqChild[j].addOnClickLister(target: self, action: #selector(self.goToProDetail(_:)))
                            }
                            
                            if picJson2[cysqCount]["pic"]as!String != ""{
                                if let url = URL(string: picJson2[cysqCount]["pic"]as!String) {
                                    (cysqChild[j] as! UIImageView).downloadedFrom(url: url)
                                }else{
                                    (cysqChild[j] as! UIImageView).image = UIImage(named:"noPic")
                                }
                            }
                            cysqCount += 1
                        }
                    }

                }
                
                // 设置企业门户
                let qymhArray:[UIView] = self.qymhView.subviews
                for i in 0..<qymh.count {
                    let qymhChild:[UIView] = (qymhArray[i].subviews)
                    var qymhCount = 0
                    for j in 0..<qymhChild.count{
                        if qymhChild[j].restorationIdentifier == "title"{
                            (qymhChild[j]as! QZHUILabelView).text = qymh[i].status.adTitle
                        }
                        if qymhChild[j].restorationIdentifier == "text"{
                            (qymhChild[j]as! QZHUILabelView).text = qymh[i].status.adText
                        }
                        
                        let picJson3:[Dictionary<String,AnyObject>] = StringAndDic().getJSONFromString(str: qymh[i].status.adPic) as [Dictionary<String, AnyObject>]
                        
                        if qymhChild[j].restorationIdentifier == "img"{
                            if picJson3[qymhCount].keys.contains("class_id"){
                                qymhChild[j].tag = Int.init( picJson3[qymhCount]["class_id"]as! String)!
                                qymhChild[j].addOnClickLister(target: self, action: #selector(self.goToProDetail(_:)))
                            }
                            
                            if picJson3[qymhCount]["pic"]as!String != ""{
                                if let url = URL(string: picJson3[qymhCount]["pic"]as!String) {
                                    (qymhChild[j] as! UIImageView).downloadedFrom(url: url)
                                }else{
                                    (qymhChild[j] as! UIImageView).image = UIImage(named:"noPic")
                                }
                            }
                            qymhCount += 1
                        }
                    }
                }
                
               /* // 设置积分优购
                let jfygArray:[UIView] = self.jfygView.subviews
                for i in 0..<jfyg.count {
                    let jfygChild:[UIView] = (jfygArray[i].subviews)
                    var jfygCount = 0
                    for j in 0..<jfygChild.count{
                        if jfygChild[j].restorationIdentifier == "title"{
                            (jfygChild[j]as! QZHUILabelView).text = jfyg[i].status.adTitle
                        }
                        if jfygChild[j].restorationIdentifier == "text"{
                            (jfygChild[j]as! QZHUILabelView).text = jfyg[i].status.adText
                        }
                        
                        let picJson4:[Dictionary<String,AnyObject>] = StringAndDic().getJSONFromString(str: jfyg[i].status.adPic) as [Dictionary<String, AnyObject>]
                        
                        if jfygChild[j].restorationIdentifier == "img"{
                            if picJson4[jfygCount]["pic"]as!String != ""{
                                if let url = URL(string: picJson4[jfygCount]["pic"]as!String) {
                                    (jfygChild[j] as! UIImageView).downloadedFrom(url: url)
                                }else{
                                    (jfygChild[j] as! UIImageView).image = UIImage(named:"noPic")
                                }
                            }
                            jfygCount += 1
                        }
                    }
                }*/
                
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK:-设置界面
extension QZHHomeViewController{

    // 重写父类方法
    override func setupUI() {
        super.setupUI()
        if QZHHomeModel.first{
            self.setStaticGuidePage()
            QZHHomeModel.first = false
        }
        
        
        self.isPush = true
        tabbelView?.backgroundColor = myColor().grayF0()
        setStatusBarBackgroundColor(color: .clear)
        
        // 注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        body.addSubview(cycleScrollView)
        
        // 设置导航栏按钮
        navItem.rightBarButtonItem = UIBarButtonItem(title: "消息", img: "chatIconWhite", target: self, action: #selector(showFriends),color:UIColor.white)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "扫一扫", img: "flickWhite", target: self, action: #selector(self.flickAction),color:UIColor.white)
        navigationBar.tintColor = UIColor.white
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true

        body.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 1506*PX, bgColor: myColor().grayF0())
        
        setupNavTitle()
        //setupModuleView()
        
        // 
        setPageNav(x: 18*PX, titleStr: "产业商圈", icon: "ICON_2", goStr: "CYSQ_go", action: #selector(QZH_CYSQHomePage),bgStr:"ICON2", color: myColor().purple9090C7())
        setPageNav(x: 385*PX, titleStr: "市场推广", icon: "ICON_5", goStr: "SCTG_go", action: #selector(goToSCTG),bgStr:"ICON3", color: myColor().green5b5bdb5())
        
        //setupSQSCView()
        
        setupCYSQView()
        
        setupQYMHView()
        
        //setupJFYGView()
        
        tabbelView?.tableHeaderView = body
    }
    
    // 设置导航栏标题
    func setupNavTitle(){
        let btn:SearchController = SearchController()
        //btn.backgroundColor = UIColor.white
        btn.addOnClickLister(target: self, action:#selector( goToSearch))
        navItem.titleView = btn.SeacrchBtn2()
    }
    
    // 设置导航栏标题
    func setupNavTitle1(){
        let btn:SearchController = SearchController()
        btn.addOnClickLister(target: self, action:#selector( goToSearch))
        navItem.titleView = btn.SeacrchBtn1()
    }
    
    // 设置页面导航
    func setPageNav(x:CGFloat,titleStr:String,icon:String,goStr:String,action:Selector,bgStr:String,color:UIColor){
        let parentView:QZHUIView = QZHUIView()
        body.addSubview(parentView)
        
        parentView.setupViews(x: x, y: 350*PX, width: 353*PX, height: 130*PX, bgColor: UIColor.white)
        parentView.layer.cornerRadius = 10*PX
        parentView.layer.masksToBounds = true
        
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(50*PX, 20*PX, 130*PX, 42*PX, NSTextAlignment.left, UIColor.clear, color, 30, titleStr)
        parentView.addSubview(title)
        
        let bgView:UIImageView = UIImageView(frame:CGRect(x:224*PX,y:21*PX,width:88*PX,height:88*PX))
        bgView.layer.cornerRadius = 44*PX
        bgView.image = UIImage(named:bgStr)
        bgView.clipsToBounds = true
       parentView.addSubview(bgView)
        
        
        let iconView:UIImageView = UIImageView(frame:CGRect(x:17*PX,y:17*PX,width:54*PX,height:54*PX))
        iconView.image = UIImage(named:icon)
        bgView.addSubview(iconView)
        
        let go:UIImageView = UIImageView(frame:CGRect(x:50*PX,y:78*PX,width:85*PX,height:35*PX))
        go.image = UIImage(named:goStr)
        parentView.addSubview(go)
        
        parentView.addOnClickLister(target: self, action: action)
    }
    
    // 设置进入模块窗口
    func setupModuleView(){
        let parentView:QZHUIView = QZHUIView()
        parentView.setupViews(x: 0, y:347*PX, width: SCREEN_WIDTH, height: 150*PX, bgColor: UIColor.white)
        
        let icon1:QZHUIView = QZHUIView()
        
        self.setupModule(selfView: icon1, x: 71*PX, img: "ICON_1", title: "社区商城", action: #selector(goTosqsc(_:)), colorArray: [UIColor(red:232/255,green:49/255,blue:78/255,alpha:0.92).cgColor,UIColor(red:255/255,green:113/255,blue:113/255,alpha:0.80).cgColor], loctions: [0.4,1.0], start: CGPoint(x: 0.5, y: 0), end: CGPoint(x: 0.5, y: 1.0))
        parentView.addSubview(icon1)
        
        let icon2:QZHUIView = QZHUIView()
        self.setupModule(selfView: icon2, x: 242*PX, img: "ICON_2", title: "产业商圈", action: #selector(QZH_CYSQHomePage), colorArray: [UIColor(red:175/255,green:173/255,blue:230/255,alpha:1).cgColor,UIColor(red:106/255,green:106/255,blue:158/255,alpha:1).cgColor], loctions: [0.0,1.0], start: CGPoint(x: 0.5, y: 0), end: CGPoint(x: 0.5, y: 1.0))
        parentView.addSubview(icon2)
        
        let icon3:QZHUIView = QZHUIView()
        self.setupModule(selfView: icon3, x: 419*PX, img: "ICON_3", title: "企业门户", action: #selector(EnterprisePortalPage),colorArray: [UIColor(red:118/255,green:220/255,blue:174/255,alpha:1).cgColor,UIColor(red:66/255,green:159/255,blue:188/255,alpha:1).cgColor], loctions: [0.0,1.0], start: CGPoint(x: 0.5, y: 0), end: CGPoint(x: 0.5, y: 1.0))
        parentView.addSubview(icon3)
        
        let icon4:QZHUIView = QZHUIView()//
        self.setupModule(selfView: icon4, x: 594*PX, img: "ICON_4", title: "积分优购", action: #selector(goTosqsc(_:)),colorArray: [UIColor(red:255/255,green:88/255,blue:88/255,alpha:1).cgColor,UIColor(red:240/255,green:152/255,blue:25/255,alpha:0.90).cgColor], loctions: [0.0,1.0], start: CGPoint(x: 0.5, y: 0), end: CGPoint(x: 0.5, y: 1.0))
        parentView.addSubview(icon4)
        
        body.addSubview(parentView)
    }
    // 设置模块图标
    func setupModule(selfView:QZHUIView,x:CGFloat,img:String,title:String,action:Selector,colorArray:[CGColor],loctions:[NSNumber], start: CGPoint, end:CGPoint){
        selfView.setupViews(x: x, y: 11*PX, width: 88*PX, height: 127*PX, bgColor: UIColor.clear)
        let bgView:QZHUIView = QZHUIView()
        bgView.layer.cornerRadius = 44*PX
        bgView.clipsToBounds = true
        bgView.frame = CGRect(x:0,y:0,width:88*PX,height:88*PX)
        let labelView:QZHUILabelView = QZHUILabelView()
        
        labelView.frame = CGRect(x:0,y:0,width:88*PX,height:88*PX)
        labelView.layer.cornerRadius = 44*PX
        labelView.clipsToBounds = true
        labelView.setupBgGradient(uiView: bgView, colorArray: colorArray, loctions: loctions, start: start, end:end)
        selfView.addSubview(labelView)
        
        
        let iconView:UIImageView = UIImageView(frame:CGRect(x:17*PX,y:17*PX,width:54*PX,height:54*PX))
        iconView.image = UIImage(named:img)
        bgView.addSubview(iconView)
        
        let text:QZHUILabelView = QZHUILabelView()
        text.setLabelView(0, 97*PX, 88*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 21, title)
        selfView.addSubview(text)
        
        selfView.addSubview(bgView)
        selfView.addOnClickLister(target: self, action: action)
    }
    
    // 设置社区商城界面
    func setupSQSCView(){
        self.setuptiltleLabelView(y: 509*PX, title: "社区商城产品推荐", bg: "sqscBg", colorArray: [myColor().e37e6c().cgColor,myColor().f651d7().cgColor,myColor().c24763().cgColor,myColor().e72105().cgColor], loctions: [0,0.32,0.68,1.0])
        
        sqscView.setupViews(x: 0, y: 566*PX, width: SCREEN_WIDTH, height: 441*PX, bgColor: UIColor.clear)
        sqscView.addSubview(setupListView(x: 0, y: 0, width: 374*PX, title: "", text: "", picArray: ["loadPic","loadPic"], titleColor: myColor().redD93718(), tags: 1))
        sqscView.addSubview(setupListView(x: 376*PX, y: 0, width: 374*PX, title: "", text: "", picArray: ["loadPic","loadPic"], titleColor: myColor().redD93718(), tags: 2))
        sqscView.addSubview(setupListView(x: 0, y: 221*PX, width: 374*PX, title: "", text: "", picArray: ["loadPic","loadPic"], titleColor: myColor().redD93718(), tags: 3))
        sqscView.addSubview(setupListView(x: 376*PX, y: 221*PX, width: 187*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().redD93718(), tags: 4))
        sqscView.addSubview(setupListView(x: 564*PX, y: 221*PX, width: 186*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().redD93718(), tags: 5))
        body.addSubview(sqscView)
    }
    
    // 设置产业商圈界面
    func setupCYSQView(){
        
        self.setuptiltleLabelView(y: 485*PX, title: "产业商圈产品推荐", bg: "cysqBg", colorArray: [UIColor(red:0/255,green:125/255,blue:255/255,alpha:0.5).cgColor,UIColor(red:202/255,green:66/255,blue:255/255,alpha:0.79).cgColor,UIColor(red:40/255,green:121/255,blue:255/255,alpha:0.92).cgColor,myColor().blue435e81().cgColor], loctions: [0,0.32,0.63,1.0])
        
        cysqView.setupViews(x: 0, y: 555*PX, width: SCREEN_WIDTH, height: 441*PX, bgColor: UIColor.clear)
        cysqView.addSubview(setupListView(x: 0, y: 0, width: 374*PX, title: "", text: "", picArray: ["loadPic","loadPic"], titleColor: myColor().blue4a6485(), textSize: 18, titleSize: 24, tags: 1))
        cysqView.addSubview(setupListView(x: 376*PX, y: 0, width: 374*PX, title: "", text: "", picArray: ["loadPic","loadPic"], titleColor: myColor().blue4a6485(), textSize: 18, titleSize: 24, tags: 2))
        cysqView.addSubview(setupListView(x: 0, y: 221*PX, width: 374*PX, title: "", text: "", picArray: ["loadPic","loadPic"], titleColor: myColor().blue4a6485(), textSize: 18, titleSize: 24, tags: 3))
        cysqView.addSubview(setupListView(x: 376*PX, y: 221*PX, width: 187*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().blue4a6485(), textSize: 18, titleSize: 24, tags: 4))
        cysqView.addSubview(setupListView(x: 564*PX, y: 221*PX, width: 186*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().blue4a6485(), textSize: 18, titleSize: 24, tags: 5))
        body.addSubview(cysqView)
    }
    
    // 设置企业门户界面
    func setupQYMHView(){
        self.setuptiltleLabelView(y: 996*PX, title: "企业推荐", bg: "qymhBg", colorArray: [UIColor(red:96/255,green:220/255,blue:134/255,alpha:1).cgColor,UIColor(red:72/255,green:198/255,blue:128/255,alpha:0.5).cgColor,UIColor(red:74/255,green:214/255,blue:141/255,alpha:0.9).cgColor,UIColor(red:28/255,green:236/255,blue:208/255,alpha:1).cgColor], loctions: [0,0.34,0.77,1.0])
        
        qymhView.setupViews(x: 0, y: 1068*PX, width: SCREEN_WIDTH, height: 441*PX, bgColor: UIColor.clear)
        qymhView.addSubview(setupListView(x: 0, y: 0, width: 374*PX, title: "", text: "", picArray: ["loadPic","loadPic"], titleColor: myColor().blue0eb0b1(), textSize: 18, titleSize: 24, tags: 1))
        qymhView.addSubview(setupListView(x: 376*PX, y: 0, width: 374*PX, title: "", text: "", picArray: ["loadPic","loadPic"], titleColor: myColor().blue0eb0b1(), textSize: 18, titleSize: 24, tags: 2))
        qymhView.addSubview(setupListView(x: 0, y: 221*PX, width: 374*PX, title: "", text: "", picArray: ["loadPic","loadPic"], titleColor: myColor().blue0eb0b1(), textSize: 18, titleSize: 24, tags: 3))
        qymhView.addSubview(setupListView(x: 376*PX, y: 221*PX, width: 187*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().blue0eb0b1(), textSize: 18, titleSize: 24, tags: 4))
        qymhView.addSubview(setupListView(x: 564*PX, y: 221*PX, width: 186*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().blue0eb0b1(), textSize: 18, titleSize: 24, tags: 5))
        body.addSubview(qymhView)
    }
    
    // 设置积分优购界面
    func setupJFYGView(){
        self.setuptiltleLabelView(y: 2042*PX, title: "积分优购企业推荐", bg: "jfygBg", colorArray: [UIColor(red:14/255,green:211/255,blue:176/255,alpha:1).cgColor,UIColor(red:237/255,green:219/255,blue:84/255,alpha:1).cgColor,UIColor(red:255/255,green:159/255,blue:79/255,alpha:1).cgColor,UIColor(red:255/255,green:97/255,blue:51/255,alpha:1).cgColor], loctions: [0,0.3,0.7,1.0])
        
        jfygView.setupViews(x: 0, y: 2099*PX, width: SCREEN_WIDTH, height: 441*PX, bgColor: UIColor.clear)
        jfygView.addSubview(setupListView(x: 0, y: 0, width: 187*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().redF835f(), tags: 1))
        jfygView.addSubview(setupListView(x: 188*PX, y: 0, width: 187*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().redF835f(), tags: 2))
        jfygView.addSubview(setupListView(x: 376*PX, y: 0, width: 187*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().redF835f(), tags: 3))
        jfygView.addSubview(setupListView(x: 564*PX, y: 0, width: 187*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().redF835f(), tags: 4))
        jfygView.addSubview(setupListView(x: 0, y: 221*PX, width: 187*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().redF835f(), tags: 5))
        jfygView.addSubview(setupListView(x: 188*PX, y: 221*PX, width: 187*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().redF835f(), tags: 6))
        jfygView.addSubview(setupListView(x: 376*PX, y: 221*PX, width: 187*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().redF835f(), tags: 7))
        jfygView.addSubview(setupListView(x: 564*PX, y: 221*PX, width: 187*PX, title: "", text: "", picArray: ["loadPic"], titleColor: myColor().redF835f(), tags: 8))
        body.addSubview(jfygView)
    }
    
    // 广告列表view
    func setupListView(x:CGFloat,y:CGFloat,width:CGFloat,title:String,text:String,picArray:[String],titleColor:UIColor,textSize:CGFloat = 22,titleSize:CGFloat = 30,tags:Int)->UIView{
        let pView:QZHUIView = QZHUIView()
        pView.setupViews(x: x, y: y, width: width, height: 220*PX, bgColor: UIColor.white)
        
        // 设置标题
        let titleLabel:QZHUILabelView = QZHUILabelView()
        titleLabel.setLabelView(20*PX, 12*PX, width-40*PX, 42*PX, NSTextAlignment.left, UIColor.clear,titleColor, titleSize, title)
        titleLabel.restorationIdentifier = "title"
        pView.addSubview(titleLabel)
        
        // 设置解说文字
        let textLabel:QZHUILabelView = QZHUILabelView()
        textLabel.setLabelView(20*PX, 56*PX, width-40*PX, 30*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), textSize, text)
        textLabel.restorationIdentifier = "text"
        pView.addSubview(textLabel)
        
        //图片加载
        var picX:CGFloat = 30
        for i in 0..<picArray.count{
            let imgView:UIImageView = UIImageView()
            imgView.frame = CGRect(x:picX*PX,y:86*PX,width:130*PX,height:130*PX)
            imgView.image = UIImage(named:picArray[i])
            imgView.restorationIdentifier = "img"
            picX = 218
            pView.addSubview(imgView)
        }
        
        pView.tag = tags
        return pView
    }
    
    /// 设置标题栏
    ///
    /// - Parameters:
    ///   - y: 距顶高度
    ///   - title: 标题文字
    ///   - bg: 背景图片
    func setuptiltleLabelView(y:CGFloat,title:String,bg:String,colorArray:[CGColor],loctions:[NSNumber]){
        let labelView:QZHUIView = QZHUIView()
        labelView.setupViews(x: 122.5*PX, y: y, width: 505*PX, height: 67*PX, bgColor: UIColor(patternImage: UIImage(named:bg)!))
        let titleView:QZHUILabelView = QZHUILabelView()
        titleView.frame = CGRect(x:40*PX,y:0*PX,width:345*PX,height:67*PX)
        titleView.textAlignment = .center
        
        //titleView.backgroundColor = UIColor.blue
        titleView.font = UIFont.systemFont(ofSize: 28*PX)
        titleView.text = title
        labelView.addSubview(titleView)
        
        titleView.setupGradient(uiView: labelView, colorArray: colorArray, loctions: loctions, start: CGPoint(x:0,y:1),end:CGPoint(x:1,y:1))
        
        body.addSubview(labelView)
    }
}

//MARK:- 表格数据源方法，具体的数据源方法实现，不需要 super
extension QZHHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 2540*PX+50
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
        if scrollView.contentOffset.y > 252*PX{
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            UIApplication.shared.statusBarview?.backgroundColor = UIColor.white
            navItem.rightBarButtonItem = UIBarButtonItem(title: "消息", img: "chatIcon", target: self, action: #selector(showFriends))
            navItem.leftBarButtonItem = UIBarButtonItem(title: "扫一扫", img: "flick", target: self, action: #selector(self.flickAction))
            navigationBar.tintColor = myColor().gray3()
            navigationBar.barTintColor = UIColor.white
            navigationBar.isTranslucent = false
            setupNavTitle1()
        }else{
            // 设置导航栏按钮
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
            UIApplication.shared.statusBarview?.backgroundColor = UIColor.clear
            navItem.rightBarButtonItem = UIBarButtonItem(title: "消息", img: "chatIconWhite", target: self, action: #selector(showFriends),color:UIColor.white)
            navItem.leftBarButtonItem = UIBarButtonItem(title: "扫一扫", img: "flickWhite", target: self, action: #selector(self.flickAction),color:UIColor.white)
            navigationBar.tintColor = UIColor.white
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = true
            
            setupNavTitle()
        }
    }
}

//MARK: - 监听事件
extension QZHHomeViewController{
    
    // 企业门户的跳转
    func EnterprisePortalPage(){
        let nav = QZHEnterprisePortalViewController()
        //let nav = QZHPayViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 跳转至产业商圈首页
    func QZH_CYSQHomePage(){
        let nav = QZH_CYSQMainViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 进入市场推广
    func goToSCTG(_ sender:UITapGestureRecognizer){
        let nav = QZH_CYSQMainViewController()
        nav.selectedIndex = 2
        present(nav, animated: true, completion: nil)
    }
    
    //搜索页面跳转
    func goToSearch(){
        QZHCYSQSearchProListParamModel.categoryId = ""
        QZHBrandModel.categoryId = 0
        let nav = QZHSearchViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 扫一扫
    func flickAction(){
    
    }
    
    //／显示消息 好友列表
    func showFriends(){
       let vc = QZHDemoViewController()
        
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 社区商城
    func goTosqsc(_ sender:UITapGestureRecognizer){
        
    }
    
    // 进入产品详情页
    func goToProDetail(_ sender:UITapGestureRecognizer){
        let _this = sender.view
        QZHProductDetailModel.goodsId = (_this?.tag)!
        let nav = QZHProductDetailViewController()
        present(nav, animated: true, completion: nil)
    }
}

extension QZHHomeViewController: WRCycleScrollViewDelegate
{
    /// 点击图片事件
    func cycleScrollViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView)
    {
        print("点击了第\(index+1)个图片")
    }
    /// 图片滚动事件
    func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView)
    {
        print("滚动到了第\(index+1)个图片")
    }
    
    // MARK: - 静态图片引导页
    func setStaticGuidePage() {
        let imageNameArray: [String] = ["launchimg1", "launchimg2", "launchimg3"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        //sself.view.addSubview(c)
        //UIWindow.addSubview(guideView)
       UIApplication.shared.keyWindow?.addSubview(guideView)
    }
    // MARK: - 动态图片引导页
    func setDynamicGuidePage() {
        let imageNameArray: [String] = ["guideImage6.gif", "guideImage7.gif", "guideImage8.gif"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        self.navigationController?.view.addSubview(guideView)
    }
    
    // MARK: - 视频引导页
    func setVideoGuidePage() {
        let urlStr = Bundle.main.path(forResource: "1.mp4", ofType: nil)
        let videoUrl = NSURL.fileURL(withPath: urlStr!)
        let guideView = HHGuidePageHUD.init(videoURL:videoUrl, isHiddenSkipButton: false)
        self.navigationController?.view.addSubview(guideView)
    }
}

