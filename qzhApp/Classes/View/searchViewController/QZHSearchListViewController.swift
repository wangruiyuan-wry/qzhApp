//
//  QZHSearchListViewController.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/18.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHSearchListViewController: QZHBaseViewController {
    // 产品列表视图懒加载
    lazy var ProList = QZHSearchProListViewModel()
    
    // 暂无产品
    var noList:QZHUIView = QZHUIView()

    // 筛选条 容器
    var screeningView:QZHUIView = QZHUIView()
    
    // 综合排序
    var comSort:QZHUILabelView = QZHUILabelView()
    
    // 销量优先
    var sellSort:QZHUILabelView = QZHUILabelView()
    
    // 价格排序
    var priceSort:QZHUIView = QZHUIView()
    
    // 筛选
    var newPro:QZHUILabelView = QZHUILabelView()


    
    override func loadData() {
        getFunc()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.loadData()
    }
    
    // 获取数据模型
    func getFunc(){
        ProList.loadList(pullUp: self.isPulup) { (isSuccess, shouldRefresh) in
            //结束刷新控件
            self.refreahController?.endRefreshing()
            
            //恢复上拉刷新标记
            self.isPulup = false
            
            //刷新表
            if shouldRefresh {
                if self.ProList.proListStatus.count > 0{
                    self.tabbelView?.isHidden = false
                    self.tabbelView?.reloadData()
                    self.noList.isHidden = true
                }else{
                    self.tabbelView?.isHidden = true
                    self.noList.isHidden = false
                }
                
            }

        }
    }

    func getFunc1(){
        loadData()
    }

}

// MARK: - 设置页面 UI 样式
extension QZHSearchListViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        
        self.view.backgroundColor = UIColor.white
        //self.isPush = true
        //setStatusBarBackgroundColor(color: .white)
        // 去掉 tableview 分割线
        tabbelView?.separatorStyle = .none
        
        // 注册原型 cell
        tabbelView?.register(UINib(nibName:"QZHrResultProListCell",bundle:nil), forCellReuseIdentifier: cellId)
        self.view.backgroundColor = UIColor.white
        tabbelView?.y = 130*PX
        tabbelView?.backgroundColor = UIColor.white
        tabbelView?.height = SCREEN_HEIGHT - 130*PX
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                tabbelView?.y = 178*PX
                tabbelView?.backgroundColor = UIColor.white
                tabbelView?.height = SCREEN_HEIGHT - 246*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        setupNav1()
        
        setupScreeningView()
        
        noList.setupNoList(y: 210*PX, str: "暂无产品")
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                noList.setupNoList(y: 258*PX, str: "暂无产品")
            }
            
        } else {
            // Fallback on earlier versions
        }
        self.view.addSubview(noList)

    }
    
    func setupNav1(){
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends),color:UIColor.white)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon2", target: self, action: #selector(self.close),color:UIColor.white)
        let btn:SearchController = SearchController()
        btn.isUserInteractionEnabled = true
        btn.addOnClickLister(target: self, action: #selector(self.goToSearch))
        
        let searchView = btn.SeacrchTitleBtn5()
        if QZHStoreSearchProModel.q != ""{
            (searchView.viewWithTag(1) as! UILabel).text = QZHCYSQSearchProListParamModel.q
            (searchView.viewWithTag(1) as! UILabel).textColor = myColor().gray3()
        }
        navItem.titleView = searchView

    }
    
    // 设置头部筛选栏
    func setupScreeningView(){
        screeningView.setupViews(x: 0, y: 127*PX, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                screeningView.setupViews(x: 0, y: 175*PX, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
            }
            
        } else {
            // Fallback on earlier versions
        }
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
        newPro.addOnClickLister(target: self, action: #selector(self.ScreenClick))
        newPro.setLabelView(641*PX, 1*PX, 63*PX, 78*PX, NSTextAlignment.right, UIColor.white, myColor().gray3(), 26, "筛选")
        screeningView.addSubview(newPro)
    }
}

// MARK: - 绑定数据源
extension QZHSearchListViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = self.ProList.proListStatus.count/2
        if self.ProList.proListStatus.count%2>0{
            count = count+1
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 501*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHrResultProListCell
        cell.backgroundColor = UIColor.clear
        let index = indexPath.row*2
        let pro1 = self.ProList.proListStatus[index].status
        cell.proName1.text = pro1.productName
        cell.price1.text = "\(pro1.originalPrice)"
        cell.price1.setRealWages(cell.price1.text!, big: 28, small: 20, fg: ".")
        if pro1.unit != ""{
            cell.unit1.text = "/\(pro1.unit)"
            cell.unit1.x = cell.price1.x + cell.price1.width
        }
        if pro1.picturePath != ""{
            if let url = URL(string: pro1.picturePath ) {
                cell.proImg1.downloadedFrom(url: url)
            }else{
                cell.proImg1.image = UIImage(named:"noPic")
            }
        }else{
            cell.proImg1.image = UIImage(named:"noPic")
        }
        cell.saleNum1.text = "已售\(pro1.salesVolume)"
        cell.pro1.tag = Int(pro1.productGoodsId)
        cell.pro1.addOnClickLister(target: self, action: #selector(self.goToProDetail(_:)))
        
        if self.ProList.proListStatus.count <= index+1{
            cell.pro2.isHidden = true
        }else{
            let pro2 = self.ProList.proListStatus[index+1].status
            cell.proName2.text = pro2.productName
            cell.price2.text = "\(pro2.originalPrice)"
            cell.price2.setRealWages(cell.price2.text!, big: 28, small: 20, fg: ".")
            
            if pro2.unit != ""{
                cell.unit2.text = "/\(pro2.unit)"
                cell.unit2.x = cell.price2.x + cell.price2.width
            }
            if pro2.picturePath != ""{
                if let url = URL(string: pro2.picturePath as! String) {
                    cell.proImg2.downloadedFrom(url: url)
                }else{
                    cell.proImg2.image = UIImage(named:"noPic")
                }
            }else{
                cell.proImg2.image = UIImage(named:"noPic")
            }
            cell.saleNum2.text = "已售\(pro2.salesVolume)"
            cell.pro2.tag = Int(pro2.productGoodsId)
            cell.pro2.addOnClickLister(target: self, action: #selector(self.goToProDetail(_:)))
        }
        
        return cell
    }
}

// MARK: - 设置监听
extension QZHSearchListViewController{

    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    // 返回
    func close(){
        if QZHCYSQSearchProListParamModel.closeFlag == true{
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
     }
    
    // 搜索页面跳转
    func goToSearch(){
       dismiss(animated: true, completion: nil)
    }
    
    // 筛选
    func ScreenClick(){
        let nav = QZHScreenPanViewController()
        //nav.modalPresentationStyle = .overCurrentContext
        present(nav, animated: true, completion: nil)
    }
    
    // 综合排序
    func comSortClick(_ sender:UITapGestureRecognizer){
        QZHStoreSearchProModel.pageNo = 1
        QZHCYSQSearchProListParamModel.order = 1
        
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
        
        self.getFunc()
    }
    
    // 销量优先
    func sellSortClick(_ sender:UITapGestureRecognizer){
        QZHStoreSearchProModel.pageNo = 1
        QZHCYSQSearchProListParamModel.order = 2
        
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
        
        self.getFunc()
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
        
        if (QZHCYSQSearchProListParamModel.order != 3 && QZHCYSQSearchProListParamModel.order != 4) || QZHCYSQSearchProListParamModel.order == 4{
            QZHCYSQSearchProListParamModel.order = 3
            for views in sellArray{
                if views.tag == 2{
                    (views as! UIImageView).image = UIImage(named:"storePriceUp1")
                }else if views.tag == 3{
                    (views as! UIImageView).image = UIImage(named:"storePriceDown")
                }
            }
        }else if QZHCYSQSearchProListParamModel.order == 3 {
            QZHCYSQSearchProListParamModel.order = 4
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
        
        self.getFunc()
    }
    
    // 新品
    func newProClick(_ sender:UITapGestureRecognizer){
        let _this:UIView = sender.view!
        QZHStoreSearchProModel.pageNo = 1
        QZHCYSQSearchProListParamModel.categoryId = "\(_this.tag)"
        QZHCYSQSearchProListParamModel.order = 1
        QZHCYSQSearchProListParamModel.q = ""
        QZHCYSQSearchProListParamModel.brand = ""
        QZHCYSQSearchProListParamModel.specOptionName = ""
        QZHCYSQSearchProListParamModel.customCategoryId = ""
        QZHCYSQSearchProListParamModel.price = ""
        QZHCYSQSearchProListParamModel.category_id_lv1 = ""
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
    }
    
    // 跳转产品详情页
    func goToProDetail(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHProductDetailModel.goodsId = (this?.tag)!
        
        let nav = QZHProductDetailViewController()
        present(nav, animated: true, completion: nil)
        
    }
}
