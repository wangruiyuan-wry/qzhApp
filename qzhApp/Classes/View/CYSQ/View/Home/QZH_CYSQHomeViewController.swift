//
//  QZH_CYSQHomeViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/24.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZH_CYSQHomeViewController: QZHBaseViewController {
    
    // 产业商圈首页数据列表视图模型
    lazy var HomeList = QZGH_CYSQHomeListViewModel()
    
    // 分类图片
    var MarketClassView:QZHUIView = QZHUIView()
    var MarketClassView1:QZHUIScrollView = QZHUIScrollView()
    var MarketClassView1line:QZHUILabelView = QZHUILabelView()
    
    // 促销专区
    var prmotionView:QZHUIScrollView = QZHUIScrollView()
    
    // 今日推荐
    var recommendView:QZHUIView = QZHUIView()
    
    // 头部轮播图容器
    lazy var cycleScrollView:WRCycleScrollView = {
        let frame = CGRect(x: 0, y:0, width: SCREEN_WIDTH, height: 340*PX)
        let cycleView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: nil, descs: nil)
        return cycleView
    }()
    
    // 今日推荐轮播图容器
    lazy var cycleScrollView1:WRCycleScrollView = {
        let frame = CGRect(x: 2*PX, y:0, width: 248*PX, height: 420*PX)
        let cycleView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: nil, descs: nil)
        return cycleView
    }()
    
    override func loadData() {
        HomeList.loadHomeData { (isSuccess,shouldRefresh) in

            //结束刷新控件
            //self.refreahController?.endRefreshing()
            
            //刷新表
            if shouldRefresh {
                
                self.tabbelView?.reloadData()
                
            }

            if isSuccess{
                //设置轮播图
                var imgArray:[String] = []
                for pic in self.HomeList.sildeHeadList{
                    imgArray.append(pic.status.slidePictureUrl)
                }
                self.cycleScrollView.serverImgArray = imgArray as? [String]
                self.tabbelView?.addSubview(self.cycleScrollView)
                // 设置分类模块
                var classCount:Int = 0
                if self.HomeList.getMarketClassList.count > 8{
                    classCount = 8
                }else{
                    classCount = self.HomeList.getMarketClassList.count
                }
                for i in 0..<classCount{
                    let classArray:[UIView] = self.MarketClassView.subviews
                    (classArray[2*i] as! UIImageView).image = UIImage(data:PublicFunction().imgFromURL(self.HomeList.getMarketClassList[i].status.pictureUrl as! String))
                    (classArray[2*i] as! UIImageView).tag = self.HomeList.getMarketClassList[i].status.labelId
                    (classArray[2*i] as! UIImageView).addOnClickLister(target: self, action: #selector(self.goToMarketClass(_:)))
                    (classArray[2*i+1] as! UILabel).text = self.HomeList.getMarketClassList[i].status.name
                    (classArray[2*i+1] as! UILabel).tag = self.HomeList.getMarketClassList[i].status.labelId
                    (classArray[2*i+1] as! UILabel).addOnClickLister(target: self, action: #selector(self.goToMarketClass(_:)))
                    
                    let classArray1:[UIView] = self.MarketClassView1.subviews
                    (classArray1[2*i] as! UIImageView).image = UIImage(data:PublicFunction().imgFromURL(self.HomeList.getMarketClassList[i].status.pictureUrl as! String))
                    (classArray1[2*i] as! UIImageView).tag = self.HomeList.getMarketClassList[i].status.labelId
                    (classArray1[2*i] as! UIImageView).addOnClickLister(target: self, action: #selector(self.goToMarketClass(_:)))
                    (classArray1[2*i+1] as! UILabel).text = self.HomeList.getMarketClassList[i].status.name
                    (classArray1[2*i+1] as! UILabel).tag = self.HomeList.getMarketClassList[i].status.labelId
                    (classArray1[2*i+1] as! UILabel).addOnClickLister(target: self, action: #selector(self.goToMarketClass(_:)))
                    
                }
                
                // 促销专区
                var PromotionX = 20*PX
                //self.prmotionView.subviews[0].removeFromSuperview()
                for i in 0..<self.HomeList.getPromotionMarketAdList.count{
                    var imgstr = "noPic"
                    if self.HomeList.getPromotionMarketAdList[i].status.productPictureUrl != ""{
                        imgstr = self.HomeList.getPromotionMarketAdList[i].status.productPictureUrl
                    }
                    PromotionX =  self.setupProPromotion(x: PromotionX, img: imgstr, name: self.HomeList.getPromotionMarketAdList[i].status.productName, newprice: self.HomeList.getPromotionMarketAdList[i].status.productPrice, old: self.HomeList.getPromotionMarketAdList[i].status.originalPrice, id: Int64(self.HomeList.getPromotionMarketAdList[i].status.goodsId), sellTypes: self.HomeList.getPromotionMarketAdList[i].status.productSellActivity, unit: self.HomeList.getPromotionMarketAdList[i].status.productUnit)
                }
                
                // 今日推荐轮播
                var imgArray1:[String] = []
                for pic in self.HomeList.sildeTodayRecommendList{
                    imgArray1.append(pic.status.slidePictureUrl)
                }
                self.cycleScrollView1.serverImgArray = imgArray1 as? [String]
                self.recommendView.addSubview(self.cycleScrollView1)
                
                // 今日推荐
                var longth = 5
                if self.HomeList.getRecommendMarketAdList.count < 5{
                    longth = self.HomeList.getRecommendMarketAdList.count
                }
                for i in 0..<longth{
                    var img1 = "noPic"
                    if self.HomeList.getRecommendMarketAdList[i].status.productPictureUrl != ""{
                        img1 = self.HomeList.getRecommendMarketAdList[i].status.productPictureUrl
                    }
                    if i == 0{
                        self.setupRecommendProView(x: 251*PX, y: 0, img: img1, name: self.HomeList.getRecommendMarketAdList[i].status.productName, price: self.HomeList.getRecommendMarketAdList[i].status.productPrice, unit: self.HomeList.getRecommendMarketAdList[i].status.productUnit, id: Int64(self.HomeList.getRecommendMarketAdList[i].status.goodsId))
                    }
                    if i == 1{
                        self.setupRecommendProView(x: 500*PX, y: 0, img: img1, name: self.HomeList.getRecommendMarketAdList[i].status.productName, price: self.HomeList.getRecommendMarketAdList[i].status.productPrice, unit: self.HomeList.getRecommendMarketAdList[i].status.productUnit, id: Int64(self.HomeList.getRecommendMarketAdList[i].status.goodsId))
                    }
                    if i == 2{
                        self.setupRecommendProView(x: 2*PX, y: 421*PX, img: img1, name: self.HomeList.getRecommendMarketAdList[i].status.productName, price: self.HomeList.getRecommendMarketAdList[i].status.productPrice, unit: self.HomeList.getRecommendMarketAdList[i].status.productUnit, id: Int64(self.HomeList.getRecommendMarketAdList[i].status.goodsId))
                    }
                    if i==3{
                     self.setupRecommendProView(x: 251*PX, y: 421*PX, img: img1, name: self.HomeList.getRecommendMarketAdList[i].status.productName, price: self.HomeList.getRecommendMarketAdList[i].status.productPrice, unit: self.HomeList.getRecommendMarketAdList[i].status.productUnit, id: Int64(self.HomeList.getRecommendMarketAdList[i].status.goodsId))
                    }
                    if i==3{
                        self.setupRecommendProView(x: 500*PX, y: 421*PX, img: img1, name: self.HomeList.getRecommendMarketAdList[i].status.productName, price: self.HomeList.getRecommendMarketAdList[i].status.productPrice, unit: self.HomeList.getRecommendMarketAdList[i].status.productUnit, id: Int64(self.HomeList.getRecommendMarketAdList[i].status.goodsId))
                    }
                }
            }
        }
       getHotSell()
    }
    
    // 加载热销产品
    func getHotSell(){
        HomeList.loadHotSell(pullup: self.isPulup) { (isSuccess,shouldRefresh) in

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


// MARK: - 设置界面
extension QZH_CYSQHomeViewController{
    override func setupUI() {
        super.setupUI()
        setupvarMarketClassView1()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        // 去掉 tableview 分割线
        self.tabbelView?.separatorStyle = .none
        
        tabbelView?.backgroundColor = myColor().grayF0()
        tabbelView?.height = SCREEN_HEIGHT - 98*PX
        
        // 注册原型 cell
        tabbelView?.register(UINib(nibName:"QZH_CYSQHomeHotSell",bundle:nil), forCellReuseIdentifier: cellId)
        let top:UIImageView = UIImageView(frame:CGRect(x: 0, y:0, width: SCREEN_WIDTH, height: 340*PX))
        top.image = UIImage(named:"loadPic")
        tabbelView?.addSubview(top)
        
        // 设置导航栏按钮
        navItem.rightBarButtonItem = UIBarButtonItem(title: "消息", img: "chatIconWhite", target: self, action: #selector(showFriends),color:UIColor.white)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon1", target: self, action: #selector(self.close),color:UIColor.white)
        navigationBar.tintColor = UIColor.white
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        setupNav()
        
        setupvarMarketClassView()
        
        
        tabbelView?.addSubview(self.setupTitles(y: 649*PX, text: "促销专区", icons: "CYSQ_promotion"))
        setupPromotionView()
        tabbelView?.addSubview(self.setupTitles(y: 1059*PX, text: "今日推荐", icons: "CYSQ_recommend"))
        setupRecommendView()
        tabbelView?.addSubview(self.setupTitles(y: 1980*PX, text: "热销产品", icons: "CYSQ_hot"))
        
    }
    
    // 设置导航条
    func setupNav(){
        let btn:SearchController = SearchController()
        btn.isUserInteractionEnabled = true
        btn.addOnClickLister(target: self, action: #selector(self.goToSearch))
        navItem.titleView = btn.SeacrchTitleBtn1(title: "产业商圈", titleColor: UIColor.white)
    }
    func setupNav1(){
        let btn:SearchController = SearchController()
        btn.isUserInteractionEnabled = true
        btn.addOnClickLister(target: self, action: #selector(goToSearch))
        navItem.titleView = btn.SeacrchTitleBtn2(title: "产业商圈", titleColor: myColor().Gray6c6ca1())
    }
    
    // 设置分类图片列表
    func setupvarMarketClassView(){
        MarketClassView.setupViews(x: 0, y: 350*PX, width: SCREEN_WIDTH, height: 299*PX, bgColor: UIColor.white)
        
        let icon1:UIImageView = UIImageView(frame:CGRect(x:49*PX,y:10*PX,width:88*PX,height:88*PX))
        icon1.backgroundColor = UIColor(patternImage:  setupImgBg(colors:[UIColor(red:232/255,green:49/255,blue:78/255,alpha:0.92),UIColor(red:255/255,green:113/255,blue:113/255,alpha:0.80)], size: CGSize(width:66*PX,height:66*PX)))
        icon1.tag = 1
        icon1.layer.cornerRadius = 44*PX
        icon1.clipsToBounds = true
        MarketClassView.addSubview(icon1)
        let title1:QZHUILabelView = QZHUILabelView()
        title1.setLabelView(43*PX, 108*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title1)
        
        let icon2:UIImageView = UIImageView(frame:CGRect(x:237*PX,y:10*PX,width:88*PX,height:88*PX))
        icon2.backgroundColor = UIColor(patternImage:setupImgBg(colors:[UIColor(red:175/255,green:173/255,blue:230/255,alpha:1),UIColor(red:106/255,green:106/255,blue:158/255,alpha:1)], size: CGSize(width:66*PX,height:66*PX)))
        icon2.tag = 1
        icon2.layer.cornerRadius = 44*PX
        icon2.clipsToBounds = true
        MarketClassView.addSubview(icon2)
        let title2:QZHUILabelView = QZHUILabelView()
        title2.setLabelView(231*PX, 108*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title2)

        let icon3:UIImageView = UIImageView(frame:CGRect(x:425*PX,y:10*PX,width:88*PX,height:88*PX))
        icon3.backgroundColor = UIColor(patternImage: setupImgBg(colors:[UIColor(red:119/255,green:220/255,blue:174/255,alpha:1),UIColor(red:66/255,green:159/255,blue:188/255,alpha:1)], size: CGSize(width:66*PX,height:66*PX)))
        icon3.tag = 1
        icon3.layer.cornerRadius = 44*PX
        icon3.clipsToBounds = true
        MarketClassView.addSubview(icon3)
        let title3:QZHUILabelView = QZHUILabelView()
        title3.setLabelView(419*PX, 108*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title3)

        let icon4:UIImageView = UIImageView(frame:CGRect(x:613*PX,y:10*PX,width:88*PX,height:88*PX))
        icon4.backgroundColor = UIColor(patternImage: setupImgBg(colors:[UIColor(red:255/255,green:88/255,blue:88/255,alpha:1),UIColor(red:240/255,green:152/255,blue:25/255,alpha:0.90)], size: CGSize(width:66*PX,height:66*PX)))
        icon4.tag = 1
        icon4.layer.cornerRadius = 44*PX
        icon4.clipsToBounds = true
        MarketClassView.addSubview(icon4)
        let title4:QZHUILabelView = QZHUILabelView()
        title4.setLabelView(607*PX, 108*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title4)

        let icon5:UIImageView = UIImageView(frame:CGRect(x:49*PX,y:161*PX,width:88*PX,height:88*PX))
        icon5.backgroundColor = UIColor(patternImage: setupImgBg(colors:[UIColor(red:232/255,green:49/255,blue:78/255,alpha:0.92),UIColor(red:255/255,green:113/255,blue:113/255,alpha:0.80)], size: CGSize(width:66*PX,height:66*PX)))
        icon5.tag = 1
        icon5.layer.cornerRadius = 44*PX
        icon5.clipsToBounds = true
        MarketClassView.addSubview(icon5)
        let title5:QZHUILabelView = QZHUILabelView()
        title5.setLabelView(43*PX, 259*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title5)

        let icon6:UIImageView = UIImageView(frame:CGRect(x:237*PX,y:161*PX,width:88*PX,height:88*PX))
        icon6.backgroundColor = UIColor(patternImage:setupImgBg(colors:[UIColor(red:175/255,green:173/255,blue:230/255,alpha:1),UIColor(red:106/255,green:106/255,blue:158/255,alpha:1)], size: CGSize(width:66*PX,height:66*PX)))
        icon6.tag = 1
        icon6.layer.cornerRadius = 44*PX
        icon6.clipsToBounds = true
        MarketClassView.addSubview(icon6)
        let title6:QZHUILabelView = QZHUILabelView()
        title6.setLabelView(231*PX, 259*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title6)

        let icon7:UIImageView = UIImageView(frame:CGRect(x:425*PX,y:161*PX,width:88*PX,height:88*PX))
        icon7.backgroundColor = UIColor(patternImage: setupImgBg(colors:[UIColor(red:118/255,green:220/255,blue:174/255,alpha:1),UIColor(red:66/255,green:159/255,blue:188/255,alpha:1)], size: CGSize(width:66*PX,height:66*PX)))
        icon7.tag = 1
        icon7.layer.cornerRadius = 44*PX
        icon7.clipsToBounds = true
        MarketClassView.addSubview(icon7)
        let title7:QZHUILabelView = QZHUILabelView()
        title7.setLabelView(419*PX, 259*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title7)

        let icon8:UIImageView = UIImageView(frame:CGRect(x:613*PX,y:161*PX,width:88*PX,height:88*PX))
        icon8.backgroundColor = UIColor(patternImage:  setupImgBg(colors: [UIColor(red:255/255,green:88/255,blue:88/255,alpha:1),UIColor(red:240/255,green:152/255,blue:25/255,alpha:0.90)], size: CGSize(width:66*PX,height:66*PX)))
        icon8.tag = 1
        icon8.layer.cornerRadius = 44*PX
        icon8.clipsToBounds = true
        MarketClassView.addSubview(icon8)
        let title8:QZHUILabelView = QZHUILabelView()
        title8.setLabelView(607*PX, 259*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title8)

        
        tabbelView?.addSubview(MarketClassView)
    }
    func setupvarMarketClassView1(){
        
        MarketClassView1line.dividers(0, y: 128*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        MarketClassView1line.backgroundColor =  myColor().grayF0()
        MarketClassView1line.isHidden = true
        view.addSubview(MarketClassView1line)
        
        MarketClassView1.setupScrollerView(x: 0, y: 129*PX, width: SCREEN_WIDTH, height: 106*PX, background: UIColor.white)
        MarketClassView1.isHidden = true
        MarketClassView1.backgroundColor = UIColor.white
        view.addSubview(MarketClassView1)
        
        let icon1:UIImageView = UIImageView(frame:CGRect(x:34*PX,y:5*PX,width:66*PX,height:66*PX))
        icon1.layer.cornerRadius = 33*PX
        icon1.clipsToBounds = true
        icon1.backgroundColor = UIColor(patternImage: setupImgBg(colors:[UIColor(red:232/255,green:49/255,blue:78/255,alpha:0.92),UIColor(red:255/255,green:113/255,blue:113/255,alpha:0.80)], size: CGSize(width:66*PX,height:66*PX)))
        icon1.tag = 1
        MarketClassView1.addSubview(icon1)
        let title1:QZHUILabelView = QZHUILabelView()
        title1.setLabelView(25*PX, 76*PX, 83*PX, 25*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 18, "未知分类")
        MarketClassView1.addSubview(title1)
        
        let icon2:UIImageView = UIImageView(frame:CGRect(x:132*PX,y:5*PX,width:66*PX,height:66*PX))
        icon2.backgroundColor = UIColor(patternImage: setupImgBg(colors:[UIColor(red:175/255,green:173/255,blue:230/255,alpha:1),UIColor(red:106/255,green:106/255,blue:158/255,alpha:1)], size: CGSize(width:66*PX,height:66*PX)))
        icon2.tag = 1
        icon2.layer.cornerRadius = 33*PX
        icon2.clipsToBounds = true
        MarketClassView1.addSubview(icon2)
        let title2:QZHUILabelView = QZHUILabelView()
        title2.setLabelView(123*PX, 76*PX, 83*PX, 25*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 18, "未知分类")
        MarketClassView1.addSubview(title2)
        
        let icon3:UIImageView = UIImageView(frame:CGRect(x:230*PX,y:5*PX,width:66*PX,height:66*PX))
        icon3.backgroundColor = UIColor(patternImage: setupImgBg(colors:[UIColor(red:119/255,green:220/255,blue:174/255,alpha:1),UIColor(red:66/255,green:159/255,blue:188/255,alpha:1)], size: CGSize(width:66*PX,height:66*PX)))
        icon3.tag = 1
        icon3.layer.cornerRadius = 33*PX
        icon3.clipsToBounds = true
        MarketClassView1.addSubview(icon3)
        let title3:QZHUILabelView = QZHUILabelView()
        title3.setLabelView(221*PX, 76*PX, 83*PX, 25*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 18, "未知分类")
        MarketClassView1.addSubview(title3)
        
        let icon4:UIImageView = UIImageView(frame:CGRect(x:328*PX,y:5*PX,width:66*PX,height:66*PX))
        icon4.backgroundColor = UIColor(patternImage: setupImgBg(colors:[UIColor(red:255/255,green:88/255,blue:88/255,alpha:1),UIColor(red:240/255,green:152/255,blue:25/255,alpha:0.90)], size: CGSize(width:66*PX,height:66*PX)))
        icon4.tag = 1
        icon4.layer.cornerRadius = 33*PX
        icon4.clipsToBounds = true
        MarketClassView1.addSubview(icon4)
        let title4:QZHUILabelView = QZHUILabelView()
        title4.setLabelView(319*PX,76*PX, 83*PX, 25*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 18, "未知分类")
        MarketClassView1.addSubview(title4)
        
        let icon5:UIImageView = UIImageView(frame:CGRect(x:426*PX,y:5*PX,width:66*PX,height:66*PX))
        icon5.backgroundColor = UIColor(patternImage:setupImgBg(colors:[UIColor(red:232/255,green:49/255,blue:78/255,alpha:0.92),UIColor(red:255/255,green:113/255,blue:113/255,alpha:0.80)], size: CGSize(width:66*PX,height:66*PX)))
        icon5.tag = 1
        icon5.layer.cornerRadius = 33*PX
        icon5.clipsToBounds = true
        MarketClassView1.addSubview(icon5)
        let title5:QZHUILabelView = QZHUILabelView()
        title5.setLabelView(417*PX, 76*PX, 83*PX, 25*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 18, "未知分类")
        MarketClassView1.addSubview(title5)
        
        let icon6:UIImageView = UIImageView(frame:CGRect(x:524*PX,y:5*PX,width:66*PX,height:66*PX))
        icon6.backgroundColor = UIColor(patternImage: setupImgBg(colors:[UIColor(red:175/255,green:173/255,blue:230/255,alpha:1),UIColor(red:106/255,green:106/255,blue:158/255,alpha:1)], size: CGSize(width:66*PX,height:66*PX)))
        icon6.tag = 1
        icon6.layer.cornerRadius = 33*PX
        icon6.clipsToBounds = true
        MarketClassView1.addSubview(icon6)
        let title6:QZHUILabelView = QZHUILabelView()
        title6.setLabelView(515*PX, 76*PX, 83*PX, 25*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 18, "未知分类")
        MarketClassView1.addSubview(title6)
        
        let icon7:UIImageView = UIImageView(frame:CGRect(x:622*PX,y:5*PX,width:66*PX,height:66*PX))
        icon7.backgroundColor = UIColor(patternImage: setupImgBg(colors:[UIColor(red:118/255,green:220/255,blue:174/255,alpha:1),UIColor(red:66/255,green:159/255,blue:188/255,alpha:1)], size: CGSize(width:66*PX,height:66*PX)))
        icon7.tag = 1
        icon7.layer.cornerRadius = 33*PX
        icon7.clipsToBounds = true
        MarketClassView1.addSubview(icon7)
        let title7:QZHUILabelView = QZHUILabelView()
        title7.setLabelView(613*PX, 76*PX, 83*PX, 25*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 18, "未知分类")
        MarketClassView1.addSubview(title7)
        
        let icon8:UIImageView = UIImageView(frame:CGRect(x:720*PX,y:5*PX,width:66*PX,height:66*PX))
        icon8.backgroundColor = UIColor(patternImage: setupImgBg(colors: [UIColor(red:255/255,green:88/255,blue:88/255,alpha:1),UIColor(red:240/255,green:152/255,blue:25/255,alpha:0.90)], size: CGSize(width:66*PX,height:66*PX)))
        icon8.tag = 1
        icon8.layer.cornerRadius = 33*PX
        icon8.clipsToBounds = true
        MarketClassView1.addSubview(icon8)
        let title8:QZHUILabelView = QZHUILabelView()
        title8.setLabelView(711*PX, 76*PX, 83*PX, 25*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 18, "未知分类")
        MarketClassView1.addSubview(title8)
        
        MarketClassView1.contentSize = CGSize(width:800*PX,height:105*PX)
        
    }
    
    // 设置分类图标背景色
    func setupImgBg(colors:[UIColor],size:CGSize)->UIImage{
        return UIImage(gradientColors:colors,size:size)!
    }
    
    // 设置促销专区
    func setupPromotionView(){
        prmotionView.setupScrollerView(x: 0, y: 729*PX, width: SCREEN_WIDTH, height: 330*PX, background: UIColor.white)
        prmotionView.contentSize = CGSize(width:SCREEN_WIDTH,height:330*PX)
        var paddingX = 20*PX
        for i in 0..<4{
            paddingX = self.setupProPromotion(x: paddingX, img: "", name: "", newprice: 0.0, old: 0.0, id: -1, sellTypes: "", unit: "")
        }
        
        tabbelView?.addSubview(prmotionView)
    }
    // 促销专区产品样式
    func setupProPromotion(x:CGFloat,img:String,name:String,newprice:Double,old:Double,id:Int64,sellTypes:String,unit:String)->CGFloat{
        let selfView:QZHUIView = QZHUIView()
        selfView.tag = Int(id)
        if id != -1 {
            selfView.addOnClickLister(target: self, action: #selector(self.goToProDetail(_:)))
        }
        
        selfView.setupViews(x: x, y: 0, width: 220*PX, height: 330*PX, bgColor: UIColor.white)
        prmotionView.addSubview(selfView)
        
        var paddingLeft:CGFloat=x
        
        let imgView:UIImageView = UIImageView(frame:CGRect(x:5*PX,y:6*PX,width:208*PX,height:208*PX))
        if img == ""{
            imgView.image = UIImage(named:"loadPic")
        }else if img == "noPic"{
            imgView.image = UIImage(named:img)
        }else{
            imgView.image = UIImage(data:PublicFunction().imgFromURL(img))
        }
        selfView.addSubview(imgView)
        
        let sellTypeView:QZHUIView = QZHUIView()
        let sellType:QZHUILabelView = QZHUILabelView()
        if sellTypes != ""{
            sellType.setLabelView(11*PX, 0, sellType.autoLabelWidth(sellTypes, font: 18, height: 27*PX)+3, 27*PX, NSTextAlignment.center, UIColor.clear, UIColor.white, 18, sellTypes)
            sellTypeView.addSubview(sellType)
            sellTypeView.frame = CGRect(x:sellType.x,y:sellType.y,width:sellType.width,height:sellType.height)
            
            sellType.setupBgGradient(uiView: sellTypeView as! QZHUIView, colorArray: [UIColor(red:246/255,green:104/255,blue:10/255,alpha:1).cgColor,UIColor(red:239/255,green:81/255,blue:125/255,alpha:1).cgColor], loctions: [0.0,1.0], start:CGPoint(x: 0, y: 0.5), end: CGPoint(x: 0.97, y: 0.5))
            selfView.addSubview(sellTypeView)
        }
        
        
        if img != ""{
            let nameView:QZHUILabelView = QZHUILabelView()
            nameView.setLabelView(10*PX, 223*PX, 200*PX, 60*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 20, name)
            nameView.lineBreakMode = NSLineBreakMode.byCharWrapping
            nameView.numberOfLines = 2
            selfView.addSubview(nameView)
            
            let ioc:QZHUILabelView = QZHUILabelView()
            ioc.setLabelView(10*PX,  286*PX, 20*PX, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().redFf4300(), 20, "¥")
            selfView.addSubview(ioc)
            
            let new:QZHUILabelView = QZHUILabelView()
            new.setLabelView(30*PX, 284*PX, new.autoLabelWidth("\(newprice)", font: 28, height: 40*PX), 40*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 28, "\(newprice)")
            new.setRealWages(new.text!, big: 28, small: 20,fg: ".")
            selfView.addSubview(new)
            
            let unitView:QZHUILabelView = QZHUILabelView()
            unitView.setLabelView(new.x+new.width, 291*PX, unitView.autoLabelWidth("/\(unit)", font: 20, height: 28*PX), 28*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 20, "/\(unit)")
            selfView.addSubview(unitView)
            
            var oldview:QZHUILabelView = QZHUILabelView()
            oldview.setLabelView(unitView.x+unitView.width+10*PX, 293*PX, oldview.autoLabelWidth("¥\(old)", font: 20, height: 28*PX), 28*PX, NSTextAlignment.center, UIColor.clear, myColor().gray9(), 20, "¥\(old)")
            let attriText = NSAttributedString(string:oldview.text!,attributes:[NSStrikethroughStyleAttributeName:1])
            oldview.attributedText = attriText
            selfView.addSubview(oldview)
            selfView.addOnClickLister(target: self, action: #selector(self.goToProDetail(_:)))
        }
        
        paddingLeft += 230*PX
        
        prmotionView.contentSize = CGSize(width:paddingLeft,height:330*PX)
        
        return paddingLeft
    }
    
    // 设置今日推荐
    func setupRecommendView(){
        recommendView.setupViews(x: 0, y: 1139*PX, width: SCREEN_WIDTH, height: 841*PX, bgColor: myColor().grayF0())
        tabbelView?.addSubview(recommendView)
        
        let lunbo = UIImageView(frame:CGRect(x:2*PX,y:0,width:248*PX,height:420*PX))
        lunbo.image = UIImage(named:"loadPic")
        lunbo.backgroundColor = UIColor.white
        recommendView.addSubview(lunbo)
        
        self.setupRecommendProView(x: 251*PX, y: 0, img: "", name: "", price: 0.0, unit: "", id: -1)
        self.setupRecommendProView(x: 500*PX, y: 0, img: "", name: "", price: 0.0, unit: "", id: -1)
        self.setupRecommendProView(x: 2*PX, y: 421*PX, img: "", name: "", price: 0.0, unit: "", id: -1)
        self.setupRecommendProView(x: 251*PX, y: 421*PX, img: "", name: "", price: 0.0, unit: "", id: -1)
        self.setupRecommendProView(x: 500*PX, y: 421*PX, img: "", name: "", price: 0.0, unit: "", id: -1)
        
    }
    
    // 设置今日推荐
    func setupRecommendProView(x:CGFloat,y:CGFloat,img:String,name:String,price:Double,unit:String,id:Int64){
        let selfView:QZHUIView = QZHUIView()
        selfView.setupViews(x: x, y: y, width: 248*PX, height: 420*PX, bgColor: UIColor.white)
        selfView.tag = Int(id)
        if id != -1 {
            selfView.addOnClickLister(target: self, action: #selector(self.goToProDetail(_:)))
        }
        recommendView.addSubview(selfView)
        
        let imgView:UIImageView = UIImageView(frame:CGRect(x:20*PX,y:30*PX,width:208*PX,height:208*PX))
        if img == ""{
            imgView.image = UIImage(named:"loadPic")
        }else if img == "noPic"{
            imgView.image = UIImage(named:img)
        }else{
            imgView.image = UIImage(data:PublicFunction().imgFromURL(img))
        }
        selfView.addSubview(imgView)
        
        if img != ""{
            let nameView:QZHUILabelView = QZHUILabelView()
            nameView.setLabelView(24*PX, 279*PX, 200*PX, 60*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 20, name)
            nameView.lineBreakMode = NSLineBreakMode.byCharWrapping
            nameView.numberOfLines = 2
            selfView.addSubview(nameView)
            
            let ioc:QZHUILabelView = QZHUILabelView()
            ioc.setLabelView(24*PX,  352*PX, 20*PX, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().redFf4300(), 20, "¥")
            selfView.addSubview(ioc)
            
            let priceView:QZHUILabelView = QZHUILabelView()
            priceView.setLabelView(44*PX, 350*PX, priceView.autoLabelWidth("\(price)", font: 28, height: 40*PX), 40*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 28, "\(price)")
            priceView.setRealWages(priceView.text!, big: 28, small: 20,fg: ".")
            selfView.addSubview(priceView)
            
            let unitView:QZHUILabelView = QZHUILabelView()
            unitView.setLabelView(priceView.x+priceView.width, 357*PX, unitView.autoLabelWidth("/\(unit)", font: 20, height: 28*PX), 28*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 20, "/\(unit)")
            selfView.addSubview(unitView)
        }
    }
    
    // 设置模块标题栏
    func setupTitles(y:CGFloat,text:String,icons:String)->QZHUIView{
        let titleView:QZHUIView = QZHUIView()
        titleView.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.clear)
        
        let leftLine:QZHUILabelView = QZHUILabelView()
        leftLine.dividers(175*PX, y: 39*PX, width: 100*PX, height: 2*PX, color: myColor().grayB9())
        titleView.addSubview(leftLine)
        
        let rightLine:QZHUILabelView = QZHUILabelView()
        rightLine.dividers(475*PX, y: 39*PX, width: 100*PX, height: 2*PX, color: myColor().grayB9())
        titleView.addSubview(rightLine)
        
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(330*PX, 19*PX, 130*PX, 42*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray5(), 30, text)
        titleView.addSubview(title)
        
        let icon:UIImageView = UIImageView(frame:CGRect(x:295*PX,y:23*PX,width:35*PX,height:35*PX))
        icon.image = UIImage(named:icons)
        titleView.addSubview(icon)
        
        return titleView
    }
}

extension QZH_CYSQHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = HomeList.hotSellList.count/2+1
        if HomeList.hotSellList.count%2>0{
            count = count+1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 2060*PX
        }else{
            return 471*PX
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZH_CYSQHomeHotSell
        cell.backgroundColor = UIColor.clear
        if indexPath.row != 0{
           cell.backgroundColor = UIColor.white
            let _index = indexPath.row*2

            cell.name1.text = HomeList.hotSellList[_index-2].status.goodsName
            cell.name2.text = HomeList.hotSellList[_index-1].status.goodsName
            if HomeList.hotSellList[_index-2].status.selfSupport != 1{
                cell.zy1.text = ""
            }else{
                cell.zy1.text = "自营"
            }
            if HomeList.hotSellList[_index-1].status.selfSupport != 1{
                cell.zy2.text = ""
            }else{
                cell.zy2.text = "自营"
            }
            
            cell.price1.text = "\(HomeList.hotSellList[_index-2].status.fixedPrice)"
            cell.price2.text = "\(HomeList.hotSellList[_index-1].status.fixedPrice)"
            
            if HomeList.hotSellList[_index-2].status.unit != ""{
                cell.unit1.text = "/\(HomeList.hotSellList[_index-2].status.unit)"
            }
            if HomeList.hotSellList[_index-1].status.unit != ""{
                cell.unit2.text = "/\(HomeList.hotSellList[_index-1].status.unit)"
            }
            
            let _pic1:[[String:AnyObject]] = HomeList.hotSellList[_index-2].status.pic
            if _pic1.count != 0{
                cell.img1.image = UIImage(data:PublicFunction().imgFromURL(_pic1[0]["picturePath"] as! String))
            }else{
                cell.img1.image = UIImage(named:"noPic")
            }
            
            let _pic2:[[String:AnyObject]] = HomeList.hotSellList[_index-1].status.pic
            if _pic2.count != 0{
                cell.img2.image = UIImage(data:PublicFunction().imgFromURL(_pic2[0]["picturePath"] as! String))
            }else{
                cell.img2.image = UIImage(named:"noPic")
            }
            
            cell.view1.tag = Int(HomeList.hotSellList[_index-2].status.id)
            cell.view2.tag = Int(HomeList.hotSellList[_index-1].status.id)
            
            cell.view1.addOnClickLister(target: self, action: #selector(self.goToProDetail(_:)))
            cell.view2.addOnClickLister(target: self, action: #selector(self.goToProDetail(_:)))
        }
        return cell
    }
    
    /// 捕捉滚动条动作
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 212*PX{
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            UIApplication.shared.statusBarview?.backgroundColor = UIColor.white
            setupNav1()
            
            navItem.rightBarButtonItem = UIBarButtonItem(title: "消息", img: "chatIcon", target: self, action: #selector(showFriends))
            navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(self.close),color:UIColor.white)
            navigationBar.tintColor = myColor().gray3()
            navigationBar.barTintColor = UIColor.white
            navigationBar.isTranslucent = false
            //MarketClassView1.isHidden = false
            //MarketClassView1line.isHidden = false
            if scrollView.contentOffset.y > 340*PX{
                MarketClassView1.isHidden = false
                MarketClassView1line.isHidden = false
            }else{
                MarketClassView1.isHidden = true
                MarketClassView1line.isHidden = true
            }
            
        }else{
            
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
            UIApplication.shared.statusBarview?.backgroundColor = UIColor.clear
            setupNav()
            
            
            navItem.rightBarButtonItem = UIBarButtonItem(title: "消息", img: "chatIconWhite", target: self, action: #selector(showFriends),color:UIColor.white)
            navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon1", target: self, action: #selector(self.close),color:UIColor.white)
            navigationBar.tintColor = UIColor.white
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = true

        }
    }

}

// MARK: - 监听事件
extension QZH_CYSQHomeViewController{
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 分类
    func goToMarketClass(_ sender:UITapGestureRecognizer){
    }
    
    // 返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 搜索页面跳转
    func goToSearch(){
        let nav = QZHSearchViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 跳转产品详情页
    func goToProDetail(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHProductDetailModel.goodsId = (this?.tag)!
        
        let nav = QZHProductDetailViewController()
        present(nav, animated: true, completion: nil)
        
    }
}

extension QZH_CYSQHomeViewController: WRCycleScrollViewDelegate
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
}
