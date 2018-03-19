//
//  QZHStore_SearchList_ViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/7.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHStore_SearchList_ViewController: QZHBaseViewController {

    // 店铺信息数据列表视图模型
    lazy var StoreProList = QZHStoreIndexViewModel()
    
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
    
    // 新品
    var newPro:QZHUILabelView = QZHUILabelView()
    
    // 关注
    var careBtn:QZHUIView = QZHUIView()
    
    // 取消关注
    var careBtn1:QZHUIView = QZHUIView()
    
    override func loadData() {
        getStorePro()
    }
    
    // 
    func getStorePro(){
        StoreProList.getStorePro_Search(pullup: self.isPulup) { (_ isSuccess:Bool,_ shouldRefresh:Bool) in
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
extension QZHStore_SearchList_ViewController{
    override func setupUI() {
        super.setupUI()
        
        self.isPush = true
        // 去掉 tableview 分割线
        self.tabbelView?.separatorStyle = .none
        
        // 设置 tabbleView 背景色
        self.tabbelView?.backgroundColor = UIColor.white
        
        // 注册原型 cell
        tabbelView?.register(UINib(nibName:"QZHStoreTableViewCell",bundle:nil), forCellReuseIdentifier: cellId)
        tabbelView?.top = 209*PX
        tabbelView?.height = SCREEN_HEIGHT - 209*PX
        
        // 设置导航条
        navItem.rightBarButtonItems = [UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends),color:UIColor.white),UIBarButtonItem(title: "", img: "storeSortIcon", target: self, action: #selector(gotoStoreSort),color:UIColor.white)]
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon2", target: self, action: #selector(self.close),color:UIColor.white)
        setupNav()
        
        setupScreeningView()

    }
    
    // 设置导航条
    func setupNav(){
        let btn:SearchController = SearchController()
        btn.isUserInteractionEnabled = true
        btn.addOnClickLister(target: self, action: #selector(self.goToSearch))
        
        let searchView = btn.SeacrchTitleBtn5()
        if QZHStoreSearchProModel.q != ""{
            (searchView.viewWithTag(1) as! UILabel).text = QZHStoreSearchProModel.q
            (searchView.viewWithTag(1) as! UILabel).textColor = myColor().gray3()
        }
        navItem.titleView = searchView
        
    }
    
    // 设置头部筛选栏
    func setupScreeningView(){
        screeningView.setupViews(x: 0, y: 127*PX, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
        self.view.addSubview(screeningView)
        
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
}

// MARK: - 绑定数据源
extension QZHStore_SearchList_ViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 1
        if self.StoreProList.storeSearchPro.count%2 == 0{
            count = self.StoreProList.storeSearchPro.count/2
        }else{
            count = self.StoreProList.storeSearchPro.count/2 + 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 501*PX
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHStoreTableViewCell
        var row = indexPath.row*2
        if self.StoreProList.storeSearchPro.count > row{
            print(self.StoreProList.storeSearchPro[row].status)
            cell.pro1.tag = self.StoreProList.storeSearchPro[row].status.productGoodsId
            if self.StoreProList.storeSearchPro[row].status.picturePath == ""{
                cell.img1.image = UIImage(named:"noPic")
            }else{
                cell.img1.image = UIImage(named:"noPic")
                //cell.img1.image = UIImage(data:PublicFunction().imgFromURL(self.StoreProList.storeSearchPro[row].status.picturePath))
            }
            cell.name1.text = self.StoreProList.storeSearchPro[row].status.productName
            if self.StoreProList.storeSearchPro[row].status.promotionPrice == 0.0{
                cell.price1.text = "\(self.StoreProList.storeSearchPro[row].status.promotionPrice)"
            }else{
                cell.price1.text = "\(self.StoreProList.storeSearchPro[row].status.originalPrice)"
            }
            
            cell.spec1.text = "/\(self.StoreProList.storeSearchPro[row].status.unit)"
            cell.sale1.text = "已售\(self.StoreProList.storeSearchPro[row].status.salesVolume)"
        }
        
        if self.StoreProList.storeSearchPro.count > row+1{
            cell.pro2.tag = self.StoreProList.storeSearchPro[row+1].status.productGoodsId
            if self.StoreProList.storeSearchPro[row+1].status.picturePath == ""{
                cell.img2.image = UIImage(named:"noPic")
            }else{
                //cell.img2.image = UIImage(data:PublicFunction().imgFromURL(self.StoreProList.storeSearchPro[row+1].status.picturePath))
            }
            cell.name2.text = self.StoreProList.storeSearchPro[row+1].status.productName
            if self.StoreProList.storeSearchPro[row+1].status.promotionPrice == 0.0{
                cell.price2.text = "\(self.StoreProList.storeSearchPro[row+1].status.promotionPrice)"
            }else{
                cell.price2.text = "\(self.StoreProList.storeSearchPro[row+1].status.originalPrice)"
            }
            cell.spec2.text = "/\(self.StoreProList.storeSearchPro[row+1].status.unit)"
            cell.sale2.text = "已售\(self.StoreProList.storeSearchPro[row+1].status.salesVolume)"
            
        }else{
            cell.pro2.isHidden = true
            
        }
        return cell
    }
    
    /// 捕捉滚动条动作
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }

}

// MARK: - 监听方法
extension QZHStore_SearchList_ViewController{
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 跳转至分类页面
    func gotoStoreSort(){
        let nav = QZHStoreSortViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 返回
    func close(){
        if QZHStoreSearchProModel.fromPage != 1{
            dismiss(animated: true, completion: nil)
        }else{
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    // 搜索页面跳转
    func goToSearch(){
        let nav = QZHStoreSearchViewController()
        present(nav, animated: true, completion: nil)
    }
    // 综合排序
    func comSortClick(_ sender:UITapGestureRecognizer){
        QZHStoreSearchProModel.pageNo = 1
        QZHStoreSearchProModel.order = 1
        
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
        QZHStoreSearchProModel.pageNo = 1
        QZHStoreSearchProModel.order = 2
        
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
        QZHStoreSearchProModel.pageNo = 1
        
        let sellArray:[UIView] = priceSort.subviews
        for views in sellArray{
            if views.tag == 1{
                (views as! QZHUILabelView).textColor = myColor().blue007aff()
            }
        }
        
        if (QZHStoreSearchProModel.order != 3 && QZHStoreSearchProModel.order != 4) || QZHStoreSearchProModel.order == 4{
            QZHStoreSearchProModel.order = 3
            for views in sellArray{
                if views.tag == 2{
                    (views as! UIImageView).image = UIImage(named:"storePriceUp1")
                }else if views.tag == 3{
                    (views as! UIImageView).image = UIImage(named:"storePriceDown")
                }
            }
        }else if QZHStoreSearchProModel.order == 3 {
            QZHStoreSearchProModel.order = 4
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
        QZHStoreSearchProModel.pageNo = 1
        QZHStoreSearchProModel.order = 5
         print("newPro:\(newPro.textColor)")
        comSort.textColor = myColor().gray3()
        sellSort.textColor = myColor().gray3()
        
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
        
        newPro.textColor = myColor().blue007aff()
        self.getStorePro()
        print("newPro:\(newPro.textColor)")
    }
    
    // 跳转产品详情页
    func goToProDetail(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHProductDetailModel.goodsId = (this?.tag)!
        
        let nav = QZHProductDetailViewController()
        present(nav, animated: true, completion: nil)
        
    }
}
