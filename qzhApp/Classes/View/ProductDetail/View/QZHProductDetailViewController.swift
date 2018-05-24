

//
//  QZHProductDetailViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/2/1.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHProductDetailViewController: QZHBaseViewController,UIWebViewDelegate{
    // 收藏
    lazy var collectStatus = QZHCollectListPorListViewModel()
    
    // 操作结果显示
    var timer:Timer!
    var resultView:QZHUIView = QZHUIView()
    
    // 原始价格
    var olderPrice:String = ""
    var olderKC:String = ""
    var olderImg:UIImage = UIImage()
    
    // 规格IDs
    var productIds:String = ""
    var productIdCount:Int = 0
    var proIds:String = ""
    var specNameStr:String = ""
    var specIdStr:String = ""
    var proIdArray:String = ""
    var proIdFlaga:Int = 0
    var specCount:Int = 0
    
    // tableView头部headerView
    var headerView:QZHUIView = QZHUIView()
    
    // 透明导航
    var topView:QZHUIView = QZHUIView()
    
    lazy var productDetailStatus = QZHProductDetailViewModel()
    
    // 店铺按钮 - 底部
    var footer_Shop:QZHUIButton = QZHUIButton()
    
    // 客服 - 底部
    var footer_Customer:QZHUIButton = QZHUIButton()
    
    // 收藏 - 底部
    var footer_Collection:QZHUIButton = QZHUIButton()
    var footer_Collection1:QZHUIButton = QZHUIButton()
    
    // 加入购物车 - 底部
    var footer_AddCar:QZHUILabelView = QZHUILabelView()
    
    // 立即购买 - 底部
    var footer_BuyNow:QZHUILabelView = QZHUILabelView()
    
    // 头部显示产品图片
    var proPic:UIImageView = UIImageView()
    var proPicBtn:UIButton = UIButton()
    
    // 头部选项卡
    var tabView:QZHUIView = QZHUIView()
    
    // 产品名称
    var proName:QZHUILabelView = QZHUILabelView()
    
    // 销售价格
    var pricIcon:QZHUILabelView = QZHUILabelView()
    var priceLabel:QZHUILabelView = QZHUILabelView()
    
    // 原价格
    var delPriceLabel:QZHUILabelView = QZHUILabelView()
    
    // 评价显示
    var commentView:QZHUIView = QZHUIView()
    
    // 详情标题
    var DetailTitle:QZHUIView = QZHUIView()
    // 详情显示
    var proDetail:UIWebView = UIWebView()
    
    // 推荐标题
    var pullTitle:QZHUIView = QZHUIView()
    
    // 店铺显示
    var shopView:QZHUIView = QZHUIView()
    
    // 头部轮播组
    var topSroller:QZHUIScrollView = QZHUIScrollView()

    // 头部 3D 轮播图容器
    lazy var cycleScrollView:WRCycleScrollView = {
        let frame = CGRect(x: 0, y:0, width: SCREEN_WIDTH, height: 750*PX)
        let cycleView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: nil, descs: nil)
        cycleView.isUserInteractionEnabled = false
        cycleView.showPageControl = false
        cycleView.autoScrollInterval = 0.3
        return cycleView
    }()
    
    // 产品参数
    var csView:QZHUIScrollView = QZHUIScrollView()
    
    // 产品规格
    var ggView:QZHUIScrollView = QZHUIScrollView()
    // 规格 显示内容
    var ggIcon:UIImageView = UIImageView()
    var ggPrice:QZHUILabelView = QZHUILabelView()
    var ggKC:QZHUILabelView = QZHUILabelView()
    var ggGG:QZHUILabelView = QZHUILabelView()
    var ggContent:QZHUIScrollView = QZHUIScrollView()
    var buyNum:UITextField = UITextField()
    var KCNum:Double = 0
    var specOptionIds:String = ""
    var btn1:QZHUIView = QZHUIView()
    var btn2:QZHUILabelView = QZHUILabelView()
    var btn3:QZHUILabelView = QZHUILabelView()
    var NowKC:Double = 0.0
    
    
    // 背景遮罩层
    var blackBG:QZHUIView = QZHUIView()
    
    // 显示到底
    var noProView:QZHUIView = QZHUIView()
    
    // 产品单位
    var proUnit:String! = ""
    
    // 表格行数
    var cellCount:Int = 2
    
    // 视频
    var webView:UIWebView = UIWebView(frame:CGRect(x:0,y:0,width:750*PX,height:750*PX))
    
    override func loadData() {
        self.productDetailStatus.addFooter { (isSuccess) in
            self.getData()
            
        }
        
    }
    
    func getData() {
        // 获取产品详情
        productDetailStatus.getProductGoodsDetail(completion: { (isSuccess) in
            if isSuccess{
                let goods = self.productDetailStatus.goodsStatus
                let pic = self.productDetailStatus.picStatus
                let price = self.productDetailStatus.proPriceStatus
                let space = self.productDetailStatus.proSpaceStatus
                let attrtion = self.productDetailStatus.proAttOptionsStatus
                let shop = self.productDetailStatus.shopStatus
                let attentionClloect = self.productDetailStatus.attentionCollectStatus
                let comment = self.productDetailStatus.commentStatus
                let replies = self.productDetailStatus.commentReplies
                let goodDetail = self.productDetailStatus.proDeatailStatus
                QZHProductDetailModel.goodsId = Int(goods[0].status.id)
                QZHProductDetailModel.memberId = goods[0].status.eipMemberId
                self.topSroller.contentSize.width = 0
                if pic[0].status.videoPath != ""{
                    
                    let urlString = "https://m.sceo360.com/video.mp4"
                    // 1> URL 确定要访问的资源
                    guard let url = URL(string: urlString) else {
                        return
                    }
                    // 2> 建立请求
                    let request = URLRequest(url: url)
                    
                    // 3> 加载请求
                    self.webView.delegate = self
                    self.webView.loadRequest(request)
                    self.webView.allowsInlineMediaPlayback = true
                    self.webView.mediaPlaybackRequiresUserAction = false
                    
                    self.topSroller.addSubview(self.webView)
                    self.topSroller.contentSize = CGSize(width:self.topSroller.contentSize.width + 750*PX,height:750*PX)
                    
                    
                }
                if pic[0].status.picture3dPath != ""{
                    var imgArray1:[String] = pic[0].status.picture3dPath.components(separatedBy: ",")
                    self.cycleScrollView.serverImgArray = imgArray1 as? [String]
                    self.topSroller.addSubview(self.cycleScrollView)
                    self.topSroller.contentSize = CGSize(width:self.topSroller.contentSize.width + 750*PX,height:750*PX)
                }
                
                var imgArray:[String] = pic[0].status.picturePath.components(separatedBy: ",")
                for i in 0..<imgArray.count{
                    let img:UIImageView = UIImageView(frame:CGRect(x:self.topSroller.contentSize.width,y:0,width:750*PX,height:750*PX))
                    if let url = URL(string: imgArray[i]) {
                        img.downloadedFrom(url: url)
                    }else{
                        img.image = UIImage(named:"noPic")
                    }
                    self.topSroller.addSubview(img)
                    self.topSroller.contentSize = CGSize(width:self.topSroller.contentSize.width + 750*PX,height:750*PX)
                }
                self.proName.text = goods[0].status.goodsName
                self.setupPriceLabel(price: goods[0].status.fixedPrice.roundTo(places: 2))
                self.ggPrice.text = "¥\(goods[0].status.fixedPrice.roundTo(places: 2))"
                self.olderPrice = "\(goods[0].status.fixedPrice.roundTo(places: 2))"
                self.proUnit = goods[0].status.unit
                self.ggKC.text = "库存\(goods[0].status.stock)\(goods[0].status.unit)"
                self.NowKC = goods[0].status.stock
                self.olderKC = "库存\(goods[0].status.stock)\(goods[0].status.unit)"
                
                var picArray = pic[0].status.picturePath.components(separatedBy: ",")
                if picArray.count > 0{
                    if let url = URL(string: picArray[0]) {
                        self.ggIcon.downloadedFrom(url: url)
                    }else{
                        self.ggIcon.image = UIImage(named:"noPic")
                    }
                    
                    
                    //img = img?.specifiesHeight(80*PX)
                    self.navItem.titleView?.width = 80*PX
                    let navImg:UIImageView = UIImageView(frame:CGRect(x:0,y:0,width:80*PX,height:80*PX))
                    if let url = URL(string: picArray[0]) {
                        navImg.downloadedFrom1(url: url)
                        QZHCommentModel.proImg = picArray[0]
                    }else{
                        navImg.image = UIImage(named:"noPic")
                        QZHCommentModel.proImg = "noPic"
                    }
                    self.navItem.titleView = navImg
                    self.navItem.titleView?.width = 80*PX
                    
                }else{
                    var img = UIImage(named:"noPic")
                    img = img?.specifiesHeight(80*PX)
                    self.navItem.titleView?.width = 80*PX
                    self.navItem.titleView = UIImageView(image:img)
                    self.olderImg = img!
                }
                
                
                if comment.count > 0{
                    var avatar_logo = replies[0][0].status.avatar
                   var avatar_logoFlag = 1
                   /*  if avatar_logo == ""{
                        avatar_logo = "proUserLogo"
                        avatar_logoFlag = 0
                    }*/
                    
                    var starNums = 0
                    var commentNum:Double = Double.init(comment[0].status.goodsComment)!
                    //Double.init(comment[0].status.goods_evaluation)! + Double.init(comment[0].status.service_evaluation)!
                    if commentNum == 0.0{
                        starNums = 0
                    }else if commentNum < 2.0 {
                        starNums = 1
                    }else if commentNum < 3.0{
                        starNums = 2
                    }else if commentNum < 4.0{
                        starNums = 3
                    }else if commentNum < 5.0{
                        starNums = 4
                    }else{
                        starNums = 5
                    }
                    self.setupComment(y: self.commentView.y, count: QZHProductDetail_PROListCommentModel.count, photo: avatar_logo,photoFlag:avatar_logoFlag, userName: replies[0][0].status.accountName, date: comment[0].status.orderTime, star: starNums, content: replies[0][0].status.goodsDescripe)
                }
                
                var shop_logo = shop[0].status.storeLogo
                if shop_logo == ""{
                    shop_logo = "noPic"
                }
                QZHStoreInfoModel.memberID = shop[0].status.memberId
                self.headerView.addSubview(self.setupShopView(y: self.shopView.y, photo: shop_logo, shopName: shop[0].status.shortName, Vip: shop[0].status.memberLevel, proCount: shop[0].status.goodsNum, sale: shop[0].status.monthSales, scCount: shop[0].status.collectionNum, proComment: CGFloat(shop[0].status.goodsEvalution.roundTo(places: 1)), sComment: CGFloat(shop[0].status.serviceEvalution.roundTo(places: 1))))
                
                if goodDetail.count > 0{
                    self.setupProDetail(y: self.DetailTitle.y + self.DetailTitle.height, jsPath: goodDetail[0].status.productDetailsApp)
                }
                
                var csCount:CGFloat = 80*PX
                for i in 0..<attrtion.count{
                    csCount = self.setupProCS(y: csCount, title: attrtion[i].status.attrbuteName, content: attrtion[i].status.attributeOptionName,tags:Int(attrtion[i].status.attributeOptionId))
                    if csCount > 585*PX{
                        self.csView.contentSize = CGSize(width:SCREEN_WIDTH,height:csCount)
                    }
                }
                
                // 规格 设置
                var ggTop:CGFloat = 0
                self.specCount = space.count
                for i in 0..<space.count{
                    ggTop = self.setupCommentList(y: ggTop, title: space[i].status.specName, commentArray: space[i].status.option as! [[String : AnyObject]],i+1)
                }
                if self.productDetailStatus.attentionCollectStatus[0].status.collentProduct == 1{
                    self.footer_Collection.isHidden = true
                    self.footer_Collection1.isHidden = false
                }else{
                    self.footer_Collection.isHidden = false
                    self.footer_Collection1.isHidden = true
                }
                
               self.getPro()
               
            }
        }) { (isSuccess) in
            if isSuccess{
                
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // 获取产品价格
    func getProductPrice(proID:Int64){
        QZHProductDetailModel.productId = proID
        productDetailStatus.getProductPrice { (result, isSuccess) in
            if isSuccess{
                if result[0].status.promotionPrice == 0.0{
                    self.ggPrice.text = "¥\(result[0].status.originalPrice)"
                    self.setupPriceLabel(price: result[0].status.originalPrice.roundTo(places: 2))
                    self.setupDelPriceLabel(price: 0.0)
                    
                }else{
                    self.ggPrice.text = "¥\(result[0].status.promotionPrice.roundTo(places: 2))"
                    self.setupPriceLabel(price: result[0].status.promotionPrice.roundTo(places: 2))
                    self.setupDelPriceLabel(price: result[0].status.originalPrice.roundTo(places: 2))
                }
                self.ggKC.text = "库存\(result[0].status.stock)\(self.proUnit!)"
                self.NowKC = result[0].status.stock
                if result[0].status.picturePath == ""{
                
                    self.ggIcon.image = UIImage(named:"noPic")
                
                }else{
                    if let url = URL(string: result[0].status.picturePath) {
                        self.ggIcon.downloadedFrom(url: url)
                    }else{
                        self.ggIcon.image = UIImage(named:"noPic")
                    }
                }
            }
        }
    }
    
    // 获取推荐产品
    func getPro(){
        productDetailStatus.getRecmPro(pullup: self.isPulup) { (isSuccess,shouldRefresh ) in
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

// MARK: - 产品详情页面 UI 设置
extension QZHProductDetailViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        proDetail.delegate = self
        
        // 去掉 tableview 分割线
        self.tabbelView?.separatorStyle = .none
        
        tabbelView?.backgroundColor = myColor().grayF0()
        
        // 注册原型 cell
        //tabbelView?.register(QZHProductDetailCell.self, forCellReuseIdentifier: cellId)
        tabbelView?.register(UINib(nibName:"QZHProductDetailCell",bundle:nil), forCellReuseIdentifier: cellId)
        tabbelView?.height = SCREEN_HEIGHT - 100*PX
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                tabbelView?.height = SCREEN_HEIGHT - 216*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        
        // 设置cell高度自适应
        //tabbelView?.rowHeight = UITableViewAutomaticDimension
        
        // 设置导航栏按钮
        self.navigationBar.isHidden = true

        setupNav1()
        setupNav()
        setupHeaderView()
        setupTopScroll()
        setupMain()
        setupFooter()
        setupTabView()

        blackBG.blackBackground(y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        blackBG.addOnClickLister(target: self, action: #selector(self.bghidden))
        view.addSubview(blackBG)
        setupProCSView()
        setupProGGView()
    }
    
    func setupHeaderView(){
        headerView.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 750*PX, bgColor: myColor().grayF0())
        tabbelView?.tableHeaderView = headerView
    }
    
    // 设置头部轮播
    func setupTopScroll(){
        topSroller.delegate = self
        topSroller.tag = 1
        topSroller.setupScrollerView(x: 0, y: 0, width: 750*PX, height: 750*PX, background: UIColor.red)
        
        topSroller.contentSize = CGSize(width:SCREEN_WIDTH,height:SCREEN_WIDTH)
        
        let bg:UIImageView = UIImageView(frame:CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_WIDTH))
        bg.image = UIImage(named:"loadPic")
        topSroller.addSubview(bg)
        headerView.height = 750*PX
        headerView.addSubview(topSroller)
    }
    
    
    // 设置头部导航
    func setupNav(){
        let img = UIImage(named:"loadPic")
        
        navItem.titleView?.width = 80*PX
        navItem.titleView = UIImageView(image:img)
        navItem.rightBarButtonItems = [UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends),color:UIColor.white),UIBarButtonItem(title: "", img: "producrDetail_Car2", target: self, action: #selector(gotoCar),color:UIColor.white)]
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon2", target: self, action: #selector(self.close),color:UIColor.white)
        navigationBar.tintColor = UIColor.white

    }
    
    // 设置头部透明导航
    func setupNav1(){
        topView.setupViews(x: 0, y: 54*PX, width: SCREEN_WIDTH, height: 60*PX, bgColor: UIColor.clear)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                topView.setupViews(x: 0, y: 102*PX, width: SCREEN_WIDTH, height: 60*PX, bgColor: UIColor.clear)
            }
            
        } else {
            // Fallback on earlier versions
        }
        
        let back:QZHUIView = QZHUIView()
        back.setupViews(x: 20*PX, y: 0, width: 60*PX, height: 60*PX, bgColor: UIColor(red:0/255,green:0/255,blue:0/255,alpha:0.5))
        back.layer.cornerRadius = 30*PX
        let back_Img:UIImageView = UIImageView(frame:CGRect(x:20*PX,y:12*PX,width:20*PX,height:35*PX))
        back_Img.image = UIImage(named:"back_pageIcon1")
        back.addSubview(back_Img)
        back.addOnClickLister(target: self, action: #selector(self.close))
        topView.addSubview(back)
        
        let search:QZHUIView = QZHUIView()
        search.setupViews(x: 580*PX, y: 0, width: 60*PX, height: 60*PX, bgColor: UIColor(red:0/255,green:0/255,blue:0/255,alpha:0.5))
        search.layer.cornerRadius = 30*PX
        let search_Img:UIImageView = UIImageView(frame:CGRect(x:15*PX,y:15*PX,width:30*PX,height:30*PX))
        search_Img.image = UIImage(named:"producrDetail_Car1")
        search.addSubview(search_Img)
        search.addOnClickLister(target: self, action: #selector(self.gotoCar))
        topView.addSubview(search)
        
        let friend:QZHUIView = QZHUIView()
        friend.setupViews(x: 660*PX, y: 0, width: 60*PX, height: 60*PX, bgColor: UIColor(red:0/255,green:0/255,blue:0/255,alpha:0.5))
        friend.layer.cornerRadius = 30*PX
        let friend_Img:UIImageView = UIImageView(frame:CGRect(x:13*PX,y:13*PX,width:35*PX,height:35*PX))
        friend_Img.image = UIImage(named:"chatIconWhite")
        friend.addSubview(friend_Img)
        friend.addOnClickLister(target: self, action: #selector(self.showFriends))
        topView.addSubview(friend)
        
        view.addSubview(topView)
    }
    
    // 设置头部选项卡
    func setupTabView(){
        tabView.isHidden = true
        tabView.setupViews(x: 0, y: 128*PX, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
               tabView.setupViews(x: 0, y: 176*PX, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
            }
            
        } else {
            // Fallback on earlier versions
        }
        let tbn1 = setupTabViewList(x:65*PX,title:"宝贝")
        tbn1.tag = 5
        setupTabViewUI(tbn1)
        setupTabViewList(x:251*PX,title:"评价").tag = 2
        setupTabViewList(x:437*PX,title:"详情").tag = 3
        setupTabViewList(x:623*PX,title:"推荐").tag = 4
        
        view.addSubview(tabView)
    }
    // 设置选项卡内容项
    func setupTabViewList(x:CGFloat,title:String)->QZHUILabelView{
        let listView:QZHUILabelView = QZHUILabelView()
        listView.setLabelView(x, 0, 62*PX, 80*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 28, title)
        let line:QZHUILabelView = QZHUILabelView()
        line.tag = 1
        line.dividers(0*PX, y: 75*PX, width: 62*PX, height: 5*PX, color: UIColor.white)
        listView.addSubview(line)
        listView.addOnClickLister(target: self, action: #selector(self.tabViewAction(_:)))
        tabView.addSubview(listView)
        return listView
    }
    
     // 选项卡 UI 样式设置
    func setupTabViewUI(_ thisView:QZHUILabelView){
        let _labelArray:[UIView] = (thisView.superview as! UIView).subviews as! [UIView]
        for i in 0..<_labelArray.count{
            (_labelArray[i]as! QZHUILabelView).textColor = myColor().gray3()
            _labelArray[i].viewWithTag(1)?.backgroundColor = UIColor.white
        }
        thisView.textColor = myColor().blue007aff()
        thisView.viewWithTag(1)?.backgroundColor = myColor().blue007aff()
    }
    
    // 设置主体部分
    func setupMain(){
        // 名称 价格 分享
        let view1:QZHUIView = QZHUIView()
        view1.setupViews(x: 0, y: topSroller.height, width: SCREEN_WIDTH, height: 183*PX, bgColor: UIColor.white)
        headerView.height = view1.y + 183*PX
        headerView.addSubview(view1)
        
        proName.setLabelView(20*PX, 10*PX, 610*PX, 84*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3()
            , 30, "")
        proName.numberOfLines = 2
        proName.lineBreakMode = .byTruncatingTail
        view1.addSubview(proName)
        
        let shareBtn:QZHUIButton = QZHUIButton()
        shareBtn.setupButton(670*PX, 10*PX, 60*PX, 84*PX, myColor().Gray6(), UIColor.clear, "分享", 24, 0, UIColor.clear, "ProshareIcon", UIControlState.normal, 5*PX, UIViewContentMode.bottom)
        shareBtn.addTarget(self, action: #selector(share), for: .touchUpInside)
        shareBtn.frame = CGRect(x:670*PX,y:10*PX,width:60*PX,height:84*PX)
        view1.addSubview(shareBtn)

        view1.addSubview(pricIcon)

        view1.addSubview(priceLabel)
        
        view1.addSubview(delPriceLabel)
        
        // 产品参数 UI
        let View2:QZHUIView = QZHUIView()
        View2.setupViews(x: 0, y: view1.y+view1.height+10*PX, width: SCREEN_WIDTH, height: 161*PX, bgColor: UIColor.white)
        headerView.height = View2.y + 161*PX
        headerView.addSubview(View2)
        // 产品参数
        let proAttr:QZHUILabelView = QZHUILabelView()
        proAttr.setLabelView(20*PX, 0, 710*PX, 80*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 26, "产品参数")
        let arrtIcon:UIImageView = UIImageView(frame:CGRect(x:698*PX,y:29*PX,width:12*PX,height:21*PX))
        arrtIcon.image = UIImage(named:"proRightOpen")
        proAttr.addSubview(arrtIcon)
        proAttr.addOnClickLister(target: self, action: #selector(self.openProAttr))
        View2.addSubview(proAttr)
        // 分割线
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(20*PX, y: 80*PX, width: 710*PX, height: 1*PX, color: myColor().grayEB())
        View2.addSubview(line)
        
        // 选择规格
        let proSpace:QZHUILabelView = QZHUILabelView()
        proSpace.setLabelView(20*PX, 81*PX, 710*PX, 80*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 26, "选择规格")
        let SpaceIcon:UIImageView = UIImageView(frame:CGRect(x:698*PX,y:29*PX,width:12*PX,height:21*PX))
        SpaceIcon.image = UIImage(named:"proRightOpen")
        proSpace.addSubview(SpaceIcon)
        proSpace.addOnClickLister(target: self, action: #selector(self.openProSpace))
        View2.addSubview(proSpace)
        
        // 评价
        let EvaluationTitle:QZHUIView = QZHUIView()
        self.setupTitleUI(selView: EvaluationTitle, y: View2.y+View2.height, title: "评价", icon: "proEvaluationIcon")
        setupComment(y:EvaluationTitle.y+EvaluationTitle.height,count:0,photo:"",photoFlag :0,userName:"",date:"",star:0,content:"")
        
        // 店铺
        headerView.addSubview(setupShopView(y: commentView.y+commentView.height+10*PX, photo: "loadPic", shopName: "", Vip: "", proCount: -1, sale: 0, scCount: 0, proComment: 0.0, sComment: 0.0))
        
        // 详情标题
        //let DetailTitle:QZHUIView = QZHUIView()
        self.setupTitleUI(selView: DetailTitle, y: shopView.y+shopView.height, title: "详情", icon: "proDetailIcon")
        var content = "<html><body><p></body></html>"
        //setupProDetail(y: DetailTitle.y+DetailTitle.height, jsPath: content)
        
    }
    
    // 设置价格
    func setupPriceLabel(price:Double){
        pricIcon.setLabelView(20*PX, 107*PX, 25*PX, 59*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 34, "¥")
        priceLabel.setLabelView(45*PX, 104*PX, priceLabel.autoLabelWidth("\(price)", font: 42, height: 59*PX), 59*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 42, "\(price)")
        priceLabel.setRealWages(priceLabel.text!, big: 42, small: 34, fg: ".")

    }
    func setupDelPriceLabel(price:Double){
        delPriceLabel.setLabelView(priceLabel.width+priceLabel.y, 123*PX, delPriceLabel.autoLabelWidth("价格¥\(price)", font: 22, height: 30*PX), 30*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 22, "价格¥\(price)")
        let delLine = NSAttributedString(string: delPriceLabel.text!, attributes: [NSStrikethroughStyleAttributeName:1,NSStrikethroughColorAttributeName:myColor().Gray6()])
        delPriceLabel.attributedText = delLine
        let lineDel:QZHUILabelView = QZHUILabelView()
        lineDel.dividers(0, y: 14*PX, width: delPriceLabel.width, height: 2*PX, color: myColor().Gray6())
        delPriceLabel.addSubview(lineDel)
        if price == 0.0{
            delPriceLabel.width = 0
        }
    }
    
    // 设置评价
    func setupComment(y:CGFloat,count:Int,photo:String,photoFlag:Int,userName:String,date:String,star:Int,content:String){
        commentView.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: 344*PX, bgColor: UIColor.white)
        headerView.height = y + 344*PX
        headerView.addSubview(commentView)
        if commentView.subviews.count > 0{
            commentView.subviews[0].removeFromSuperview()
        }
        
        if count == 0{
            let noView:QZHUILabelView = QZHUILabelView()
            noView.setLabelView(0, 0, SCREEN_WIDTH, 344*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 34, "暂无评论")
            commentView.addSubview(noView)
        }else{
            // 用户图像
            let photoView:UIImageView = UIImageView(frame:CGRect(x:20*PX,y:20*PX,width:60*PX,height:60*PX))
            photoView.layer.cornerRadius = 30*PX
            photoView.clipsToBounds = true
            if photoFlag == 0{
                photoView.image = UIImage(named:photo)
            }else{
                if let url = URL(string: photo) {
                    photoView.downloadedFrom(url: url)
                }else{
                    photoView.image = UIImage(named:"proUserLogo")
                }
            }
            commentView.addSubview(photoView)
            
            let sessionId = userName
            let index = sessionId.index(sessionId.endIndex, offsetBy: -1)
            let suffix = sessionId.substring(from: index)
            
            let indexs = sessionId.index(sessionId.startIndex, offsetBy: 1)
            
            let prefix = sessionId.substring(to: indexs)
            
            let userView:QZHUILabelView = QZHUILabelView()
            userView.setLabelView(100*PX, 30*PX, userView.autoLabelWidth(userName, font: 28, height: 40*PX), 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, "\(prefix)***\(suffix)")
            commentView.addSubview(userView)
            
            for i in 0..<5{
                let starView:UIImageView = UIImageView(frame:CGRect(x:550*PX+38*PX*CGFloat(i),y:36*PX,width:28*PX,height:28*PX))
                if i >= star{
                    starView.image = UIImage(named:"star1")
                }else{
                    starView.image = UIImage(named:"star")
                }
                commentView.addSubview(starView)
            }
            
            let dateView:QZHUILabelView = QZHUILabelView()
            dateView.setLabelView(20*PX, 90*PX, 600*PX, 28*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 20, "购买日期：\(date)")
            commentView.addSubview(dateView)
            
            let contentView:QZHUILabelView = QZHUILabelView()
            contentView.setLabelView(20*PX, 138*PX, 696*PX, 70*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, content)
            contentView.numberOfLines = 2
            contentView.lineBreakMode = .byTruncatingTail 
            commentView.addSubview(contentView)
            
            let btn:QZHUIButton = QZHUIButton()
            btn.setupButton(245*PX, 244*PX, 260*PX, 60*PX, myColor().blue007aff(), UIColor.white, "查看全部评价（\(count)）", 24, 1*PX, myColor().blue007aff(), "", UIControlState.normal, 0, UIViewContentMode.center)
            btn.frame = CGRect(x:245*PX,y:244*PX,width:260*PX,height: 60*PX)
            btn.layer.cornerRadius = 8*PX
            btn.addTarget(self, action: #selector(self.checkEvaluation), for: .touchUpInside)
            commentView.addSubview(btn)
        }
    }
    
    // 设置店铺
    func setupShopView(y:CGFloat,photo:String,shopName:String,Vip:String,proCount:Int,sale:Int,scCount:Int,proComment:CGFloat,sComment:CGFloat) ->QZHUIView{
        shopView.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: 400*PX, bgColor: UIColor.white)
        headerView.height = y + 400*PX
        
        let photoView:UIImageView = UIImageView(frame:CGRect(x:20*PX,y:20*PX,width:100*PX,height:100*PX))
        if let url = URL(string:photo) {
            photoView.downloadedFrom(url: url)
        }else{
            photoView.image = UIImage(named:"noPic")
        }
        shopView.addSubview(photoView)
        
        let titleView:QZHUILabelView = QZHUILabelView()
        titleView.setLabelView(140*PX, 28*PX, titleView.autoLabelWidth(shopName, font: 30, height: 42*PX), 42*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 30, shopName)
        shopView.addSubview(titleView)
        
        if Vip != ""{
            let icon:UIImageView = UIImageView(frame:CGRect(x:140*PX,y:85*PX,width:25*PX,height:25*PX))
            icon.image = UIImage(named:"proVIPcon")
            shopView.addSubview(icon)
            let vipView:QZHUILabelView = QZHUILabelView()
            vipView.setLabelView(170*PX, 82*PX, 100*PX, 30*PX, NSTextAlignment.left, UIColor.white, myColor().yellowF5d96c(), 22, Vip)
            shopView.addSubview(vipView)
        }
        
        // 商品数量
        let proNumView:QZHUILabelView = QZHUILabelView()
        proNumView.setLabelView(44*PX, 160*PX, 88*PX, 42*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 30, "\(proCount)")
        shopView.addSubview(proNumView)
        let proView:QZHUILabelView = QZHUILabelView()
        proView.setLabelView(40*PX, 217*PX, 96*PX, 30*PX, NSTextAlignment.center, UIColor.white, myColor().Gray6(), 22, "全部商品")
        shopView.addSubview(proView)
        let line1:QZHUILabelView = QZHUILabelView()
        line1.dividers(175*PX, y: 160*PX, width: 2*PX, height: 87*PX, color: myColor().grayF0())
        shopView.addSubview(line1)
        
        // 月销售量
        let saleNumView:QZHUILabelView = QZHUILabelView()
        saleNumView.setLabelView(220*PX, 160*PX, 88*PX, 42*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 30, "\(sale)")
        shopView.addSubview(saleNumView)
        let saleView:QZHUILabelView = QZHUILabelView()
        saleView.setLabelView(220*PX, 217*PX, 88*PX, 30*PX, NSTextAlignment.center, UIColor.white, myColor().Gray6(), 22, "月销量")
        shopView.addSubview(saleView)
        let line2:QZHUILabelView = QZHUILabelView()
        line2.dividers(350*PX, y: 160*PX, width: 2*PX, height: 87*PX, color: myColor().grayF0())
        shopView.addSubview(line2)
        
        // 收藏人数
        let scNumView:QZHUILabelView = QZHUILabelView()
        scNumView.setLabelView(394*PX, 160*PX, 88*PX, 42*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 30, "\(scCount)")
        shopView.addSubview(scNumView)
        let scView:QZHUILabelView = QZHUILabelView()
        scView.setLabelView(390*PX, 217*PX, 96*PX, 30*PX, NSTextAlignment.center, UIColor.white, myColor().Gray6(), 22, "收藏人数")
        shopView.addSubview(scView)
        let line3:QZHUILabelView = QZHUILabelView()
        line3.dividers(525*PX, y: 160*PX, width: 2*PX, height: 87*PX, color: myColor().grayF0())
        shopView.addSubview(line3)
        
        // 商品评价
        let proCommentView:QZHUILabelView = QZHUILabelView()
        proCommentView.setLabelView(553*PX, 166*PX, 96*PX, 30*PX, NSTextAlignment.center, UIColor.white
            , myColor().Gray6(), 22, "商品评价")
        shopView.addSubview(proCommentView)
        let _proCommentNumView:QZHUILabelView = QZHUILabelView()
        _proCommentNumView.setLabelView(675*PX, 166*PX, 40*PX, 30*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 22, "\(proComment)")
        shopView.addSubview(_proCommentNumView)
        
        // 服务评价
        let sCommentView:QZHUILabelView = QZHUILabelView()
        sCommentView.setLabelView(553*PX, 210*PX, 96*PX, 30*PX, NSTextAlignment.center, UIColor.white, myColor().Gray6(), 22, "服务评价")
        shopView.addSubview(sCommentView)
        let _sCommentNumView:QZHUILabelView = QZHUILabelView()
        _sCommentNumView.setLabelView(675*PX, 210*PX, 40*PX, 30*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 22, "\(sComment)")
        shopView.addSubview(_sCommentNumView)
        
        // 店铺分类
        let btn11:QZHUIButton = QZHUIButton()
        btn11.setupButton(180*PX, 301*PX, 160*PX, 60*PX, myColor().blue007aff(), UIColor.white, "店铺分类", 24, 1*PX, myColor().blue007aff(), "", UIControlState.normal, 0, UIViewContentMode.center)
        btn11.frame = CGRect(x:180*PX,y:301*PX,width:160*PX,height:60*PX)
        btn11.layer.cornerRadius = 8*PX
        btn11.addTarget(self, action: #selector(self.shopSort), for: .touchUpInside)
        shopView.addSubview(btn11)
        
        // 进店逛逛
        let btn22:QZHUIButton = QZHUIButton()
        btn22.setupButton(410*PX, 301*PX, 160*PX, 60*PX, myColor().blue007aff(), UIColor.white, "进店逛逛", 24, 1*PX, myColor().blue007aff(), "", UIControlState.normal, 0, UIViewContentMode.center)
        btn22.frame = CGRect(x:410*PX,y:301*PX,width:160*PX,height:60*PX)
        btn22.layer.cornerRadius = 8*PX
        btn22.addTarget(self, action: #selector(self.gotToShop), for: .touchUpInside)
        shopView.addSubview(btn22)
        
        return shopView
    }
    
    // 设置产品详情
    func setupProDetail(y:CGFloat,jsPath:String){
        proDetail.y = y
        proDetail.width = SCREEN_WIDTH
        proDetail.x = 0
       // proDetail.height =
        proDetail.backgroundColor = UIColor.white
        headerView.addSubview(proDetail)
        
        //加载网页
        
        proDetail.scrollView.showsHorizontalScrollIndicator = false
        proDetail.scrollView.showsVerticalScrollIndicator = false
        proDetail.scrollView.isScrollEnabled = false
        proDetail.loadHTMLString(jsPath, baseURL: nil)
        
         headerView.height = proDetail.y + proDetail.height
        
    }
    
    // 设置标题 UI
    func setupTitleUI(selView:QZHUIView,y:CGFloat,title:String,icon:String){
        selView.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.clear)
        headerView.addSubview(selView)
        
        let Line1:QZHUILabelView = QZHUILabelView()
        Line1.dividers(236*PX, y: 40*PX, width: 80*PX, height: 1*PX, color: myColor().gray9())
        selView.addSubview(Line1)
        
        let Line2:QZHUILabelView = QZHUILabelView()
        Line2.dividers(435*PX, y: 40*PX, width: 80*PX, height: 1*PX, color: myColor().gray9())
        selView.addSubview(Line2)
        
        let iconView:UIImageView = UIImageView(frame:CGRect(x:336*PX,y:25*PX,width:30*PX,height:30*PX))
        iconView.image = UIImage(named:icon)
        selView.addSubview(iconView)
        
        let titleView:QZHUILabelView = QZHUILabelView()
        titleView.setLabelView(370*PX, 25*PX, 46*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray9(), 22, title)
        if icon == ""{
            titleView.x = 310*PX
            titleView.width = 130*PX
        }
        
        headerView.height = y + 80*PX
        selView.addSubview(titleView)
        
    }
    
    // 设置产品参数
    func setupProCSView(){
        csView.isHidden = true
        csView.setupScrollerView(x: 0, y: 749*PX, width: SCREEN_WIDTH, height: 585*PX, background: UIColor.white)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
               csView.setupScrollerView(x: 0, y: SCREEN_HEIGHT - 653*PX, width: SCREEN_WIDTH, height: 653*PX, background: UIColor.white)
            }
            
        } else {
            // Fallback on earlier versions
        }
        csView.backgroundColor = UIColor.white
        csView.contentSize = CGSize(width:SCREEN_WIDTH,height:585*PX)
        view.addSubview(csView)
        
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(0, 0, SCREEN_WIDTH, 80*PX, NSTextAlignment.center, UIColor.white, myColor().Gray6(), 30, "产品参数")
        csView.addSubview(title)
        let icon:UIImageView = UIImageView(frame:CGRect(x:684*PX,y:20*PX,width:42*PX,height:42*PX))
        icon.image = UIImage(named:"proDetailCloseIcon")
        icon.addOnClickLister(target: self, action: #selector(self.bghidden))
        csView.addSubview(icon)
        
    }
    // 设置 产品参数项
    func setupProCS(y:CGFloat,title:String,content:String,tags:Int)->CGFloat{
        var top:CGFloat = y
        let pview:QZHUIView = QZHUIView()
        pview.tag = tags
        pview.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: 81*PX, bgColor: UIColor.white)
        csView.addSubview(pview)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(20*PX, y: 80*PX, width: 730*PX, height: 1*PX, color: myColor().grayEB())
        pview.addSubview(line)
        
        let titleView:QZHUILabelView = QZHUILabelView()
        titleView.setLabelView(20*PX, 22*PX, 150*PX, 37*PX, NSTextAlignment.left, UIColor.white, myColor().gray9(), 26, title)
        pview.addSubview(titleView)
        
        let contentView:QZHUILabelView = QZHUILabelView()
        contentView.setLabelView(240*PX, 22*PX, 490*PX, 37*PX, NSTextAlignment.left, UIColor.white, myColor().Gray6(), 26, content)
        pview.addSubview(contentView)
        
        top = top+81*PX
        return top
    }
    
    // 设置产品规格
    func setupProGGView(){
        ggView.setupScrollerView(x: 0, y: SCREEN_HEIGHT-836*PX, width: SCREEN_WIDTH, height: 836*PX, background: UIColor.clear)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                ggView.setupScrollerView(x: 0, y: SCREEN_HEIGHT-904*PX, width: SCREEN_WIDTH, height: 904*PX, background: UIColor.clear)
            }
            
        } else {
            // Fallback on earlier versions
        }
        let ggView1:QZHUIView = QZHUIView()
        ggView1.setupViews(x: 0, y: 29*PX, width: SCREEN_WIDTH, height: 807*PX, bgColor: UIColor.white)
        ggView.addSubview(ggView1)
        ggView.isHidden = true
        view.addSubview(ggView)
        
        // 设置规格图像
        ggIcon.frame = CGRect(x:20*PX,y:0*PX,width:200*PX,height:200*PX)
        ggIcon.image = UIImage(named:"loadPic")
        ggIcon.layer.borderColor = myColor().grayF0().cgColor
        ggIcon.layer.borderWidth = 1*PX
        ggIcon.layer.cornerRadius = 6*PX
        ggIcon.clipsToBounds = true
        ggView.addSubview(ggIcon)
        
        // 关闭按钮
        let closeBtn:UIImageView = UIImageView(frame:CGRect(x:684*PX,y:24*PX,width:42*PX,height:42*PX))
        closeBtn.image = UIImage(named:"proDetailCloseIcon")
        closeBtn.addOnClickLister(target: self, action: #selector(self.bghidden))
        ggView1.addSubview(closeBtn)
        
        // 设置价格
        ggPrice.setLabelView(250*PX, 30*PX, 400*PX, 42*PX, NSTextAlignment.left, UIColor.white, myColor().redFf4300(), 30, "¥ 0.0")
        ggView1.addSubview(ggPrice)
        
        // 设置库存
        ggKC.setLabelView(250*PX, 82*PX, 430*PX, 37*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 26, "库存0件")
        ggView1.addSubview(ggKC)
        
        // 设置所选规格
        ggGG.setLabelView(250*PX, 129*PX, 430*PX, 37*PX, NSTextAlignment.left,  UIColor.white, myColor().gray3(), 26, "请选择 规格")
        ggView1.addSubview(ggGG)
        
        let line1:QZHUILabelView = QZHUILabelView()
        line1.dividers(20*PX, y: 200*PX, width: 710*PX, height: 1*PX, color: myColor().grayEB())
        ggView1.addSubview(line1)
        
        // 所有规格内容
        ggContent.setupScrollerView(x: 0, y: 201*PX, width: SCREEN_WIDTH, height: 374*PX, background: UIColor.white)
        ggView1.addSubview(ggContent)
        
        let line2:QZHUILabelView = QZHUILabelView()
        line2.dividers(20*PX, y: 576*PX, width: 710*PX, height: 1*PX, color: myColor().grayEB())
        ggView1.addSubview(line2)
        
        
        // 购买数量设置
        let numTitle:QZHUILabelView = QZHUILabelView()
        numTitle.setLabelView(20*PX, 613*PX, 150*PX, 37*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 26, "购买数量")
        ggView1.addSubview(numTitle)
        
        let redBtn:UIButton = UIButton(frame:CGRect(x:480*PX,y:596*PX,width:70*PX,height:70*PX))
        redBtn.setImage(UIImage(named:"reductionIcon"), for: .normal)
        redBtn.addTarget(self, action: #selector(self.NumRec), for: .touchUpInside)
        redBtn.layer.borderColor = myColor().gray9().cgColor
        redBtn.layer.borderWidth = 1*PX
        ggView1.addSubview(redBtn)
        
        buyNum.frame = CGRect(x:555*PX,y:596*PX,width:90*PX,height:70*PX)
        //buyNum.setLabelView(555*PX, 596*PX, 90*PX, 70*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 30, "1")
        buyNum.textAlignment = .center
        buyNum.backgroundColor = UIColor.white
        buyNum.textColor = myColor().gray3()
        buyNum.font = UIFont.systemFont(ofSize: 30*PX)
        buyNum.text = "1.0"
        buyNum.keyboardType = .numberPad
        buyNum.layer.borderColor = myColor().gray9().cgColor
        buyNum.layer.borderWidth = 1*PX
        ggView1.addSubview(buyNum)
        
        let addNUmBtn:UIButton = UIButton(frame:CGRect(x:650*PX,y:596*PX,width:70*PX,height:70*PX))
        addNUmBtn.setImage(UIImage(named:"addICon"), for: .normal)
        addNUmBtn.addTarget(self, action: #selector(self.NumAdd), for: .touchUpInside)
        addNUmBtn.layer.borderColor = myColor().gray9().cgColor
        addNUmBtn.layer.borderWidth = 1*PX
        ggView1.addSubview(addNUmBtn)
        
        let line3:QZHUILabelView = QZHUILabelView()
        line3.dividers(20*PX, y: 686*PX, width: 710*PX, height: 1*PX, color: myColor().grayEB())
        ggView1.addSubview(line3)
        
        
        btn1.setupViews(x: 0, y: 707*PX, width: SCREEN_WIDTH, height: 100*PX, bgColor: UIColor.clear)
        
        // 加入购物车
        let addBtn:QZHUIButton = QZHUIButton()
        addBtn.setupButton(0*PX, 0, 375*PX, 100*PX, UIColor.white, myColor().blue00b9ff(), "加入购物车", 32, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        addBtn.frame = CGRect(x:0*PX, y:0, width:375*PX, height:100*PX)
        addBtn.addTarget(self, action: #selector(self.addToCar), for: UIControlEvents.touchUpInside)
        btn1.addSubview(addBtn)
        
        // 立即购买
        let buyBtn:QZHUIButton = QZHUIButton()
        buyBtn.setupButton(375*PX, 0, 375*PX, 100*PX, UIColor.white, myColor().blue007aff(), "立即购买", 32, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        buyBtn.frame = CGRect(x:375*PX, y:0, width:375*PX, height:100*PX)
        buyBtn.addTarget(self, action: #selector(self.buyNow), for: UIControlEvents.touchUpInside)
        btn1.addSubview(buyBtn)
        ggView1.addSubview(btn1)
        
        btn2.setLabelView(0, 707*PX, SCREEN_WIDTH, 100*PX, NSTextAlignment.center, myColor().blue00b9ff(), UIColor.white, 32, "加入购物车")
        btn2.addOnClickLister(target: self, action: #selector(self.addToCar))
        btn2.isHidden = true
        ggView1.addSubview(btn2)
        
        btn3.setLabelView(0, 707*PX, SCREEN_WIDTH, 100*PX, NSTextAlignment.center, myColor().blue00b9ff(), UIColor.white, 32, "立即购买")
        btn3.addOnClickLister(target: self, action: #selector(self.buyNow))
        btn3.isHidden = true
        ggView1.addSubview(btn3)
        
        
        
    
    }
    
    // 设置规格项
    func setupCommentList(y:CGFloat,title:String,commentArray:[[String:AnyObject]],_ tag:Int)->CGFloat{
        var top_Y = y
        let commentView:QZHUIView = QZHUIView()
        commentView.setupViews(x: 20*PX, y: y, width: 710*PX, height: 57*PX, bgColor: UIColor.clear)
        commentView.tag = tag
        commentView.restorationIdentifier = "commentView"
        ggContent.addSubview(commentView)
        
        let titleView:QZHUILabelView = QZHUILabelView()
        titleView.setLabelView(0, 20*PX, 710*PX, 37*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 26, title)
        titleView.tag = 3
        commentView.addSubview(titleView)
        top_Y = top_Y + 77*PX
        
        var left:CGFloat = 0
        var marginTop:CGFloat = 77*PX
        for i in 0..<commentArray.count{
            let listBtn:QZHUILabelView = QZHUILabelView()
            let widthBtn = listBtn.autoLabelWidth(commentArray[i]["option"] as! String, font: 26, height: 60*PX)
            let leftCount = left + widthBtn + 80*PX
            if leftCount > 710*PX{
                left = 0
                top_Y = top_Y + 80*PX
                marginTop = marginTop + 80*PX
            }
            listBtn.setLabelView(left, marginTop, widthBtn+60*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, commentArray[i]["option"] as! String)
            listBtn.layer.borderWidth = 1*PX
            listBtn.layer.borderColor = myColor().gray9().cgColor
            listBtn.layer.cornerRadius = 8*PX
            listBtn.layer.masksToBounds = true
            listBtn.restorationIdentifier = "\(commentArray[i]["productIds"] as! String)&&&\(commentArray[i]["optionId"]!)"
            listBtn.isUserInteractionEnabled = true
            listBtn.addOnClickLister(target: self, action: #selector(self.checkComment1(_:)))
            commentView.addSubview(listBtn)
           left = left + widthBtn + 80*PX
        }
        
        top_Y = top_Y + 80*PX
        commentView.height = marginTop + 80*PX
        
        ggContent.contentSize = CGSize(width:ggContent.width,height:top_Y)
        return top_Y
    }
    

    // 设置底部样式
    func setupFooter(){
        let footView:QZHUIView = QZHUIView()
        footView.setupViews(x: 0, y: SCREEN_HEIGHT-100*PX, width: SCREEN_WIDTH, height: 100*PX, bgColor: UIColor.white)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                footView.setupViews(x: 0, y: SCREEN_HEIGHT-168*PX, width: SCREEN_WIDTH, height: 100*PX, bgColor: UIColor.white)
            }
            
        } else {
            // Fallback on earlier versions
        }
        
        // 设置店铺按钮
        footer_Shop.setupButton(4*PX, 15*PX, 103*PX, 70*PX, myColor().gray8a(), UIColor.clear, "店铺", 20, 0, UIColor.clear, "proDetailShopICon", UIControlState.normal, 18*PX, UIViewContentMode.bottom)
        footer_Shop.frame = CGRect(x:4*PX,y:0, width:103*PX, height:70*PX)
        footer_Shop.addTarget(self, action: #selector(self.gotToShop), for: .touchUpInside)
        footView.addSubview(footer_Shop)
        
        // 设置客服按钮
        footer_Customer.setupButton(111*PX, 15*PX, 108*PX, 70*PX, myColor().gray8a(), UIColor.clear, "客服", 20, 0, UIColor.clear, "proDetailCustomer", UIControlState.normal, 18*PX, UIViewContentMode.bottom)
        footer_Customer.frame = CGRect(x:111*PX,y:0, width:108*PX, height:70*PX)
        footer_Customer.addTarget(self, action: #selector(self.goToCustomer), for: .touchUpInside)
        footView.addSubview(footer_Customer)
        
        // 设置收藏按钮
        footer_Collection.setupButton(221*PX, 15*PX, 108*PX, 70*PX, myColor().gray8a(), UIColor.clear, "收藏", 20, 0, UIColor.clear, "star2", UIControlState.normal, 18*PX, UIViewContentMode.bottom)
        footer_Collection.frame = CGRect(x:221*PX,y:0, width:108*PX, height:70*PX)
        footer_Collection.addTarget(self, action: #selector(self.collection), for: .touchUpInside)
        footView.addSubview(footer_Collection)
        
        footer_Collection1.setupButton(221*PX, 15*PX, 108*PX, 70*PX, myColor().gray8a(), UIColor.clear, "已收藏", 20, 0, UIColor.clear, "star", UIControlState.normal, 18*PX, UIViewContentMode.bottom)
        footer_Collection1.frame = CGRect(x:221*PX,y:0, width:108*PX, height:70*PX)
        footer_Collection1.addTarget(self, action: #selector(self.collection1), for: .touchUpInside)
        footer_Collection1.isHidden = true
        footView.addSubview(footer_Collection1)
        
        // 设置立即购买
        footer_BuyNow.setLabelView(540*PX, 0, 210*PX, 100*PX, NSTextAlignment.center, myColor().blue007aff(), UIColor.white, 28, "立即购买")
        footer_BuyNow.restorationIdentifier = "buy"
        footer_BuyNow.addOnClickLister(target: self, action: #selector(self.openProSpace))
        footView.addSubview(footer_BuyNow)
        
        // 设置加入购物车
        footer_AddCar.setLabelView(330*PX, 0, 210*PX, 100*PX, NSTextAlignment.center, myColor().blue00b9ff(), UIColor.white, 28, "加入购物车")
        footer_AddCar.frame = CGRect(x:330*PX,y:0, width:210*PX, height:100*PX)
        footer_AddCar.addOnClickLister(target: self, action: #selector(self.openProSpace))
        footer_AddCar.restorationIdentifier = "car"
        footView.addSubview(footer_AddCar)
        
        self.view.addSubview(footView)
    }
}

// MARK: - 设置 UIWebViewDelegate 代理方法
extension QZHProductDetailViewController{
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if let doubleValue = Double(webView.stringByEvaluatingJavaScript(from: "document.body.offsetHeight")!)
        {
            webView.height = CGFloat(doubleValue)*PX
        }else{
            webView.height = 400*PX
        
        }
        // 推荐标题
        self.setupTitleUI(selView: pullTitle, y: proDetail.y+proDetail.height, title: "推荐", icon: "proDeatailPullIcon")
        tabbelView?.tableHeaderView = headerView
    }
    
    func webViewDidStartLoad(webView: UIWebView){
        webView.allowsInlineMediaPlayback = true
        webView.mediaPlaybackRequiresUserAction = true
    }
    func webViewDidFinishLoad(webView: UIWebView){
        //只有声音没有视频
        
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('video')[0].setAttribute('webkit-playsinline','webkit-playsinline');")
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('video')[0].setAttribute('controls','controls');")
    }
}

// MARK: - 设置 tableView 数据源方法
extension QZHProductDetailViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = productDetailStatus.proRecommendStatus.count/2
        if productDetailStatus.proRecommendStatus.count % 2 > 0{
            count = count+1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 501*PX
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80*PX
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let foot:QZHUIView = QZHUIView()
        foot.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.clear)
        let Line1:QZHUILabelView = QZHUILabelView()
        Line1.dividers(236*PX, y: 40*PX, width: 80*PX, height: 1*PX, color: myColor().gray9())
        foot.addSubview(Line1)
        
        let Line2:QZHUILabelView = QZHUILabelView()
        Line2.dividers(435*PX, y: 40*PX, width: 80*PX, height: 1*PX, color: myColor().gray9())
        foot.addSubview(Line2)
        
        let titleView:QZHUILabelView = QZHUILabelView()
        titleView.setLabelView(310*PX, 25*PX, 130*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().gray9(), 22, "已经到底了")
        foot.addSubview(titleView)

        return foot
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHProductDetailCell
        cell.backgroundColor = UIColor.clear
                cell.backgroundColor = UIColor.white
                let _index = indexPath.row*2
                cell.proName1.text = self.productDetailStatus.proRecommendStatus[_index].status.goodsName
                cell.price1.text = "\(self.productDetailStatus.proRecommendStatus[_index].status.fixedPrice)"
                cell.price1.width = cell.price1.autoLabelWidth(cell.price1.text!, font: 32, height: 40*PX)
                cell.unit1.text = "\(self.productDetailStatus.proRecommendStatus[_index].status.unit)"
                cell.sale1.text = "已售\(self.productDetailStatus.proRecommendStatus[_index].status.salesVolume)"
                if self.productDetailStatus.proRecommendStatus[_index].status.unit != ""{
                    cell.unit1.text = "/\(self.productDetailStatus.proRecommendStatus[_index].status.unit)"
                    cell.unit1.x = cell.price1.x + cell.price1.width + 3*PX
                }
                let _pic1:[String:AnyObject] = self.productDetailStatus.proRecommendStatus[_index].status.pic
                if _pic1 != nil || !_pic1.isEmpty{
                    let _pics1 = (_pic1["picturePath"] as!String).components(separatedBy: ",")
                    if _pics1.count != 0{
                        if let url = URL(string: _pics1[0] as! String) {
                            cell.img1.downloadedFrom(url: url)
                        }else{
                            cell.img1.image = UIImage(named:"noPic")
                        }
                    }else{
                    cell.img1.image = UIImage(named:"noPic")
                    }
                }else{
                    cell.img1.image = UIImage(named:"noPic")
                }
                cell.pro1.tag = Int(self.productDetailStatus.proRecommendStatus[_index].status.id)
                cell.pro1.addOnClickLister(target: self, action: #selector(self.goToProDetail(_:)))
                
                if self.productDetailStatus.proRecommendStatus.count > _index+1{
                    cell.proName2.text = self.productDetailStatus.proRecommendStatus[_index+1].status.goodsName
                    cell.price2.text = "\(self.productDetailStatus.proRecommendStatus[_index+1].status.fixedPrice)"
                    cell.price2.width = cell.price2.autoLabelWidth(cell.price2.text!, font: 28, height: 40*PX)
                    cell.sale2.text = "已售\(self.productDetailStatus.proRecommendStatus[_index+1].status.salesVolume)"
                    if self.productDetailStatus.proRecommendStatus[_index+1].status.unit != ""{
                        cell.unit2.text = "/\(self.productDetailStatus.proRecommendStatus[_index+1].status.unit)"
                        cell.unit2.x = cell.price2.x + cell.price2.width + 3*PX
                        
                    }
                    let _pic2:[String:AnyObject] = self.productDetailStatus.proRecommendStatus[_index+1].status.pic
                    if _pic2 != nil || !_pic2.isEmpty{
                        let _pics2 = (_pic2["picturePath"] as!String).components(separatedBy: ",")
                        if _pics2.count != 0{
                            if let url = URL(string: _pics2[0] as! String) {
                                cell.img2.downloadedFrom(url: url)
                            }else{
                                cell.img2.image = UIImage(named:"noPic")
                            }
                        }else{
                            cell.img2.image = UIImage(named:"noPic")
                        }
                    }else{
                        cell.img2.image = UIImage(named:"noPic")
                    }
                    cell.pro2.tag = Int(self.productDetailStatus.proRecommendStatus[_index+1].status.id)
                    cell.pro2.addOnClickLister(target: self, action: #selector(self.goToProDetail(_:)))
                }
        return cell
    }
    
    /// 捕捉滚动条动作
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 1{

        }
        
        if scrollView.contentOffset.y >= SCREEN_WIDTH-127*PX{
             UIApplication.shared.statusBarview?.backgroundColor = UIColor.white
             self.navigationBar.isHidden = false
             topView.isHidden = true
            tabView.isHidden = false
            self.setupTabViewUI(tabView.viewWithTag(5) as! QZHUILabelView)
            if scrollView.contentOffset.y >= commentView.y-288*PX{
                self.setupTabViewUI(tabView.viewWithTag(2) as! QZHUILabelView)
                if scrollView.contentOffset.y >= proDetail.y-288*PX{
                    self.setupTabViewUI(tabView.viewWithTag(3) as! QZHUILabelView)
                    if scrollView.contentOffset.y >= proDetail.y+proDetail.height-208*PX{
                        self.setupTabViewUI(tabView.viewWithTag(4) as! QZHUILabelView)
                    }
                }
            }
        }else{
            UIApplication.shared.statusBarview?.backgroundColor = UIColor.clear
            self.navigationBar.isHidden = true
            topView.isHidden = false
            tabView.isHidden = true
            self.setupTabViewUI(tabView.viewWithTag(1) as! QZHUILabelView)
        }
        
        scrollView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: -80*PX, right: 0)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}

// MARK: - 产品详情页 方法监听
extension QZHProductDetailViewController{
    // 选项卡监听方法
    func tabViewAction(_ sender:UITapGestureRecognizer){
        let thisView:QZHUILabelView = sender.view as! QZHUILabelView
        self.setupTabViewUI(thisView)
        var offset = CGPoint(x:0, y:0)
        if thisView.text == "宝贝"{
            offset = CGPoint(x:0, y:0)
        }else if thisView.text == "评价"{
            offset = CGPoint(x:0, y:commentView.y-288*PX)
        }else if thisView.text == "详情"{
            offset = CGPoint(x:0, y:proDetail.y-288*PX)
        }else if thisView.text == "推荐"{
            offset = CGPoint(x:0, y:proDetail.y+proDetail.height-208*PX)
        }
        tabbelView!.setContentOffset(offset, animated: true)
    }
    
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    // 搜索
    func gotoCar(){
        let nav = QZH_CYSQMainViewController()
        nav.selectedIndex = 3
        present(nav, animated: true, completion: nil)
    }
    
    // 返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 进入店铺
    func gotToShop(){
        let vc = QZHStoreIndexViewController()
         present(vc, animated: true, completion: nil)
    }
    
    // 店铺分类
    func shopSort(){
        let vc = QZHStoreSortViewController()
        present(vc, animated: true, completion: nil)
    }
    
    // 客服
    func goToCustomer(){
    
    }
    
    // 操作结果图层消失
    func resultViewXS(){
        resultView.isHidden = true
        resultView.subviews.map{ $0.removeFromSuperview()}
    }
    
    // 收藏
    func collection(){
        QZHCollectListPorModel.goodsId = QZHProductDetailModel.goodsId
        self.collectStatus.addCollect { (isSuccess, msg) in
            self.resultView.opertionSuccess(msg, isSuccess)
            self.footer_Collection.isHidden = true
            self.footer_Collection1.isHidden = false
            self.view.addSubview(self.resultView)
            self.resultView.isHidden = false
            self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
            
        }
    }
    func collection1(){
        QZHCollectListPorModel.goodsId = QZHProductDetailModel.goodsId
        self.collectStatus.delsCollect { (isSuccess, msg) in
            self.resultView.opertionSuccess(msg, isSuccess)
            self.view.addSubview(self.resultView)
            self.footer_Collection.isHidden = false
            self.footer_Collection1.isHidden = true
            self.resultView.isHidden = false
            self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
        }
    }
    
    // 加入购物车
    func addToCar(){
        if Double.init(self.buyNum.text!)! > self.NowKC{
            UIAlertController.showAlert(message: "你所选的规格库存不足，不能加入购物车！！！", in: self)
        }else{
            if proIdArray.components(separatedBy: ",").count == 1 && proIdArray != "" && specIdStr.components(separatedBy: ",").count == self.specCount {
                QZHProductDetailModel.productId = Int64.init(proIdArray)!
                QZHProductDetailModel.specOptionId = specIdStr
                QZHProductDetailModel.specOptionName = specNameStr
                QZHProductDetailModel.proCount = Double.init(self.buyNum.text!)!
                QZHProductDetailModel.sellMemberId = Int(QZHProductDetailModel.memberId)
                self.productDetailStatus.addToCar { (isSuccess, result) in
                    self.tabbelView?.reloadData()
                    self.bghidden()
                    //UIAlertController.showAlert(message: result, in: self)
                    self.resultView.opertionSuccess(result, isSuccess)
                    self.view.addSubview(self.resultView)
                    self.resultView.isHidden = false
                    self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
                    
                }
            }else if specIdStr.components(separatedBy: ",").count != self.specCount {
                //UIAlertController.showAlert(message: "请选择完整的规格", in: self)
                self.resultView.opertionSuccess("请选择完整的规格", false)
                self.view.addSubview(self.resultView)
                self.resultView.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
            } else if proIdArray == ""{
                //UIAlertController.showAlert(message: "您还未选择规格，请先选择规格", in: self)
                self.resultView.opertionSuccess("您还未选择规格，请先选择规格", false)
                self.view.addSubview(self.resultView)
                self.resultView.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
            }else if proIdArray.components(separatedBy: ",").count > 1 {
                
                //UIAlertController.showAlert(message: "您所选的规格暂无产品，请重新先选择规格", in: self)
                self.resultView.opertionSuccess("您所选的规格暂无产品，请重新先选择规格", false)
                self.view.addSubview(self.resultView)
                self.resultView.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
            }
        }
    }
    
    // 立即购买
    func buyNow(){
        if Double.init(self.buyNum.text!)! > self.NowKC{
            UIAlertController.showAlert(message: "你所选的规格库存不足，不能购买！！！", in: self)
        }else{
            if proIdArray.components(separatedBy: ",").count == 1 && proIdArray != "" && specIdStr.components(separatedBy: ",").count == self.specCount {
                QZH_CYSQCarSettlementModel.ShoppingFlag = 1
                
                QZH_CYSQCarSettlementModel.productId = Int.init(proIdArray)!
                QZH_CYSQCarSettlementModel.specOptionName = specNameStr
                QZH_CYSQCarSettlementModel.proCount = Double.init(self.buyNum.text!)!
                QZH_CYSQCarSettlementModel.type = 1
                QZH_CYSQCarSettlementModel.ids = ""
                self.bghidden()
                let nav = QZH_CYSQCarSettlementViewController()
                present(nav, animated: true, completion: nil)
            }else if specIdStr.components(separatedBy: ",").count != self.specCount {
                self.resultView.opertionSuccess("请选择完整的规格", false)
                self.view.addSubview(self.resultView)
                self.resultView.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
            } else if proIdArray == ""{
                self.resultView.opertionSuccess("您还未选择规格，请先选择规格", false)
                self.view.addSubview(self.resultView)
                self.resultView.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
            }else if proIdArray.components(separatedBy: ",").count > 1 {
                
                self.resultView.opertionSuccess("您所选的规格暂无产品，请重新先选择规格", false)
                self.view.addSubview(self.resultView)
                self.resultView.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
            }
        }
    }
    
    // 分享
    func share(){
        
    }
    
     // 产品参数
    func openProAttr(){
        blackBG.isHidden = false
        csView.isHidden = false
    }
    
    // 产品规格
    func openProSpace(_ sender:UITapGestureRecognizer){
        let this = sender.view
        if this?.restorationIdentifier == "buy"{
            btn1.isHidden = true
            btn2.isHidden = true
            btn3.isHidden = false
        }else if this?.restorationIdentifier == "car"{
            
            btn1.isHidden = true
            btn2.isHidden = false
            btn3.isHidden = true
            
        }else{
            btn1.isHidden = false
            btn2.isHidden = true
            btn3.isHidden = true
        
        }
        blackBG.isHidden = false
        ggView.isHidden = false
    }
    
    // 查看所有评价
    func checkEvaluation(){
        QZHCommentModel.goodsId = QZHProductDetailModel.goodsId
        QZHCommentModel.status = ""
        let nav = QZHProEvaluationViewController()
        self.present(nav, animated: true, completion: nil)
    }
    
    // 产品详情
    func goToProDetail(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHProductDetailModel.goodsId = (this?.tag)!
        
        let nav = QZHProductDetailViewController()
        present(nav, animated: true, completion: nil)
        
    }
    
    // 隐藏遮罩层
    func bghidden(){
        blackBG.isHidden = true
        csView.isHidden = true
        ggView.isHidden = true
    }
    
    // 增加
    func NumAdd(){
        var num:Double = Double.init(buyNum.text!)!
        
        if num != KCNum {
            num = num + 1
            buyNum.text = "\(num)"
        }
    }
    
    // 减少
    func NumRec(){
        var num:Double = Double.init(buyNum.text!)!
        if num > 1{
            num = num - 1
            buyNum.text = "\(num)"
        }
    }
    
    func checkComment1(_ sender:UITapGestureRecognizer){
        let _this:QZHUILabelView = sender.view as! QZHUILabelView
        
        setlistBtn_Blue(_this)
        if proIdArray.components(separatedBy: ",").count != 1 || proIdArray == ""{
        }else{
            let proID:String! = String.init(proIdArray)
            QZHProductDetailModel.productId = Int64.init(proID!)!
            self.getProductPrice(proID: Int64.init(QZHProductDetailModel.productId))
        }
    }
    func setlistBtn_Blue(_ _this:QZHUILabelView){
        let parent = _this.superview
        setupSelSpec(_this)
        setDefaultBtn((parent?.tag)!)
        let selBtnView:[UIView] = ggContent.subviews
        specIdStr = ""
        proIdArray = ""
        specNameStr = ""
        for views in selBtnView{
            let children:[QZHUILabelView] = views.subviews as! [QZHUILabelView]
            for child in children{
                if child.tag == 2{
                    if specNameStr != ""{
                        specNameStr = "\(specNameStr),"
                        specIdStr = "\(specIdStr),"
                    }
                    if proIdArray == ""{
                        proIdArray = "\(child.restorationIdentifier?.components(separatedBy: "&&&")[0] as! String)"
                    }
                    specNameStr = "\(specNameStr)\(child.text as! String)"
                    specIdStr = "\(specIdStr)\(child.restorationIdentifier?.components(separatedBy: "&&&")[1] as! String)"
                    var idstr:String! = ""
                    let thisProId:String = "\(child.restorationIdentifier?.components(separatedBy: "&&&")[0] as! String)"
                    for i in 0..<proIdArray.components(separatedBy: ",").count{
                        for j in 0..<thisProId.components(separatedBy: ",").count{
                            if proIdArray.components(separatedBy: ",")[i] == thisProId.components(separatedBy: ",")[j]{
                                if idstr != ""{
                                    idstr = idstr + ","
                                }
                                idstr = idstr + thisProId.components(separatedBy: ",")[j]
                            }
                        }
                    }
                    proIdArray = idstr as! String
                }
            }
            
            if views.tag == parent?.tag{
                break
            }
        }
        self.ggGG.text = "已选：\(specNameStr)"
        
        setBtnGray(proIdArray,(parent?.tag)!)
    }
    
    // 设置已规格样式
    func setupSelSpec(_ sender: QZHUILabelView){
        let parent:QZHUIView = sender.superview as! QZHUIView
        let children:[QZHUILabelView] = parent.subviews as![QZHUILabelView]
        for child in children{
            if child.tag != 3{
                if child.tag == 2{
                    child.textColor = myColor().gray3()
                    child.layer.borderColor = myColor().gray9().cgColor
                    child.tag = 1
                }
            }
        }
        sender.textColor = myColor().blue1a87ff()
        sender.layer.borderColor = myColor().blue007aff().cgColor
        sender.tag = 2
    }
    // 设置按钮常规
    func setDefaultBtn(_ thisTag:Int){
        let viewArray:[UIView] = ggContent.subviews as! [UIView]
        for i in 0..<viewArray.count{
            
        }
        for Views in viewArray{
            if Views.tag > thisTag{
                let children:[QZHUILabelView] = Views.subviews as! [QZHUILabelView]
                for child in children{
                    if child.tag != 3{
                        child.textColor = myColor().gray3()
                        child.layer.borderColor = myColor().gray9().cgColor
                        child.backgroundColor = UIColor.white
                        child.tag = 1
                        child.addOnClickLister(target: self, action: #selector(self.checkComment1(_:)))
                    }
                }
            }
        }

    }
    
    // 设置规格摁钮变为灰色
    func setBtnGray(_ proID:String,_ thisTag:Int){
        let viewArray:[UIView] = ggContent.subviews as! [UIView]
        for i in 0..<viewArray.count{
            
        }
        for Views in viewArray{
            if Views.tag != thisTag && Views.restorationIdentifier == "commentView"{
                let children:[QZHUILabelView] = Views.subviews as! [QZHUILabelView]
                for child in children{
                    if child.tag != 3{
                        let thisId = "\(child.restorationIdentifier?.components(separatedBy: "&&&")[0] as! String)"
                        var count = 0
                        for i in 0..<proID.components(separatedBy: ",").count{
                            for j in 0..<thisId.components(separatedBy: ",").count{
                                if proID.components(separatedBy: ",")[i] == thisId.components(separatedBy: ",")[j]{
                                    count = 1
                                }
                            }
                        }
                        if count == 0 && Views.tag > thisTag{
                            child.textColor = myColor().grayEB()
                            child.backgroundColor = myColor().grayF0()
                            child.layer.borderColor = myColor().grayE().cgColor
                            child.addOnClickLister(target: self, action: #selector(self.checkComment))
                        }
                    }
                }
            }
        }
    }
    func checkComment(){}
}
