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

class QZHProductDetailViewController: QZHBaseViewController {
    
    // 透明导航
    var topView:QZHUIView = QZHUIView()
    
    lazy var productDetailStatus = QZHProductDetailViewModel()
    
    // 店铺按钮 - 底部
    var footer_Shop:QZHUIButton = QZHUIButton()
    
    // 客服 - 底部
    var footer_Customer:QZHUIButton = QZHUIButton()
    
    // 收藏 - 底部
    var footer_Collection:QZHUIButton = QZHUIButton()
    
    // 加入购物车 - 底部
    var footer_AddCar:QZHUIButton = QZHUIButton()
    
    // 立即购买 - 底部
    var footer_BuyNow:QZHUIButton = QZHUIButton()
    
    // 头部显示产品图片
    var proPic:UIImageView = UIImageView()
    
    
    // 产品名称
    var proName:QZHUILabelView = QZHUILabelView()
    
    // 销售价格
    var pricIcon:QZHUILabelView = QZHUILabelView()
    var priceLabel:QZHUILabelView = QZHUILabelView()
    
    // 原价格
    var delPriceLabel:QZHUILabelView = QZHUILabelView()
    
    // 评价显示
    var commentView:QZHUIView = QZHUIView()
    
    // 店铺显示
    var shopView:QZHUIView = QZHUIView()
    
    // 头部轮播组
    var topSroller:QZHUIScrollView = QZHUIScrollView()
    
    
    override func loadData() {
        getGoodsDetail()
    }
    
    // 获取产品详情
    func getGoodsDetail(){
        productDetailStatus.getProductGoodsDetail { (result,pic, isSuccess) in
            if isSuccess{
                QZHProductDetailModel.productId = result[0].status.id
                QZHProductDetailModel.memberId = result[0].status.eipMemberId
                self.proName.text = result[0].status.goodsName
                self.setupPriceLabel(price: result[0].status.fixedPrice.roundTo(places: 2))
                self.setupDelPriceLabel(price:  result[0].status.fixedPrice.roundTo(places: 2))
                self.getProductPrice()
            }
        }
    }
    
    // 获取产品价格
    func getProductPrice(){
        productDetailStatus.getProductPrice { (result, isSuccess) in
            if isSuccess{
                
            }
        }
    }

}

// MARK: - 产品详情页面 UI 设置
extension QZHProductDetailViewController{
    override func setupUI() {
        super.setupUI()
        tabbelView?.backgroundColor = myColor().grayF0()
        
        // 注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tabbelView?.height = SCREEN_HEIGHT - 100*PX
        
        // 设置导航栏按钮
        self.navigationBar.isHidden = true
        
        setupNav1()
        setupNav()
        setupTopScroll()
        setupMain()
        setupFooter()

    }
    
    // 设置头部轮播
    func setupTopScroll(){
        topSroller.setupScrollerView(x: 0, y: 0, width: 750*PX, height: 750*PX, background: UIColor.red)
        
        topSroller.contentSize = CGSize(width:SCREEN_WIDTH,height:SCREEN_WIDTH)
        
        let bg:UIImageView = UIImageView(frame:CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_WIDTH))
        bg.image = UIImage(named:"loadPic")
        topSroller.addSubview(bg)
        tabbelView?.addSubview(topSroller)
        
    
    }
    
    
    // 设置头部导航
    func setupNav(){
        proPic.frame = CGRect(x:335*PX,y:4*PX,width:80*PX,height:80*PX)
        proPic.image = UIImage(named:"loadPic")
        navItem.titleView = proPic
        //navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIcon", target: self, action: #selector(showFriends),color:UIColor.white)
        navItem.rightBarButtonItems = [UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends),color:UIColor.white),UIBarButtonItem(title: "", img: "searchIcon4", target: self, action: #selector(gotoSeach),color:UIColor.white)]
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon2", target: self, action: #selector(self.close),color:UIColor.white)
        navigationBar.tintColor = UIColor.white

    }
    
    // 设置头部透明导航
    func setupNav1(){
        topView.setupViews(x: 0, y: 54*PX, width: SCREEN_WIDTH, height: 60*PX, bgColor: UIColor.clear)
        
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
        search_Img.image = UIImage(named:"searchIcon1")
        search.addSubview(search_Img)
        search.addOnClickLister(target: self, action: #selector(self.gotoSeach))
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
    
    
    // 设置主体部分
    func setupMain(){
        // 名称 价格 分享
        let view1:QZHUIView = QZHUIView()
        view1.setupViews(x: 0, y: topSroller.height, width: SCREEN_WIDTH, height: 183*PX, bgColor: UIColor.white)
        tabbelView?.addSubview(view1)
        
        proName.setLabelView(20*PX, 10*PX, 610*PX, 84*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3()
            , 30, "")
        proName.numberOfLines = 2
        proName.lineBreakMode = .byWordWrapping
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
        tabbelView?.addSubview(View2)
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
        setupComment(y:EvaluationTitle.y+EvaluationTitle.height,count:0,photo:"",userName:"",date:"",star:0,content:"")
        
        // 店铺
        setupShopView(y: commentView.y+commentView.height+10*PX, photo: "loadPic", shopName: "", Vip: 0, proCount: 0, sale: 0, scCount: 0, proComment: 0.0, sComment: 0.0)
        
        // 详情标题
        let DetailTitle:QZHUIView = QZHUIView()
        self.setupTitleUI(selView: DetailTitle, y: shopView.y+shopView.height, title: "评价", icon: "proEvaluationIcon")
        
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
        
    }
    
    // 设置评价
    func setupComment(y:CGFloat,count:Int,photo:String,userName:String,date:String,star:Int,content:String){
        commentView.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: 344*PX, bgColor: UIColor.white)
        tabbelView?.addSubview(commentView)
        if count == 0{
            let noView:QZHUILabelView = QZHUILabelView()
            noView.setLabelView(0, 0, SCREEN_WIDTH, 344*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 34, "暂无评论")
            commentView.addSubview(noView)
        }else{
            // 用户图像
            let photoView:UIImageView = UIImageView(frame:CGRect(x:20*PX,y:20*PX,width:60*PX,height:60*PX))
            photoView.image = UIImage(named:photo)
            commentView.addSubview(photoView)
            
            let userView:QZHUILabelView = QZHUILabelView()
            userView.setLabelView(100*PX, 30*PX, userView.autoLabelWidth(userName, font: 28, height: 40*PX), 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, userName)
            commentView.addSubview(userView)
            
            for i in 0..<5{
                let starView:UIImageView = UIImageView(frame:CGRect(x:550*PX+10*PX*CGFloat(i),y:36*PX,width:28*PX,height:28*PX))
                if i >= star{
                    starView.image = UIImage(named:"star")
                }else{
                    starView.image = UIImage(named:"star1")
                }
                commentView.addSubview(starView)
            }
            
            let dateView:QZHUILabelView = QZHUILabelView()
            dateView.setLabelView(20*PX, 90*PX, 220*PX, 28*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 20, "购买日期：\(date)")
            commentView.addSubview(dateView)
            
            let contentView:QZHUILabelView = QZHUILabelView()
            contentView.setLabelView(20*PX, 138*PX, 696*PX, 70*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, content)
            contentView.numberOfLines = 2
            contentView.lineBreakMode = .byWordWrapping
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
    func setupShopView(y:CGFloat,photo:String,shopName:String,Vip:Int,proCount:Int,sale:Int,scCount:Int,proComment:CGFloat,sComment:CGFloat){
        shopView.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: 400*PX, bgColor: UIColor.white)
        tabbelView?.addSubview(shopView)
        
        let photoView:UIImageView = UIImageView(frame:CGRect(x:20*PX,y:20*PX,width:100*PX,height:100*PX))
        photoView.image = UIImage(named:photo)
        shopView.addSubview(photoView)
        
        let titleView:QZHUILabelView = QZHUILabelView()
        titleView.setLabelView(140*PX, 28*PX, titleView.autoLabelWidth(shopName, font: 30, height: 42*PX), 42*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 30, shopName)
        shopView.addSubview(titleView)
        
        if Vip == 1{
            let icon:UIImageView = UIImageView(frame:CGRect(x:140*PX,y:85*PX,width:25*PX,height:25*PX))
            icon.image = UIImage(named:"proVIPcon")
            shopView.addSubview(icon)
            let vipView:QZHUILabelView = QZHUILabelView()
            vipView.setLabelView(170*PX, 82*PX, 100*PX, 30*PX, NSTextAlignment.left, UIColor.clear, myColor().yellowF5d96c(), 22, "金牌会员")
            shopView.addSubview(vipView)
        }
        
        // 商品数量
        let proNumView:QZHUILabelView = QZHUILabelView()
        proNumView.setLabelView(44*PX, 160*PX, 88*PX, 42*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 30, "\(proCount)")
        shopView.addSubview(proNumView)
        let proView:QZHUILabelView = QZHUILabelView()
        proView.setLabelView(40*PX, 217*PX, 96*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 22, "全部商品")
        shopView.addSubview(proView)
        let line1:QZHUILabelView = QZHUILabelView()
        line1.dividers(175*PX, y: 160*PX, width: 2*PX, height: 87*PX, color: myColor().grayF0())
        shopView.addSubview(line1)
        
        // 月销售量
        let saleNumView:QZHUILabelView = QZHUILabelView()
        saleNumView.setLabelView(220*PX, 160*PX, 88*PX, 42*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 30, "\(sale)")
        shopView.addSubview(saleNumView)
        let saleView:QZHUILabelView = QZHUILabelView()
        saleView.setLabelView(220*PX, 217*PX, 88*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 22, "月销量")
        shopView.addSubview(saleView)
        let line2:QZHUILabelView = QZHUILabelView()
        line2.dividers(350*PX, y: 160*PX, width: 2*PX, height: 87*PX, color: myColor().grayF0())
        shopView.addSubview(line2)
        
        // 收藏人数
        let scNumView:QZHUILabelView = QZHUILabelView()
        scNumView.setLabelView(394*PX, 160*PX, 88*PX, 42*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 30, "\(scCount)")
        shopView.addSubview(scNumView)
        let scView:QZHUILabelView = QZHUILabelView()
        scView.setLabelView(390*PX, 217*PX, 96*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 22, "收藏人数")
        shopView.addSubview(scView)
        let line3:QZHUILabelView = QZHUILabelView()
        line3.dividers(525*PX, y: 160*PX, width: 2*PX, height: 87*PX, color: myColor().grayF0())
        shopView.addSubview(line3)
        
        // 商品评价
        let proCommentView:QZHUILabelView = QZHUILabelView()
        proCommentView.setLabelView(553*PX, 166*PX, 96*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 22, "商品评价")
        shopView.addSubview(proCommentView)
        let _proCommentNumView:QZHUILabelView = QZHUILabelView()
        _proCommentNumView.setLabelView(675*PX, 166*PX, 40*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().blue007aff(), 22, "\(proComment)")
        shopView.addSubview(_proCommentNumView)
        
        // 服务评价
        let sCommentView:QZHUILabelView = QZHUILabelView()
        sCommentView.setLabelView(553*PX, 210*PX, 96*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 22, "服务评价")
        shopView.addSubview(sCommentView)
        let _sCommentNumView:QZHUILabelView = QZHUILabelView()
        _sCommentNumView.setLabelView(675*PX, 210*PX, 40*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().blue007aff(), 22, "\(sComment)")
        shopView.addSubview(_sCommentNumView)
        
        // 店铺分类
        let btn1:QZHUIButton = QZHUIButton()
        btn1.setupButton(180*PX, 301*PX, 160*PX, 60*PX, myColor().blue007aff(), UIColor.white, "店铺分类", 24, 1*PX, myColor().blue007aff(), "", UIControlState.normal, 0, UIViewContentMode.center)
        btn1.frame = CGRect(x:180*PX,y:301*PX,width:160*PX,height:60*PX)
        btn1.layer.cornerRadius = 8*PX
        btn1.addTarget(self, action: #selector(self.shopSort), for: .touchUpInside)
        shopView.addSubview(btn1)
        
        // 进店逛逛
        let btn2:QZHUIButton = QZHUIButton()
        btn2.setupButton(410*PX, 301*PX, 160*PX, 60*PX, myColor().blue007aff(), UIColor.white, "店铺分类", 24, 1*PX, myColor().blue007aff(), "", UIControlState.normal, 0, UIViewContentMode.center)
        btn2.frame = CGRect(x:410*PX,y:301*PX,width:160*PX,height:60*PX)
        btn2.layer.cornerRadius = 8*PX
        btn2.addTarget(self, action: #selector(self.gotToShop), for: .touchUpInside)
        shopView.addSubview(btn2)
    }
    
    // 设置标题 UI
    func setupTitleUI(selView:QZHUIView,y:CGFloat,title:String,icon:String){
        selView.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.clear)
        tabbelView?.addSubview(selView)
        
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
        selView.addSubview(titleView)
        
    }
    
    // 设置底部样式
    func setupFooter(){
        let footView:QZHUIView = QZHUIView()
        footView.setupViews(x: 0, y: SCREEN_HEIGHT-100*PX, width: SCREEN_WIDTH, height: 100*PX, bgColor: UIColor.white)
        
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
        
        // 设置立即购买
        footer_BuyNow.setupButton(540*PX, 0, 210*PX, 100*PX, UIColor.white, myColor().blue007aff(), "立即购买", 28, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        footer_BuyNow.frame = CGRect(x:540*PX,y:0, width:210*PX, height:100*PX)
        footer_BuyNow.addTarget(self, action: #selector(self.buyNow), for: .touchUpInside)
        footView.addSubview(footer_BuyNow)
        
        // 设置加入购物车
        footer_AddCar.setupButton(330*PX, 0, 210*PX, 100*PX, UIColor.white, myColor().blue00b9ff(), "加入购物车", 28, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        footer_AddCar.frame = CGRect(x:330*PX,y:0, width:210*PX, height:100*PX)
        footer_AddCar.addTarget(self, action: #selector(self.addToCar), for: .touchUpInside)
        footView.addSubview(footer_AddCar)
        
        self.view.addSubview(footView)
    }
}

extension QZHProductDetailViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        if scrollView.contentOffset.y > SCREEN_WIDTH-128*PX{
             UIApplication.shared.statusBarview?.backgroundColor = UIColor.white
             self.navigationBar.isHidden = false
             topView.isHidden = true
        }else{
            UIApplication.shared.statusBarview?.backgroundColor = UIColor.clear
            self.navigationBar.isHidden = true
            topView.isHidden = false
        }
        
    }
}

// MARK: - 产品详情页 方法监听
extension QZHProductDetailViewController{
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 搜索
    func gotoSeach(){
    
    }
    
    // 返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 进入店铺
    func gotToShop(){
    }
    
    // 店铺分类
    func shopSort(){
        
    }
    
    // 客服
    func goToCustomer(){
    
    }
    
    // 收藏
    func collection(){
    
    }
    
    // 加入购物车
    func addToCar(){
    
    }
    
    // 立即购买
    func buyNow(){
    
    }
    
    // 分享
    func share(){
        
    }
    
     // 产品参数
    func openProAttr(){
    
    }
    
    // 产品规格
    func openProSpace(){
    
    }
    
    // 查看所有评价
    func checkEvaluation(){
        
    }
}
