//
//  QZHStoreIndexViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/5.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHStoreIndexViewController: QZHBaseViewController {
    
    // 店铺信息数据列表视图模型
    lazy var StoreInfo = QZHStoreIndexViewModel()
    
    // 筛选条 容器
    var screeningView:QZHUIView = QZHUIView()
    
    // 店铺信息
    var storeInfoView:QZHUIView = QZHUIView()
    
    // 综合排序
    var comSort:QZHUILabelView = QZHUILabelView()
    
    // 销量优先
    var sellSort:QZHUILabelView = QZHUILabelView()
    
    // 价格排序
    var priceSort:QZHUIView = QZHUIView()
    
    // 是否关注
    var isAttents:Int = 0
    
    // 新品
    var newPro:QZHUILabelView = QZHUILabelView()
    
    // 关注
    var careBtn:QZHUIView = QZHUIView()
    
    // 取消关注
    var careBtn1:QZHUIView = QZHUIView()
    
    override func loadData() {
        getInfo()
        getStorePro()
    }
    
    // 获取店铺信息
    func getInfo(){
        // 店铺信息的获取
        StoreInfo.getStoreInfo { (other,isSuccess) in
           
            if isSuccess{
                QZHStoreInfoModel.storeId = self.StoreInfo.storeInfo[0].status.id
                // 店铺信息映射
                self.isAttents = other["isAttent"] as! Int
                self.setupStoreInfoView(img: self.StoreInfo.storeInfo[0].status.storeLogo, name: self.StoreInfo.storeInfo[0].status.shortName, vip: self.StoreInfo.storeInfo[0].status.memberLevel, careNum: self.StoreInfo.storeInfo[0].status.attentionNum, care: other["isAttent"] as! Int)
            }
        }

    }
    
    // 获取店铺产品
    func getStorePro(){
        StoreInfo.getStorePro(pullup: self.isPulup) { (_ isSuccess:Bool,_ shouldRefresh:Bool) in
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

// MARK: - 页面 UI 设置
extension QZHStoreIndexViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        // 去掉 tableview 分割线
        self.tabbelView?.separatorStyle = .none
        
        // 设置 tabbleView 背景色
        self.tabbelView?.backgroundColor = UIColor.white
        
        // 注册原型 cell
        tabbelView?.register(UINib(nibName:"QZHStoreTableViewCell",bundle:nil), forCellReuseIdentifier: cellId)
        tabbelView?.top = 127*PX
        tabbelView?.height = SCREEN_HEIGHT - 127*PX
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                tabbelView?.top = 176*PX
                tabbelView?.height = SCREEN_HEIGHT - 343*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        // 设置导航条
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends),color:UIColor.white)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon2", target: self, action: #selector(self.close),color:UIColor.white)
        setupNav()
        
        setupScreeningView()
        
        // 设置店铺信息 View 位置坐标
        storeInfoView.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 152*PX, bgColor: UIColor.white)
        tabbelView?.addSubview(storeInfoView)
        
        setupStoreInfoView(img: "loadPic", name: "", vip: "金牌会员", careNum: 0, care: 0)
        
        setupBottom()
    }
    // 设置导航条
    func setupNav(){
        let btn:SearchController = SearchController()
        btn.isUserInteractionEnabled = true
        btn.addOnClickLister(target: self, action: #selector(self.goToSearch))
        navItem.titleView = btn.SeacrchTitleBtn4()
    }
    
    // 设置店铺信息
    func setupStoreInfoView(img:String,name:String,vip:String,careNum:Int,care:Int){
        let chilrenviews = self.storeInfoView.subviews
        
        for chilren in chilrenviews {
            
            chilren.removeFromSuperview()
            
        }
        // 店铺Logo设置
        let logoView:UIImageView = UIImageView(frame:CGRect(x:20*PX,y:32*PX,width:100*PX,height:100*PX))
        if img == ""{
            logoView.image = UIImage(named:"noPic")
        }else if img == "loadPic"{
            logoView.image = UIImage(named:img)
        }else{
            if let url = URL(string: img) {
                logoView.downloadedFrom(url: url)
            }else{
                logoView.image = UIImage(named:"noPic")
            }
        }
        storeInfoView.addSubview(logoView)
        
        // 店铺名称
        let nameView:QZHUILabelView = QZHUILabelView()
        nameView.setLabelView(140*PX, 44*PX, 321*PX, 42*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 30, name)
        storeInfoView.addSubview(nameView)
        
        // 会员设置
        if vip != ""{
            let icon:UIImageView = UIImageView(frame:CGRect(x:140*PX,y:90*PX,width:25*PX,height:25*PX))
            icon.image = UIImage(named:"proVIPcon")
            storeInfoView.addSubview(icon)
            
            let vipLable:QZHUILabelView = QZHUILabelView()
            vipLable.setLabelView(170*PX, 87*PX, 100*PX, 30*PX, NSTextAlignment.left, UIColor.white, myColor().yellowF5d96c(), 22, vip)
            storeInfoView.addSubview(vipLable)
        }
        
        // 关注数
        let careNumView:QZHUILabelView = QZHUILabelView()
        careNumView.setLabelView(500*PX, 44*PX, 100*PX, 33*PX, NSTextAlignment.right, UIColor.white, myColor().gray3(), 24, "\(careNum)")
        storeInfoView.addSubview(careNumView)
        let careLabels:QZHUILabelView = QZHUILabelView()
        careLabels.setLabelView(500*PX, 77*PX, 100*PX, 28*PX, NSTextAlignment.right, UIColor.white, myColor().gray3(), 20, "关注数")
        storeInfoView.addSubview(careLabels)
        
        
        careBtn.setupViews(x: 620*PX, y: 44*PX, width: 110*PX, height: 60*PX, bgColor: myColor().blue007aff())
        careBtn.layer.cornerRadius = 6*PX
        careBtn.layer.borderColor = myColor().blue007aff().cgColor
        careBtn.layer.borderWidth = 1*PX
        careBtn.addOnClickLister(target: self, action: #selector(self.careClick(_:)))
        careBtn.tag = 0
        let careIcon:UIImageView = UIImageView(frame:CGRect(x:13*PX,y:15*PX,width:30*PX,height:30*PX))
        careIcon.image = UIImage(named:"storeCare")
        careBtn.addSubview(careIcon)
        let careTitle:QZHUILabelView = QZHUILabelView()
        careTitle.setLabelView(53*PX, 15*PX, 50*PX, 30*PX, NSTextAlignment.left, UIColor.clear, UIColor.white, 22, "关注")
        careBtn.addSubview(careTitle)
        storeInfoView.addSubview(careBtn)
        
        careBtn1.setupViews(x: 620*PX, y: 44*PX, width: 110*PX, height: 60*PX, bgColor: UIColor.white)
        careBtn1.layer.borderColor = myColor().blue007aff().cgColor
        careBtn1.layer.borderWidth = 1*PX
        careBtn1.layer.cornerRadius = 6*PX
        careBtn1.addOnClickLister(target: self, action: #selector(self.careClick(_:)))
        careBtn1.tag = 1
        let careTitle1:QZHUILabelView = QZHUILabelView()
        careTitle1.setLabelView(5*PX, 15*PX, 100*PX, 30*PX, NSTextAlignment.center, UIColor.clear, myColor().blue007aff(), 22, "已关注")
        careBtn1.addSubview(careTitle1)
        storeInfoView.addSubview(careBtn1)
        
        if care == 0{
           careBtn.isHidden = false
            careBtn1.isHidden = true
        }else{
            careBtn.isHidden = true
            careBtn1.isHidden = false
        }
        
    }
    
    // 设置头部筛选栏
    func setupScreeningView(){
        screeningView.setupViews(x: 0, y: 152*PX, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
        tabbelView?.addSubview(screeningView)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 0, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayEB())
        screeningView.addSubview(line)
        let line1:QZHUILabelView = QZHUILabelView()
        line1.dividers(0, y: 79*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayEB())
        screeningView.addSubview(line1)
        
        // 综合排序
        comSort.setLabelView(46*PX, 1*PX, 125*PX, 78*PX, NSTextAlignment.left, UIColor.white, myColor().blue007aff(), 26, "综合排序")
        comSort.addOnClickLister(target: self, action: #selector(self.comSortClick(_:)))
        screeningView.addSubview(comSort)
        
        // 销量优先
        sellSort.setLabelView(229*PX, 1*PX, 125*PX, 78*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "销量优先")
        sellSort.addOnClickLister(target: self, action: #selector(self.sellSortClick(_:)))
        screeningView.addSubview(sellSort)
        
        // 价格排序
        priceSort.setupViews(x: 422*PX, y: 1*PX, width: 140*PX, height: 78*PX, bgColor: UIColor.white)
        priceSort.addOnClickLister(target: self, action: #selector(self.priceSortClick(_:)))
        screeningView.addSubview(priceSort)
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(0, 0, 115*PX, 78*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "价格排序")
        label.tag = 1
        priceSort.addSubview(label)
        let upIcon:UIImageView = UIImageView(frame:CGRect(x:127*PX,y:29*PX,width:13*PX,height:9*PX))
        upIcon.image = UIImage(named:"storePriceUp")
        upIcon.tag = 2
        priceSort.addSubview(upIcon)
        let downIcon:UIImageView = UIImageView(frame:CGRect(x:127*PX,y:42*PX,width:13*PX,height:9*PX))
        downIcon.image = UIImage(named:"storePriceDown")
        downIcon.tag = 3
        priceSort.addSubview(downIcon)
        
        // 新品
        newPro.addOnClickLister(target: self, action: #selector(self.newProClick(_:)))
        newPro.setLabelView(641*PX, 1*PX, 63*PX, 78*PX, NSTextAlignment.right, UIColor.white, myColor().gray3(), 26, "新品")
        screeningView.addSubview(newPro)
        
    }
    
    // 设置底部菜单栏
    func setupBottom(){
        // 设置底部容器
        let bottomView:QZHUIView = QZHUIView()
        bottomView.setupViews(x: 0, y: SCREEN_HEIGHT-100*PX, width: SCREEN_WIDTH, height: 100*PX, bgColor: UIColor.white)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                bottomView.y = SCREEN_HEIGHT-168*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        self.view.addSubview(bottomView)
        // 设置阴影
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 0.18
        bottomView.layer.shadowOffset = CGSize(width:2,height:2)
        
        // 设置店铺分类
        let sortBtn:QZHUILabelView = QZHUILabelView()
        sortBtn.setLabelView(0, 0, 319*PX, 100*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 28, "店铺分类")
        sortBtn.addOnClickLister(target: self, action: #selector(self.gotoStoreSort(_:)))
        bottomView.addSubview(sortBtn)
        
        let line1:QZHUILabelView = QZHUILabelView()
        line1.dividers(319*PX, y: 15*PX, width: 1*PX, height: 70*PX, color: myColor().grayEB())
        bottomView.addSubview(line1)
        
        let line2:QZHUILabelView = QZHUILabelView()
        line2.dividers(640*PX, y: 0, width: 1*PX, height: 100*PX, color: myColor().grayEB())
        bottomView.addSubview(line2)
        
        // 设置店铺简介
        let infoBtn:QZHUILabelView = QZHUILabelView()
        infoBtn.setLabelView(320*PX, 0, 320*PX, 100*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 28, "店铺简介")
        infoBtn.addOnClickLister(target: self, action: #selector(self.gotoStoreInfo(_:)))
        bottomView.addSubview(infoBtn)
        
        // 设置客服
        let customerBtn:QZHUIView = QZHUIView()
        customerBtn.setupViews(x: 641*PX, y: 0, width: 109*PX, height: 100*PX, bgColor: UIColor.white)
        // 设置图标
        let icon:UIImageView = UIImageView(frame:CGRect(x:34*PX,y:11*PX,width:40*PX,height:40*PX))
        icon.image = UIImage(named:"customerServiceIcon")
        customerBtn.addSubview(icon)
        // 设置标题
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(0, 61*PX, 109*PX, 28*PX, NSTextAlignment.center, UIColor.white, myColor().gray8a(), 20, "客服")
        customerBtn.addSubview(label)
        customerBtn.addOnClickLister(target: self, action: #selector(self.gotoCustomer(_:)))
        bottomView.addSubview(customerBtn)
    }
}

// MARK: - 设置tabbel数据源的绑定
extension QZHStoreIndexViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 1
        if self.StoreInfo.storePro.count%2 == 0{
            count = self.StoreInfo.storePro.count/2+count
        }else{
             count = self.StoreInfo.storePro.count/2 + count + 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 152*PX
        }else{
            return 501*PX
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHStoreTableViewCell
        cell.backgroundColor = UIColor.white
        var row = indexPath.row*2
        if indexPath.row != 0 {
            if self.StoreInfo.storePro.count > row-2{
                cell.pro1.tag = self.StoreInfo.storePro[row-2].status.productGoodsId
                if self.StoreInfo.storePro[row-2].status.picturePath == ""{
                    cell.img1.image = UIImage(named:"noPic")
                }else{
                    if let url = URL(string: self.StoreInfo.storePro[row-2].status.picturePath) {
                        cell.img1.downloadedFrom(url: url)
                    }else{
                        cell.img1.image = UIImage(named:"noPic")
                    }
                }
                cell.name1.text = self.StoreInfo.storePro[row-2].status.productName

                if self.StoreInfo.storePro[row-2].status.promotionPrice != 0.0 || self.StoreInfo.storePro[row-2].status.promotionPrice != 0{
                    cell.price1.text = "\(self.StoreInfo.storePro[row-2].status.promotionPrice)"
                }else{
                    cell.price1.text = "\(self.StoreInfo.storePro[row-2].status.originalPrice)"
                }
                cell.price1.setRealWages(cell.price1.text!, big: 28, small: 20, fg: ".")
                cell.price1.width = cell.price1.autoLabelWidth(cell.price1.text!, font: 38, height: 40*PX)
                if self.StoreInfo.storePro[row-2].status.unit != ""{
                    cell.spec1.text = "/\(self.StoreInfo.storePro[row-2].status.unit)"
                    cell.spec1.x = cell.price1.width + cell.price1.x
                }
                cell.sale1.text = "已售\(self.StoreInfo.storePro[row-2].status.salesVolume)"
                cell.pro1.tag = self.StoreInfo.storePro[row-2].status.productGoodsId
                cell.pro1.addOnClickLister(target: self, action: #selector(self.goToProDetail(_:)))
            }
            
            if self.StoreInfo.storePro.count > row-1{
                cell.pro2.tag = self.StoreInfo.storePro[row-1].status.productGoodsId
                if self.StoreInfo.storePro[row-1].status.picturePath == ""{
                    cell.img2.image = UIImage(named:"noPic")
                }else{
                    if let url = URL(string: self.StoreInfo.storePro[row-1].status.picturePath) {
                        cell.img2.downloadedFrom(url: url)
                    }else{
                        cell.img2.image = UIImage(named:"noPic")
                    }
                }
                cell.name2.text = self.StoreInfo.storePro[row-1].status.productName
                if self.StoreInfo.storePro[row-1].status.promotionPrice != 0.0 || self.StoreInfo.storePro[row-1].status.promotionPrice != 0{
                    cell.price2.text = "\(self.StoreInfo.storePro[row-1].status.promotionPrice)"
                }else{
                    cell.price2.text = "\(self.StoreInfo.storePro[row-1].status.originalPrice)"//originalPrice
                }
                cell.price2.setRealWages(cell.price2.text!, big: 28, small: 20, fg: ".")
                cell.price2.width = cell.price2.autoLabelWidth(cell.price2.text!, font: 38, height: 40*PX)
                if self.StoreInfo.storePro[row-1].status.unit != ""{
                    cell.spec2.text = "/\(self.StoreInfo.storePro[row-1].status.unit)"
                    cell.spec2.x = cell.price2.width + cell.price2.x
                }
                cell.sale2.text = "已售\(self.StoreInfo.storePro[row-1].status.salesVolume)"
                cell.pro2.tag = self.StoreInfo.storePro[row-1].status.productGoodsId
                cell.pro2.addOnClickLister(target: self, action: #selector(self.goToProDetail(_:)))

            }else{
                cell.pro2.isHidden = true
                
            }
        }else{
            cell.isHidden = true
        }
        return cell
    }
    
    /// 捕捉滚动条动作
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 152*PX{
            self.view.addSubview(screeningView)
            screeningView.y = 127*PX
         }else{
           self.tabbelView?.addSubview(screeningView)
            screeningView.y = 152*PX
        }
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }

}

// MARK: - 设置监听方法
extension QZHStoreIndexViewController{
    
    override func login() {
        super.login()
        self.present(QZHOAuthViewController(), animated: true, completion: nil)
    }
    
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    // 返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 搜索页面跳转
    func goToSearch(){
        let nav = QZHStoreSearchViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 店铺分类
    func gotoStoreSort(_ sender:UITapGestureRecognizer){
        
        let nav = QZHStoreSortViewController()
        //let nav = ViewController()
        present(nav, animated: true, completion: nil)
        
    }
    
    // 店铺简介
    func gotoStoreInfo(_ sender:UITapGestureRecognizer){
        let nav = QZHStoreInfoViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 客服
    func gotoCustomer(_ sender:UITapGestureRecognizer){}
    
    // 关注
    func careClick(_ sender:UITapGestureRecognizer){
        if isAttents == 1{
            StoreInfo.delet(completion: { (isSuccess) in
                if isSuccess{
                    self.careBtn.isHidden = false
                    self.careBtn1.isHidden = true
                }else{
                    print("shiba")
                }
            })
        }else{
            StoreInfo.insert(completion: { (isSuccess) in
                if isSuccess{
                    self.careBtn.isHidden = true
                    self.careBtn1.isHidden = false
                }
                else{
                    print("shiba")
                }
            })
        }
    }
    
    // 综合排序 
    func comSortClick(_ sender:UITapGestureRecognizer){
        QZHStoreProModel.pageNo = 1
        QZHStoreProModel.order = 1
        
        comSort.textColor = myColor().blue007aff()
        sellSort.textColor = myColor().gray3()
        newPro.textColor = myColor().gray3()
        
        let sellArray:[UIView] = priceSort.subviews
        for views in sellArray{
            if views.tag == 1{
                (views as! QZHUILabelView).textColor = myColor().gray3()
            }else if views.tag == 2{
                (views as! UIImageView).image = UIImage(named:"storePriceUp")
            }else if views.tag == 3{
                (views as! UIImageView).image = UIImage(named:"storePriceDown")
            }
        }
        
        self.getStorePro()
    }
    
    // 销量优先
    func sellSortClick(_ sender:UITapGestureRecognizer){
        QZHStoreProModel.pageNo = 1
        QZHStoreProModel.order = 2
        
        comSort.textColor = myColor().gray3()
        sellSort.textColor = myColor().blue007aff()
        newPro.textColor = myColor().gray3()
        let sellArray:[UIView] = priceSort.subviews
        for views in sellArray{
            if views.tag == 1{
                (views as! QZHUILabelView).textColor = myColor().gray3()
            }else if views.tag == 2{
                (views as! UIImageView).image = UIImage(named:"storePriceUp")
            }else if views.tag == 3{
                (views as! UIImageView).image = UIImage(named:"storePriceDown")
            }
        }
        
        self.getStorePro()
    }
    
    // 价格排序
    func priceSortClick(_ sender:UITapGestureRecognizer){
        QZHStoreProModel.pageNo = 1
        
        let sellArray:[UIView] = priceSort.subviews
        for views in sellArray{
            if views.tag == 1{
                (views as! QZHUILabelView).textColor = myColor().blue007aff()
            }
        }

        if (QZHStoreProModel.order != 3 && QZHStoreProModel.order != 4) || QZHStoreProModel.order == 4{
            QZHStoreProModel.order = 3
            for views in sellArray{
                if views.tag == 2{
                    (views as! UIImageView).image = UIImage(named:"storePriceUp1")
                }else if views.tag == 3{
                    (views as! UIImageView).image = UIImage(named:"storePriceDown")
                }
            }
        }else{
            QZHStoreProModel.order = 4
            for views in sellArray{
                if views.tag == 2{
                    (views as! UIImageView).image = UIImage(named:"storePriceUp")
                }else if views.tag == 3{
                    (views as! UIImageView).image = UIImage(named:"storePriceDown1")
                }
            }
        }
        
        comSort.textColor = myColor().gray3()
        sellSort.textColor = myColor().gray3()
        newPro.textColor = myColor().gray3()
        
        self.getStorePro()
    }
    
    // 新品
    func newProClick(_ sender:UITapGestureRecognizer){
        QZHStoreProModel.pageNo = 1
        QZHStoreProModel.order = 5
        
        comSort.textColor = myColor().gray3()
        sellSort.textColor = myColor().gray3()
        newPro.textColor = myColor().blue007aff()
        let sellArray:[UIView] = priceSort.subviews
        for views in sellArray{
            if views.tag == 1{
                (views as! QZHUILabelView).textColor = myColor().gray3()
            }else if views.tag == 2{
                (views as! UIImageView).image = UIImage(named:"storePriceUp")
            }else if views.tag == 3{
                (views as! UIImageView).image = UIImage(named:"storePriceDown")
            }
        }
        
        self.getStorePro()
    }
    
    // 跳转产品详情页
    func goToProDetail(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHProductDetailModel.goodsId = (this?.tag)!
        
        let nav = QZHProductDetailViewController()
        present(nav, animated: true, completion: nil)
        
    }
}
