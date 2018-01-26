//
//  QZH_CYSQHomeViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/24.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZH_CYSQHomeViewController: QZH_CYSQBaseViewController {
    
    // 热销产品数据列表视图模型
    lazy var HomeList = QZGH_CYSQHomeListViewModel()
    
    // 分类图片
    var MarketClassView:QZHUIView = QZHUIView()
    var MarketClassView1:QZHUIScrollView = QZHUIScrollView()
    
    // 促销专区
    var prmotionView:QZHUIScrollView = QZHUIScrollView()
    
    // 头部轮播图容器
    lazy var cycleScrollView:WRCycleScrollView = {
        let frame = CGRect(x: 0, y:0, width: SCREEN_WIDTH, height: 468*PX)
        let cycleView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: nil, descs: nil)
        return cycleView
    }()
    
    // 今日推荐轮播图容器
    lazy var cycleScrollView1:WRCycleScrollView = {
        let frame = CGRect(x: 0, y:0, width: 248*PX, height: 420*PX)
        let cycleView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: nil, descs: nil)
        return cycleView
    }()
    
    override func loadData() {
        HomeList.loadHomeData { (isSuccess) in
            if isSuccess{
                //设置轮播图
                var imgArray:[String] = []
                for pic in self.HomeList.sildeHeadList{
                    print(pic.status.slidePictureUrl)
                    imgArray.append(pic.status.slidePictureUrl)
                }
                self.cycleScrollView.serverImgArray = imgArray as? [String]
                
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
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        // 去掉 tableview 分割线
        self.tabbelView?.separatorStyle = .none
        
        // 修改状态栏字体颜色
        tabbelView?.backgroundColor = myColor().grayF0()
        
        // 注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tabbelView?.addSubview(cycleScrollView)
        
        // 设置导航栏按钮
        navItem.rightBarButtonItem = UIBarButtonItem(title: "消息", img: "chatIconWhite", target: self, action: #selector(showFriends),color:UIColor.white)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon1", target: self, action: #selector(self.close),color:UIColor.white)
        navigationBar.tintColor = UIColor.white
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        setupNav()
        setupvarMarketClassView()
        
        setupPromotionView()
        
        tabbelView?.addSubview(self.setupTitles(y: 777*PX, text: "促销专区", icons: "CYSQ_promotion"))
        
        tabbelView?.addSubview(self.setupTitles(y: 1187*PX, text: "今日推荐", icons: "CYSQ_recommend"))
        
        tabbelView?.addSubview(self.setupTitles(y: 1948*PX, text: "热销产品", icons: "CYSQ_hot"))
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
        navItem.titleView = btn.SeacrchTitleBtn1(title: "产业商圈", titleColor: myColor().Gray6c6ca1())
    }
    
    // 设置分类图片列表
    func setupvarMarketClassView(){
        MarketClassView.setupViews(x: 0, y: 478*PX, width: SCREEN_WIDTH, height: 299*PX, bgColor: UIColor.white)
        
        let icon1:UIImageView = UIImageView(frame:CGRect(x:49*PX,y:10*PX,width:88*PX,height:88*PX))
        icon1.backgroundColor = UIColor(patternImage: UIImage(named:"CYSQ_CLass1")!)
        icon1.tag = 1
        MarketClassView.addSubview(icon1)
        let title1:QZHUILabelView = QZHUILabelView()
        title1.setLabelView(43*PX, 108*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title1)
        
        let icon2:UIImageView = UIImageView(frame:CGRect(x:237*PX,y:10*PX,width:88*PX,height:88*PX))
        icon2.backgroundColor = UIColor(patternImage: UIImage(named:"CYSQ_CLass2")!)
        icon2.tag = 1
        MarketClassView.addSubview(icon2)
        let title2:QZHUILabelView = QZHUILabelView()
        title2.setLabelView(231*PX, 108*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title2)

        let icon3:UIImageView = UIImageView(frame:CGRect(x:425*PX,y:10*PX,width:88*PX,height:88*PX))
        icon3.backgroundColor = UIColor(patternImage: UIImage(named:"CYSQ_CLass3")!)
        icon3.tag = 1
        MarketClassView.addSubview(icon3)
        let title3:QZHUILabelView = QZHUILabelView()
        title3.setLabelView(419*PX, 108*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title3)

        let icon4:UIImageView = UIImageView(frame:CGRect(x:613*PX,y:10*PX,width:88*PX,height:88*PX))
        icon4.backgroundColor = UIColor(patternImage: UIImage(named:"CYSQ_CLass4")!)
        icon4.tag = 1
        MarketClassView.addSubview(icon4)
        let title4:QZHUILabelView = QZHUILabelView()
        title4.setLabelView(607*PX, 108*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title4)

        let icon5:UIImageView = UIImageView(frame:CGRect(x:49*PX,y:161*PX,width:88*PX,height:88*PX))
        icon5.backgroundColor = UIColor(patternImage: UIImage(named:"CYSQ_CLass5")!)
        icon5.tag = 1
        MarketClassView.addSubview(icon5)
        let title5:QZHUILabelView = QZHUILabelView()
        title5.setLabelView(43*PX, 259*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title5)

        let icon6:UIImageView = UIImageView(frame:CGRect(x:237*PX,y:161*PX,width:88*PX,height:88*PX))
        icon6.backgroundColor = UIColor(patternImage: UIImage(named:"CYSQ_CLass6")!)
        icon6.tag = 1
        MarketClassView.addSubview(icon6)
        let title6:QZHUILabelView = QZHUILabelView()
        title6.setLabelView(231*PX, 259*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title6)

        let icon7:UIImageView = UIImageView(frame:CGRect(x:425*PX,y:161*PX,width:88*PX,height:88*PX))
        icon7.backgroundColor = UIColor(patternImage: UIImage(named:"CYSQ_CLass7")!)
        icon7.tag = 1
        MarketClassView.addSubview(icon7)
        let title7:QZHUILabelView = QZHUILabelView()
        title7.setLabelView(419*PX, 259*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title7)

        let icon8:UIImageView = UIImageView(frame:CGRect(x:613*PX,y:161*PX,width:88*PX,height:88*PX))
        icon8.backgroundColor = UIColor(patternImage: UIImage(named:"CYSQ_CLass8")!)
        icon8.tag = 1
        MarketClassView.addSubview(icon8)
        let title8:QZHUILabelView = QZHUILabelView()
        title8.setLabelView(607*PX, 259*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 22, "未知分类")
        MarketClassView.addSubview(title8)

        
        tabbelView?.addSubview(MarketClassView)
    }
    func setupvarMarketClassView1(){
        
    }
    
    // 设置促销专区
    func setupPromotionView(){
        prmotionView.setupScrollerView(x: 0, y: 857*PX, width: SCREEN_WIDTH, height: 330*PX, background: UIColor.white)
        prmotionView.contentSize = CGSize(width:SCREEN_WIDTH,height:330*PX)
        var paddingX = 20*PX
        for i in 0..<4{
            paddingX = self.setupProPromotion(x: paddingX, img: "", name: "", newprice: 0.0, old: 0.0, id: 0, sellTypes: "买就送", unit: "盒")
            print(paddingX)
        }
        
        tabbelView?.addSubview(prmotionView)
    }
    // 促销专区产品样式
    func setupProPromotion(x:CGFloat,img:String,name:String,newprice:Double,old:Double,id:Int64,sellTypes:String,unit:String)->CGFloat{
        let selfView:QZHUIView = QZHUIView()
        selfView.setupViews(x: x, y: 0, width: 220*PX, height: 330*PX, bgColor: UIColor.white)
        prmotionView.addSubview(selfView)
        
        var paddingLeft:CGFloat=x
        
        let imgView:UIImageView = UIImageView(frame:CGRect(x:5*PX,y:6*PX,width:208*PX,height:208*PX))
        if img != ""{
            imgView.image = UIImage(data:PublicFunction().imgFromURL(img))
        }else{
            imgView.image = UIImage(named:"loadPic")
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
        
        
        let nameView:QZHUILabelView = QZHUILabelView()
        nameView.setLabelView(10*PX, 223*PX, 200*PX, 60*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 20, name)
        nameView.lineBreakMode = NSLineBreakMode.byCharWrapping
        nameView.numberOfLines = 2
        selfView.addSubview(nameView)
        
        let ioc:QZHUILabelView = QZHUILabelView()
        ioc.setLabelView(10*PX,  284*PX, 20*PX, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().redFf4300(), 20, "¥")
        selfView.addSubview(ioc)
        
        let new:QZHUILabelView = QZHUILabelView()
        new.setLabelView(30*PX, 284*PX, new.autoLabelWidth("\(newprice)", font: 28, height: 40*PX), 40*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 28, "\(newprice)")
        new.setRealWages(new.text!, big: 28, small: 20,fg: ".")
        selfView.addSubview(new)
        
        let unitView:QZHUILabelView = QZHUILabelView()
        unitView.setLabelView(new.x+new.width, 291*PX, unitView.autoLabelWidth("/\(unit)", font: 20, height: 28*PX), 28*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 20, "/\(unit)")
        selfView.addSubview(unitView)
        
        var oldview:QZHUILabelView = QZHUILabelView()
        oldview.setLabelView(140*PX, 293*PX, 65*PX, 28*PX, NSTextAlignment.center, UIColor.clear, myColor().gray9(), 20, "¥\(old)")
        let attriText = NSAttributedString(string:oldview.text!,attributes:[NSStrikethroughStyleAttributeName:1])
        oldview.attributedText = attriText
        selfView.addSubview(oldview)
        
        paddingLeft += 230*PX
        
        prmotionView.contentSize = CGSize(width:paddingLeft,height:330*PX)
        
        return paddingLeft
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
        return HomeList.hotSellList.count/2+1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 2187*PX
        }else{
            return 480*PX
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    /// 捕捉滚动条动作
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 128*PX{
            
        }else{
         
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
    
    //返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    //搜索页面跳转
    func goToSearch(){
        let nav = QZHSearchViewController()
        present(nav, animated: true, completion: nil)
    }
}
