//
//  QZH_CYSQCarViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZH_CYSQCarViewController: QZHBaseViewController {

    // 产业商圈购物车列表视图模型
    lazy var carList = QZH_CYSQCarListViewModel()
    
    // 产品详情视图模型懒加载
    lazy var productDetailStatus = QZHProductDetailViewModel()
    
    // 结算
    var bottomView:QZHUIView = QZHUIView()
    
    // 结算按钮
    var settlermentBtn:QZHUIButton = QZHUIButton()
    
    // 删除按钮
    var delBtn:QZHUIButton = QZHUIButton()
    
    // 合计金额
    var combinedLabel:QZHUILabelView = QZHUILabelView()
    
    // 结算备注
    var settlermentView:QZHUIView = QZHUIView()
    
    // 选中产品
    var selNum:QZHUILabelView = QZHUILabelView()
    
    // 不含运费
    var yf:QZHUILabelView = QZHUILabelView()
    
    // 全选
    var checkAll:UIImageView = UIImageView()
    var checkLabel:QZHUILabelView = QZHUILabelView()
    
    // 头部标题
    var titleLabel:QZHUILabelView = QZHUILabelView()
    
    // 灰色遮罩层
    var bgView:QZHUIView = QZHUIView()
    
    // 规格选择
    var specView:QZHUIView = QZHUIView()
    var spec:QZHUIView = QZHUIView()
    var yxView:QZHUILabelView = QZHUILabelView()
    var ggContentView:QZHUIScrollView = QZHUIScrollView()
    var imgView:UIImageView = UIImageView()
    var priceView:QZHUILabelView = QZHUILabelView()
    var kcView:QZHUILabelView = QZHUILabelView()
    var specNameStr:String = ""
    var specIdStr:String = ""
    var proIdArray:String = ""
    var proIdFlaga:Int = 0
    
    // 数组
    var cellPath:[IndexPath] = []
    var sectionArray:[Int] = []
    
    // 合计金额
    var sumPrice:Double = 0.0
    var priceIcon:QZHUILabelView = QZHUILabelView()
    var settlermentLabel:QZHUILabelView = QZHUILabelView()
    
    // 编辑参数
    var editParam:[String:AnyObject] = [:]
    
    // 删除参数
    var delIds = ""
    
    // 所选cell行
    var selCell:QZH_CYSQCarTableViewCell = QZH_CYSQCarTableViewCell()
    
    // 购物车暂无产品
    var noProInCar:QZHUIView = QZHUIView()
    
    // 还未登录
    var loginOut:QZHUIView = QZHUIView()
    
    override func loadData() {
       getData()
    }
    
    func getData(){
        carList.getCarList(pullUp: self.isPulup) { (isSuccess,shouldRefresh,isLogin,toalCount) in
            //结束刷新控件
            self.refreahController?.endRefreshing()
            //恢复上拉刷新标记
            self.isPulup = false
            
            if isLogin{
                self.loginOut.isHidden = true
                self.titleLabel.text = "购物车（\(toalCount)）"
                self.sumPrice = 0.0
                if toalCount == 0{
                    self.noProInCar.isHidden = false
                    self.navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "", target: self, action: #selector(self.closeSpecView),color:UIColor.white)
                    self.bottomView.isHidden  = true
                    //self.tabbelView?.isHidden = true
                }else{
                    self.noProInCar.isHidden = true
                    self.bottomView.isHidden = false
                    //self.tabbelView?.isHidden = false
                    self.navItem.rightBarButtonItem = UIBarButtonItem(title: "管理", img: "", target: self, action: #selector(self.manageCar),color:UIColor.white)
                }
    
                //刷新表
                if shouldRefresh {
                    self.sumPrice = 0.0
                    self.tabbelView?.reloadData()
                }
               // self.sumPrice = 0.0
                //self.tabbelView?.reloadData()

            }else{
                LoginModel.isLogin = 0
                self.loginOut.isHidden = false
                self.noProInCar.isHidden = true
                self.bottomView.isHidden = true
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    func getdataSpec(){
        let indexPath = tabbelView?.indexPath(for: selCell)
        let children:[UIView] = self.ggContentView.subviews
        for child in children{
            child.removeFromSuperview()
        }
        productDetailStatus.getProSpec { (isSucess) in
            var ggTop:CGFloat = 0
            for i in 0..<self.productDetailStatus.proSpaceStatus.count{
                ggTop = self.setupCommentList(y: ggTop, title: self.productDetailStatus.proSpaceStatus[i].status.specName, commentArray: self.productDetailStatus.proSpaceStatus[i].status.option as! [[String : AnyObject]], ids: self.carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.specOptionId, tag: i+1 )
            }
        }
    }
    
    func getProPrice(){
        self.productDetailStatus.getProductPrice { (result, isSuccess) in
            if isSuccess{
                if self.productDetailStatus.proPriceStatus[0].status.picturePath != ""{
                    if let url = URL(string: self.productDetailStatus.proPriceStatus[0].status.picturePath) {
                        self.imgView.downloadedFrom(url: url)
                    }else{
                        self.imgView.image = UIImage(named:"noPic")
                    }
                }else{
                    self.imgView.image = UIImage(named:"noPic")
                }
                if self.productDetailStatus.proPriceStatus[0].status.originalPrice == 0.0 && self.productDetailStatus.proPriceStatus[0].status.originalPrice == 0 && self.productDetailStatus.proPriceStatus[0].status.originalPrice is NSNull{
                    self.priceView.text = "\(self.productDetailStatus.proPriceStatus[0].status.promotionPrice)"
                }else{
                    self.priceView.text = "\(self.productDetailStatus.proPriceStatus[0].status.originalPrice)"
                }
                self.kcView.text = "库存\(self.productDetailStatus.proPriceStatus[0].status.stock)件"

            }
        }
    }
    
}

// MARK: - 设置页面 UI
extension QZH_CYSQCarViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        self.view.backgroundColor = myColor().grayF0()
        // 注册原型 cell
        tabbelView?.register(UINib(nibName:"QZH_CYSQCarTableViewCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        tabbelView?.y = 128*PX
        tabbelView?.height = SCREEN_HEIGHT - 306*PX
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                tabbelView?.y = 176*PX
                tabbelView?.height = SCREEN_HEIGHT - 422*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        
        tabbelView?.backgroundColor = myColor().grayF0()
        tabbelView?.isEditing = false
        tabbelView?.allowsMultipleSelectionDuringEditing = true
        tabbelView?.separatorStyle = .none
        
        setupNav()
        
        setupBottom()
        
        setupSPECView()
        
        
        setupNoProCar()
        
        loginOuts()
        self.loginOut.isHidden = true
    }
    
    // 未登录设置
    func loginOuts(){
        loginOut.setupViews(x: 0, y: 129*PX, width: SCREEN_WIDTH, height: 450*PX, bgColor: UIColor.clear)
        let title:QZHUILabelView = QZHUILabelView()
        loginOut.addSubview(title)
        title.setLabelView(0, 250*PX, SCREEN_WIDTH, 43*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 30, "您还未登录，请先登录～～～")
        
        let btn:QZHUILabelView = QZHUILabelView()
        btn.setLabelView(245*PX, 342*PX, 260*PX, 80*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 30, "请先登录")
        btn.addOnClickLister(target: self, action: #selector(self.loginUser))
        btn.layer.borderColor = myColor().Gray6().cgColor
        btn.layer.borderWidth = 1*PX
        btn.layer.cornerRadius = 5*PX
        btn.layer.masksToBounds = true
        loginOut.addSubview(btn)
        self.view.addSubview(loginOut)
    }
    
    // 购物车暂无产品
    func setupNoProCar(){
        self.noProInCar.setupViews(x: 0, y: 1*PX, width: SCREEN_WIDTH, height: 450*PX, bgColor: UIColor.white)
        tabbelView?.addSubview(noProInCar)
        
        // 暂无产品图标
        let imgView:UIImageView = UIImageView(frame:CGRect(x:283*PX,y:33*PX,width:175*PX,height:175*PX))
        imgView.image = UIImage(named:"CarNoPro")
        noProInCar.addSubview(imgView)
        
        // 暂无产品标题
        let noLabel:QZHUILabelView = QZHUILabelView()
        noLabel.setLabelView(260*PX, 250*PX, 230*PX, 42*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 30, "购物车暂无产品")
        noProInCar.addSubview(noLabel)
        
        // 我的收藏
        let myCollectBtn:UIButton = UIButton(frame:CGRect(x:115*PX,y:342*PX,width:240*PX,height:80*PX))
        myCollectBtn.setTitle("我的收藏", for: .normal)
        myCollectBtn.tintColor = UIColor.white
        myCollectBtn.backgroundColor = myColor().blue007aff()
        myCollectBtn.layer.cornerRadius = 5*PX
        myCollectBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30*PX)
        myCollectBtn.addOnClickLister(target: self, action: #selector(self.myCollect(_:)))
        noProInCar.addSubview(myCollectBtn)
        
        // 再去逛逛
        let goSEEBtn:UIButton = UIButton(frame:CGRect(x:395*PX,y:342*PX,width:240*PX,height:80*PX))
        goSEEBtn.setTitle("再去逛逛", for: .normal)
        goSEEBtn.tintColor = UIColor.white
        goSEEBtn.backgroundColor = myColor().blue007aff()
        goSEEBtn.layer.cornerRadius = 5*PX
        goSEEBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30*PX)
        goSEEBtn.addOnClickLister(target: self, action: #selector(self.goSEE(_:)))
        noProInCar.addSubview(goSEEBtn)
    }
    
    // 设置导航栏
    func setupNav(){
        //self.title = "购物车（\(0)）"
        titleLabel.setLabelView(100*PX, 59*PX, 450*PX, 50*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 36, "购物车（0）")
        navItem.titleView = titleLabel
        navItem.rightBarButtonItem = UIBarButtonItem(title: "管理", img: "", target: self, action: #selector(self.manageCar),color:UIColor.white)
        //navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon2", target: self, action: #selector(self.close),color:UIColor.white)

    }
    
    // 设置底部结算栏
    func setupBottom(){
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 0, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        bottomView.setupViews(x: 0, y: SCREEN_HEIGHT-200*PX, width: SCREEN_WIDTH, height: 100*PX, bgColor: UIColor.white)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                bottomView.setupViews(x: 0, y: SCREEN_HEIGHT-248*PX, width: SCREEN_WIDTH, height: 100*PX, bgColor: UIColor.white)
            }
            
        } else {
            // Fallback on earlier versions
        }
        bottomView.addSubview(line)
        self.view.addSubview(bottomView)
        
        // 全选
        let checkAllView:QZHUIView = QZHUIView()
        checkAllView.setupViews(x: 0, y: 0, width: 180*PX, height: 100*PX, bgColor: UIColor.clear)
        checkAllView.addOnClickLister(target: self, action: #selector(self.cheacAllAction))
        checkAll.frame = CGRect(x:19*PX,y:32*PX,width:37*PX,height:37*PX)
        checkAll.image = UIImage(named:"CarSel")
        checkAllView.addSubview(checkAll)
        checkAll.restorationIdentifier = "unSel"
        checkAll.layer.cornerRadius = 17.5*PX
        checkAll.layer.masksToBounds = true
        checkAllView.addOnClickLister(target: self, action: #selector(self.cheacAllAction))
        
        checkLabel.setLabelView(75*PX, 34*PX, 100*PX, 33*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, "全选")
        checkAllView.addSubview(checkLabel)
        bottomView.addSubview(checkAllView)
        
        // 结算按钮
        settlermentBtn.frame = CGRect(x:550*PX,y:0*PX,width:200*PX,height:100*PX)
        settlermentBtn.setTitle("结算（0）", for: .normal)
        settlermentBtn.backgroundColor = myColor().blue007aff()
        settlermentBtn.tintColor = UIColor.white
        settlermentBtn.addTarget(self, action: #selector(self.settlermentClick(_:)), for: .touchUpInside)
        bottomView.addSubview(settlermentBtn)
        
        // 设置结算备注
        settlermentView.setupViews(x: 150*PX, y: 0, width: 400*PX, height: 100*PX, bgColor: UIColor.clear)
        yf.setLabelView(0*PX, 39*PX, 90*PX, 28*PX, NSTextAlignment.right, UIColor.clear, myColor().gray9(), 20, "不含运费")
        yf.isHidden = false
        settlermentView.addSubview(yf)
        settlermentView.addSubview(settlermentLabel)
        settlermentLabel.setLabelView(143*PX, 30*PX, 90*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, "合计：")
        settlermentView.addSubview(priceIcon)
        priceIcon.setLabelView(253*PX, 39*PX, 20*PX, 28*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 20, "¥")
        combinedLabel.setLabelView(273*PX, 30*PX, 120*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 28, "0.00")
        combinedLabel.adjustsFontSizeToFitWidth = true
        settlermentView.addSubview(combinedLabel)
        combinedLabel.setRealWages(combinedLabel.text!, big: 28, small: 20, fg: ".")
        bottomView.addSubview(settlermentView)
        
        
        // 移除按钮
        delBtn.isHidden = true
        delBtn.frame = CGRect(x:550*PX,y:0*PX,width:200*PX,height:100*PX)
        delBtn.setTitle("删除", for: .normal)
        delBtn.backgroundColor = myColor().redFf4300()
        delBtn.tintColor = UIColor.white
        delBtn.addTarget(self, action: #selector(self.delClick(_:)), for: .touchUpInside)
        bottomView.addSubview(delBtn)
        
        // 移除的产品数量
        selNum.isHidden = true
        selNum.setLabelView(200*PX, 34*PX, 320*PX, 33*PX, NSTextAlignment.right, UIColor.clear, myColor().gray3(), 24, "共选中0件产品")
        bottomView.addSubview(selNum)
    }
    
    // 设置规格筛选
    func setupSPECView(){
        bgView.blackBackground(y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        bgView.isHidden = true
        bgView.addOnClickLister(target: self, action: #selector(self.closeSpecView))
        self.view.addSubview(bgView)
        
        specView.setupViews(x: 0, y: 216*PX, width: SCREEN_WIDTH, height: 1025*PX, bgColor: UIColor.clear)
        specView.isHidden = true
        self.view.addSubview(specView)
        
        spec.setupViews(x: 0, y: 35*PX, width: SCREEN_WIDTH, height: 990*PX, bgColor: UIColor.white)
        specView.addSubview(spec)
        
        let okBtn:UIButton = UIButton()
        okBtn.frame = CGRect(x:0,y:890*PX,width:375*PX,height:100*PX)
        okBtn.setTitle("确定", for:.normal)
        okBtn.backgroundColor = myColor().blue00b9ff()
        okBtn.tintColor = UIColor.white
        okBtn.addTarget(self, action: #selector(self.specOk), for: .touchUpInside)
        spec.addSubview(okBtn)
        
        let proDetailBtn:UIButton = UIButton()
        proDetailBtn.frame = CGRect(x:375*PX,y:890*PX,width:375*PX,height:100*PX)
        proDetailBtn.setTitle("查看详情", for:.normal)
        proDetailBtn.backgroundColor = myColor().blue007aff()
        proDetailBtn.tintColor = UIColor.white
        proDetailBtn.addTarget(self, action: #selector(self.goToProDetail(_:)), for: .touchUpInside)
        spec.addSubview(proDetailBtn)
        
        let closeBtn:UIImageView = UIImageView(frame:CGRect(x:684*PX,y:24*PX,width:42*PX,height:42*PX))
        closeBtn.image = UIImage(named:"proDetailCloseIcon")
        spec.addSubview(closeBtn)
        closeBtn.addOnClickLister(target: self, action: #selector(self.closeSpecView))
        
        ggContentView.setupScrollerView(x:0 , y: 201*PX, width: SCREEN_WIDTH, height: 687*PX, background: UIColor.white)
        
        spec.addSubview(ggContentView)
    }
    
    // 规格筛选头部
    func setSpecTop(img:String,price:Double,kc:Double,specStr:String,unit:String){
        
        imgView.frame = CGRect(x:25*PX,y:0,width:200*PX,height:200*PX)
        imgView.layer.cornerRadius = 6*PX
        imgView.layer.masksToBounds = true
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 5*PX
        if img == ""{
            imgView.image = UIImage(named:"noPic")
        }else{
            if let url = URL(string: img) {
                imgView.downloadedFrom(url: url)
            }else{
                imgView.image = UIImage(named:"noPic")
            }
        }
        specView.addSubview(imgView)
        
        spec.addSubview(priceView)
        priceView.setLabelView(250*PX, 30*PX, 270*PX, 42*PX, NSTextAlignment.left, UIColor.white, myColor().redFf4300(), 30, "¥\(price.roundTo(places: 2))")
        
        
        kcView.setLabelView(250*PX, 82*PX, 425*PX, 37*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 26, "库存\(kc)\(unit)")
        spec.addSubview(kcView)
        
        yxView.setLabelView(250*PX, 129*PX, 480*PX, 37*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 26, "已选：\(specStr)")
        spec.addSubview(yxView)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(20*PX, y: 200*PX, width: 710*PX, height: 1*PX, color: myColor().grayEB())
        spec.addSubview(line)
    }
    
    // 设置规格项
    func setupCommentList(y:CGFloat,title:String,commentArray:[[String:AnyObject]], ids:String,tag:Int)->CGFloat{
        var top_Y = y
        
        let commentView:QZHUIView = QZHUIView()
        commentView.setupViews(x: 20*PX, y: y, width: 710*PX, height: 57*PX, bgColor: UIColor.clear)
        commentView.restorationIdentifier = "commentView"
        commentView.tag = tag
        ggContentView.addSubview(commentView)
        
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

            let index_SpecId = ids.components(separatedBy: ";").index(of: "\(commentArray[i]["optionId"]!)")
            if index_SpecId != nil{
                setupSelSpec(listBtn)
            }
            left = left + widthBtn + 80*PX
        }
        
        top_Y = top_Y + 80*PX
        commentView.height = marginTop + 80*PX
        ggContentView.contentSize = CGSize(width:ggContentView.width,height:top_Y)
        return top_Y
    }
    // 规格修改
    func checkComment1(_ sender:UITapGestureRecognizer){
        let _this:QZHUILabelView = sender.view as! QZHUILabelView
        setlistBtn_Blue(_this)
        if proIdArray.components(separatedBy: ",").count != 1 || proIdArray == ""{
        }else{
            let proID:String! = String.init(proIdArray)
            QZHProductDetailModel.productId = Int64.init(proID!)!
            self.getProPrice()
        }
    }
    func setlistBtn_Blue(_ _this:QZHUILabelView){
        let parent = _this.superview
        setupSelSpec(_this)
        setDefaultBtn((parent?.tag)!)
        let selBtnView:[UIView] = ggContentView.subviews
        specIdStr = ""
        proIdArray = ""
        specNameStr = ""
        for views in selBtnView{
            let children:[QZHUILabelView] = views.subviews as! [QZHUILabelView]
            for child in children{
                if child.tag == 2{
                    if specNameStr != ""{
                        specNameStr = "\(specNameStr),"
                        specIdStr = "\(specIdStr);"
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
        self.yxView.text = "已选：\(specNameStr)"
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
        let viewArray:[UIView] = ggContentView.subviews as! [UIView]
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
        let viewArray:[UIView] = ggContentView.subviews as! [UIView]
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

// MARK: - 数据源绑定
extension QZH_CYSQCarViewController{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 82*PX
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.carList.shoppingCarList.count
    }
   
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20*PX
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = QZH_CYSQCarTableViewHeader.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:81*PX))
        let _index = sectionArray.index(of: section)
        if _index == nil{
            headerView.choosenView.restorationIdentifier = "unSel"
            headerView.chooseBtn.setImage(UIImage(named:"CarSel"), for: .normal)
        }else{
            headerView.choosenView.restorationIdentifier = "sel"
            headerView.chooseBtn.setImage(UIImage(named:"CarSel1"), for: .normal)
        }
        
        headerView.setupStoreName("\(self.carList.shoppingCarList[section].status.storeName)")
        headerView.choosenView.addTarget(self, action: #selector(self.storeChoose(_:)), for: .touchUpInside)
        headerView.choosenView .tag = section + 1
        headerView.detailBtn.tag = self.carList.shoppingCarList[section].status.storeId
        headerView.detailBtn.addTarget(self, action: #selector(self.gotoStore(_:)), for: .touchUpInside)
       return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 181*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZH_CYSQCarTableViewCell
        
        
        let proInfo:[String:AnyObject] = self.carList.carProList[indexPath.section][indexPath.row].status.productInfo
        if self.carList.proInfoList[indexPath.section][indexPath.row].status.picturePath != ""{
            if let url = URL(string: self.carList.proInfoList[indexPath.section][indexPath.row].status.picturePath) {
                cell.proImg.downloadedFrom(url: url)
            }else{
                cell.proImg.image = UIImage(named:"noPic")
            }
        }else{
            cell.proImg.image = UIImage(named:"noPic")
        }
        
        cell.proName.text = self.carList.proInfoList[indexPath.section][indexPath.row].status.productName

        //cell.choosenBtn.addOnClickLister(target: self, action: #selector(self.choosen(_:)))
        cell.chossenView.addOnClickLister(target: self, action: #selector(self.choosen(_:)))
        
        cell.proSpec.text = "\(self.carList.carProList[indexPath.section][indexPath.row].status.specOptionName)"
        cell.proSpec.restorationIdentifier = "\(self.carList.carProList[indexPath.section][indexPath.row].status.specOptionId)"
        let promotionPrice = self.carList.proInfoList[indexPath.section][indexPath.row].status.promotionPrice
        if promotionPrice == 0.0 && promotionPrice == 0 && promotionPrice is NSNull{
            cell.price1.text = "\(self.carList.proInfoList[indexPath.section][indexPath.row].status.orginalPrice.roundTo(places: 2))"
            cell.price1.setRealWages(cell.price1.text!, big: 28, small: 20, fg: ".")
        }else{
            cell.price1.text = "\((promotionPrice).roundTo(places: 2))"
            cell.price1.setRealWages(cell.price1.text!, big: 28, small: 20, fg: ".")
            cell.price2.text = "¥\(self.carList.proInfoList[indexPath.section][indexPath.row].status.orginalPrice.roundTo(places: 2))"
            let attriText = NSAttributedString(string:cell.price2.text!,attributes:[NSStrikethroughStyleAttributeName:1])
            cell.price2.attributedText = attriText
        }
        cell.proNum.text = "x\(self.carList.carProList[indexPath.section][indexPath.row].status.productCount)"
        cell.proNum.width = cell.proNum.autoLabelWidth(cell.proNum.text!, font: 25, height: 28*PX)
        cell.proNum.x = 475*PX - cell.proNum.width
        cell.specText.text = cell.proSpec.text
        cell.numText.text = "\(self.carList.carProList[indexPath.section][indexPath.row].status.productCount)"
        
        cell.specBtn.addOnClickLister(target: self, action: #selector(self.openSpecView))
        
        cell.okBtn.addTarget(self, action: #selector(self.ok(_:)), for: .touchUpInside)
        cell.okBtn.tag = self.carList.carProList[indexPath.section][indexPath.row].status.productId
        
        let _index = cellPath.index(of: indexPath)
        if _index == nil{
            cell.choosenBtn.restorationIdentifier = "unSel"
            cell.choosenBtn.image = UIImage(named:"CarSel")
        }else{
            cell.choosenBtn.restorationIdentifier = "sel"
            cell.choosenBtn.image = UIImage(named:"CarSel1")
            if delIds != ""{
                delIds = "\(delIds),"
            }
            delIds = "\(delIds)\(self.carList.carProList[indexPath.section][indexPath.row].status.id)"
            print("sumPrice0:\(sumPrice)")
            sumPrice = sumPrice + Double.init(cell.price1.text!)! * Double.init(cell.numText.text!)!
            print("sumPrice:\(sumPrice)")
        }
        combinedLabel.text = "\(sumPrice.roundTo(places: 2))"
        combinedLabel.setRealWages(combinedLabel.text!, big: 28, small: 20, fg: ".")
        let widths = combinedLabel.autoLabelWidth(combinedLabel.text!, font: 32, height: combinedLabel.height)
        combinedLabel.width = widths
        combinedLabel.x = 310*PX - widths
        priceIcon.x = combinedLabel.x - 20*PX
        settlermentLabel.x = priceIcon.x - 90*PX
        
        cell.tag = self.carList.carProList[indexPath.section][indexPath.row].status.goodsId
        cell.proBtn.tag =  self.carList.carProList[indexPath.section][indexPath.row].status.goodsId
        cell.proBtn.addOnClickLister(target: self, action: #selector(self.goToProDetail1(_:)))
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carList.carProList[section].count
        // self.carList.shoppingCarList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //组头高度
        let sectionHeaderHeight:CGFloat = 80*PX
        //组尾高度
        let sectionFooterHeight:CGFloat = 20*PX
        
        //获取是否有默认调整的内边距
        let defaultEdgeTop:CGFloat = navigationController?.navigationBar != nil
            && self.automaticallyAdjustsScrollViewInsets ? 64 : 0
        
        //上边距相关
        var edgeTop = defaultEdgeTop
        if scrollView.contentOffset.y >= -defaultEdgeTop &&
            scrollView.contentOffset.y <= sectionHeaderHeight - defaultEdgeTop  {
            edgeTop = -scrollView.contentOffset.y
        }
        else if (scrollView.contentOffset.y>=sectionHeaderHeight - defaultEdgeTop) {
            edgeTop = -sectionHeaderHeight + defaultEdgeTop
        }
        
        //下边距相关
        var edgeBottom:CGFloat = 20*PX
        let b = scrollView.contentOffset.y + scrollView.frame.height
        let h = scrollView.contentSize.height - sectionFooterHeight
        
        if b <= h {
            edgeBottom = -30
        }else if b > h && b < scrollView.contentSize.height {
            edgeBottom = b - h - 30
        }
        
        //设置内边距
        scrollView.contentInset = UIEdgeInsetsMake(edgeTop, 0, edgeBottom, 0)
    }
    /*func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "删除"
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
        }
    }*/
}


// MARK: - 设置监听方法
extension QZH_CYSQCarViewController{
    
    // 管理
    func manageCar(_ sender:UIButton){
        if sender.titleLabel?.text! == "管理"{
            sender.setTitle("完成", for: .normal)
            delBtn.isHidden = false
            settlermentBtn.isHidden = true
            selNum.isHidden = false
            settlermentView.isHidden = true
            
        }else{
            sender.setTitle("管理", for: .normal)
            delBtn.isHidden = true
            settlermentBtn.isHidden = false
            selNum.isHidden = true
            settlermentView.isHidden = false
        }
    }
    
    // 返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 全选
    func cheacAllAction(){
        let cells = tabbelView?.visibleCells
        if checkAll.restorationIdentifier == "unSel"{
            checkAll.restorationIdentifier = "sel"
            checkAll.image = UIImage(named:"CarSel1")
            for cell in cells!{
                cellPath.append((tabbelView?.indexPath(for: cell))!)
                let index = sectionArray.index(of:(tabbelView?.indexPath(for: cell))!.section)
                if index == nil{
                    sectionArray.append((tabbelView?.indexPath(for: cell))!.section)
                }
            }
        }else{
            checkAll.restorationIdentifier = "unSel"
            checkAll.image = UIImage(named:"CarSel")
            for cell in cells!{
                let index = cellPath.index(of: (tabbelView?.indexPath(for: cell))!)
                if index != nil{
                    cellPath.remove(at: index!)
                }
            }
            sectionArray = []
            cellPath = []
        }
        sumPrice = 0.0
        tabbelView?.reloadData()
        settlermentBtn.setTitle("结算（\(cellPath.count)）", for: .normal)
        selNum.text = "共选中\(cellPath.count)件产品"
    }
    
    // 选择产品
    func choosen(_ sender:UITapGestureRecognizer){
        let cell = sender.view?.superview?.superview as!QZH_CYSQCarTableViewCell
        let indexPath = tabbelView?.indexPath(for: cell)
        let _index = sectionArray.index(of: (indexPath?.section)!)
        if  _index == nil{
            sectionArray.append((indexPath?.section)!)
        }
        if cell.choosenBtn.restorationIdentifier == "unSel"{
            cellPath.append((tabbelView?.indexPath(for: cell))!)
        }else{
            let index = cellPath.index(of: (tabbelView?.indexPath(for: cell))!)
            if index != nil{
                cellPath.remove(at: index!)
            }
        }
        delIds = ""
        sumPrice = 0.0
        tabbelView?.reloadData()
        
        let cells = tabbelView?.visibleCells
        checkAll.restorationIdentifier = "sel"
        checkAll.image = UIImage(named:"CarSel1")
        for c in cells!{
            if (c as! QZH_CYSQCarTableViewCell).choosenBtn.restorationIdentifier == "unSel"{
                checkAll.image = UIImage(named:"CarSel")
                checkAll.restorationIdentifier = "unSel"
            }
        }
        for c in cells!{
            if tabbelView?.indexPath(for: c)?.section ==  indexPath?.section{
                if (c as! QZH_CYSQCarTableViewCell).choosenBtn.restorationIdentifier == "unSel" {
                    let index = sectionArray.index(of: (indexPath?.section)!)
                    if  index != nil{
                        sectionArray.remove(at: index!)
                    }
                }
            }
        }
        let indexSet = NSIndexSet.init(index: (indexPath?.section)!)
        settlermentBtn.setTitle("结算（\(cellPath.count)）", for: .normal)
        selNum.text = "共选中\(cellPath.count)件产品"
    }
    
    // 选择店铺
    func storeChoose(_ sender:UIButton){
        let section = sender.tag-1
        let cells = tabbelView?.visibleCells

        checkAll.restorationIdentifier = "sel"
        checkAll.image = UIImage(named:"CarSel1")
        if sender.restorationIdentifier == "unSel"{
            let index = sectionArray.index(of: section)
            if  index == nil{
                sectionArray.append(section)
            }
            for c in cells!{
                if tabbelView?.indexPath(for: c)?.section == section{
                    let _index = cellPath.index(of: (tabbelView?.indexPath(for: c))!)
                    if _index == nil{
                        cellPath.append((tabbelView?.indexPath(for: c))!)
                    }
                }
          }
        }else{
            let index = sectionArray.index(of: section)
            if  index != nil{
                sectionArray.remove(at: index!)
            }
            for c in cells!{
                if tabbelView?.indexPath(for: c)?.section == section{
                    let _index = cellPath.index(of: (tabbelView?.indexPath(for: c))!)
                    if _index != nil{
                        cellPath.remove(at: _index!)
                    }
                }
            }
        }
        delIds = ""
        tabbelView?.reloadData()
        
        for c in cells!{
            if (c as! QZH_CYSQCarTableViewCell).choosenBtn.restorationIdentifier == "unSel"{
                checkAll.image = UIImage(named:"CarSel")
                checkAll.restorationIdentifier = "unSel"
            }
        }
        settlermentBtn.setTitle("结算（\(cellPath.count)）", for: .normal)
        selNum.text = "共选中\(cellPath.count)件产品"
    }
    
    
    // 结算
    func settlermentClick(_ sender:QZHUIButton){
        if self.delIds == ""{
            UIAlertController.showAlert(message: "你还未选择，请先选择", in: self)
        }else{
            QZH_CYSQCarSettlementModel.ids = self.delIds
            QZH_CYSQCarSettlementModel.ShoppingFlag = 0
            QZH_CYSQCarSettlementModel.type = 0
            let nav = QZH_CYSQCarSettlementViewController()
            present(nav, animated: true, completion: nil)
        }

    }
    
    // 删除
    func delClick(_ sender:QZHUIButton){
        if cellPath.count != 0 {
            for indexpath in cellPath{
                self.carList.carProList[indexpath.section].removeAtIndexes(ixs: [indexpath.row])
            }
        }
        //删除选中的数据
        self.carList.shoppingCarList.removeAtIndexes(ixs: sectionArray)
        
        QZH_CYSQCarProModel.idStr = self.delIds
        
        self.carList.delCar { (isSuccess, result) in
            UIAlertController.showAlert(message: result, in: self)
            //重新加载数据
            self.sumPrice = 0.0
            self.delIds = ""
            self.getData()
        }
    }
    
    // 选定规格
    func specOk(){
        closeSpecView()
        let indexPath = tabbelView?.indexPath(for: selCell)
        if proIdArray.components(separatedBy: ",").count != 1 || proIdArray == ""{
            UIAlertController.showAlert(message: "您所选的规格暂无产品", in: self)
        }else{
            selCell.proSpec.text = specNameStr
            selCell.specText.text = specNameStr
            selCell.specText.restorationIdentifier = specIdStr
            selCell.price1.text = "\(productDetailStatus.proPriceStatus[0].status.originalPrice)"
            selCell.price2.text = "\(productDetailStatus.proPriceStatus[0].status.promotionPrice)"
            selCell.okBtn.tag = Int.init(proIdArray)!
            self.carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.specOptionId = specIdStr
            selCell.proSpec.restorationIdentifier! = specIdStr
        }
        
    }
    // 选择规格
    func openSpecView(_ sender:UITapGestureRecognizer){
        let cell = sender.view?.superview?.superview?.superview as!QZH_CYSQCarTableViewCell
        let indexPath = tabbelView?.indexPath(for: cell)
        specView.isHidden = false
        bgView.isHidden = false
        QZHProductDetailModel.goodsId = cell.tag
        self.setSpecTop(img: self.carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.productInfo["picturePath"] as! String, price: Double.init(cell.price1.text!)!, kc: self.carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.productInfo["stock"] as! Double , specStr: self.carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.specOptionName, unit: "件")
        self.selCell = cell
        if proIdFlaga != cell.tag{
            //proIdFlaga = cell.tag
            self.getdataSpec()
        }else{
            var ggTop:CGFloat = 0
            for i in 0..<self.productDetailStatus.proSpaceStatus.count{
                ggTop = self.setupCommentList(y: ggTop, title: self.productDetailStatus.proSpaceStatus[i].status.specName, commentArray: self.productDetailStatus.proSpaceStatus[i].status.option as! [[String : AnyObject]], ids: self.carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.specOptionId, tag: i+1 )
            }
        }
        
    }

    
    // 关闭规格选择
    func closeSpecView(){
        specView.isHidden = true
        bgView.isHidden = true
    }
    
    // 店铺
    func gotoStore(_ sender:UIButton){
        QZHStoreInfoModel.memberID = sender.tag
        let vc = QZHStoreIndexViewController()
        present(vc, animated: true, completion: nil)
    }
    
    // 跳转产品详情页
    func goToProDetail(_ sender:UITapGestureRecognizer){
        QZHProductDetailModel.goodsId = selCell.tag
        
        let nav = QZHProductDetailViewController()
        present(nav, animated: true, completion: nil)
        
    }
    func goToProDetail1(_ sender:UITapGestureRecognizer){
        let _this = sender.view
        QZHProductDetailModel.goodsId = (_this?.tag)!
        
        let nav = QZHProductDetailViewController()
        present(nav, animated: true, completion: nil)
        
    }
    
    // 编辑完成
    func ok(_ sender:UIButton){
        let cell = sender.superview?.superview?.superview as!QZH_CYSQCarTableViewCell
        let indexPath = tabbelView?.indexPath(for: cell)
        cell.proView.isHidden = false
        cell.proEditView.isHidden = true
        
        carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.productCount =  Double.init(cell.numText.text!)!
        carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.specOptionId = cell.proSpec.restorationIdentifier!
        carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.specOptionName = cell.specText.text!
        carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.productInfo["originalPrice"] = Double.init(cell.price1.text!)! as AnyObject
        //carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.productInfo["promotionPrice"] = Double.init(cell.price2.text!)! as AnyObject
        //carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.productId = cell.tag
        
        QZH_CYSQCarProModel.ids = carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.id
        QZH_CYSQCarProModel.productIds = cell.okBtn.tag
        QZH_CYSQCarProModel.proCounts = Double.init(cell.numText.text!)!
        QZH_CYSQCarProModel.specOptionNames = cell.specText.text!
        QZH_CYSQCarProModel.specOptionId = cell.proSpec.restorationIdentifier!
        
        sumPrice = 0.0
        delIds = ""
        tabbelView?.reloadData()
        cell.proBtn.isHidden = true
        self.carList.editCar { (isSuccess, result) in
           UIAlertController.showAlert(message: result, in: self)
            self.getData()
        }
        print(carList.carProList[(indexPath?.section)!][(indexPath?.row)!].status.productId)
    }
    
    // 我的收藏
    func myCollect(_ sender:UIButton){
        let nav = QZHCollectViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 再去逛逛
    func goSEE(_ sender:UIButton){
        let nav = QZHMainViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 登录
    func loginUser(){
        let nav = QZHOAuthViewController()
        present(nav, animated: true, completion: nil)
    }

}
