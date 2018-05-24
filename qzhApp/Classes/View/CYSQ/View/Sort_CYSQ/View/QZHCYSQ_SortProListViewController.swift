//
//  QZHCYSQ_SortProListViewController.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/13.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHCYSQ_SortProListViewController: QZHBaseViewController {
    // 产业商圈分类数据列表视图模型
    lazy var SortList = QZH_CYSQSortListViewModel()
    
    // 产品列表视图懒加载
    lazy var ProList = QZHCYSQ_SortProListViewModel()
    
    // 分类项
    var MarketClassView1:QZHUIScrollView = QZHUIScrollView()
    var MarketClassView1line:QZHUILabelView = QZHUILabelView()
    
    // 暂无产品
    var noList:QZHUIView = QZHUIView()
    
    override func loadData() {
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        let children:[UIView] = self.MarketClassView1.subviews
        for child in children{
            child.removeFromSuperview()
        }
        self.loadData()
        
    }
    
    func getData(){
        SortList.getSortList { (result) in
            var left:CGFloat = 33*PX
            let sortList = self.SortList.sortList
            for i in 0..<sortList.count{
                if "\(sortList[i].status.categoryId)" == QZHCYSQSearchProListParamModel.categoryId{
                    left = self.setupvarMarketClassView1(x: left, img: sortList[i].status.pictureUrl, str: sortList[i].status.name, tag: sortList[i].status.categoryId, sel: true)
                }else{
                    left = self.setupvarMarketClassView1(x: left, img: sortList[i].status.pictureUrl, str: sortList[i].status.name, tag: sortList[i].status.categoryId, sel: false)
                }
                
            }
            self.view.addSubview(self.MarketClassView1)
            self.getList()
        }

    }
    
    func getList(){
        self.ProList.loadList(pullUp: self.isPulup) { (isSuccess, shouldRefresh) in
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
    
    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                MarketClassView1.y = 177*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
    }
    
}


// MARK: - 设置页面 UI 样式
extension QZHCYSQ_SortProListViewController{
    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor.white
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        setStatusBarBackgroundColor(color: .white)
        // 去掉 tableview 分割线
        tabbelView?.separatorStyle = .none
        
        // 注册原型 cell
        tabbelView?.register(UINib(nibName:"QZHrResultProListCell",bundle:nil), forCellReuseIdentifier: cellId)
        self.view.backgroundColor = UIColor.white
        tabbelView?.y = 170*PX
        tabbelView?.height = SCREEN_HEIGHT - 170*PX
        tabbelView?.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                tabbelView?.y = 218*PX
                tabbelView?.height = SCREEN_HEIGHT - 218*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        setupNav1()
        noList.setupNoList(y: 293*PX, str: "暂无该分类产品")
        self.view.addSubview(noList)
    }
    
    func setupNav1(){
        let btn:SearchController = SearchController()
        btn.addOnClickLister(target: self, action: #selector(goToSearch))
        navItem.titleView = btn.SeacrchTitleBtn2(title: "产业商圈", titleColor: myColor().Gray6c6ca1())
        
        navItem.rightBarButtonItem = UIBarButtonItem(title: "消息", img: "chatIcon", target: self, action: #selector(showFriends))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(self.close),color:UIColor.white)
        navigationBar.tintColor = myColor().gray3()
        navigationBar.barTintColor = UIColor.white
        navigationBar.isTranslucent = false
        
        MarketClassView1line.dividers(0, y: 128*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
               MarketClassView1line.dividers(0, y: 176*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
            }
            
        } else {
            // Fallback on earlier versions
        }
        self.view.addSubview(MarketClassView1line)
        
        MarketClassView1.setupScrollerView(x: 0, y: 129*PX, width: SCREEN_WIDTH, height: 107*PX, background: UIColor.white)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                MarketClassView1.y = 177*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
            
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 106*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayEB())
        MarketClassView1.addSubview(line)
        
        self.view.addSubview(self.MarketClassView1)
        
    }
    
    func setupvarMarketClassView1(x:CGFloat,img:String,str:String,tag:Int,sel:Bool)->CGFloat{
        var left:CGFloat = x
        
        let icon1:UIImageView = UIImageView(frame:CGRect(x:x,y:5*PX,width:66*PX,height:66*PX))
        icon1.layer.cornerRadius = 33*PX
        icon1.clipsToBounds = true
        icon1.backgroundColor = UIColor(patternImage: setupImgBg(colors:[UIColor(red:232/255,green:49/255,blue:78/255,alpha:0.92),UIColor(red:255/255,green:113/255,blue:113/255,alpha:0.80)], size: CGSize(width:66*PX,height:66*PX)))
        icon1.tag = tag
        
        let imgView:UIImageView = UIImageView(frame:CGRect(x:10*PX,y:10*PX,width:46*PX,height:46*PX))
        if let url = URL(string: img) {
            imgView.downloadedFrom(url: url)
        }else{
            imgView.image = UIImage(named:"noPic")
        }
        icon1.addSubview(imgView)
        icon1.addOnClickLister(target: self, action: #selector(self.goToMarketClass(_:)))
        MarketClassView1.addSubview(icon1)
        
        let title1:QZHUILabelView = QZHUILabelView()
        title1.setLabelView(x - 8*PX, 76*PX, 83*PX, 25*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 18, str)
        title1.tag = tag
        
        if sel{
            title1.textColor = myColor().blue007aff()
        }
        title1.alpha = 0.7
        title1.restorationIdentifier = "txt"
        title1.addOnClickLister(target: self, action: #selector(self.goToMarketClass(_:)))
        MarketClassView1.addSubview(title1)
        
        
        left = left + 99*PX
        
        MarketClassView1.contentSize = CGSize(width:left,height:107*PX)
        
        return left
    }
    
    // 设置分类图标背景色
    func setupImgBg(colors:[UIColor],size:CGSize)->UIImage{
        return UIImage(gradientColors:colors,size:size)!
    }
}

// MARK: - 绑定数据源
extension QZHCYSQ_SortProListViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = self.ProList.proListStatus.count/2
        if self.ProList.proListStatus.count%2>0{
            count = count+1
        }
        
        print("count:\(count)")

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
                if let url = URL(string: pro1.picturePath as! String) {
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
    
    /// 捕捉滚动条动作
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}

// MARK: - 设置监听方法
extension QZHCYSQ_SortProListViewController{
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    // 返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 跳转产品详情页
    func goToProDetail(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHProductDetailModel.goodsId = (this?.tag)!
        
        let nav = QZHProductDetailViewController()
        present(nav, animated: true, completion: nil)
        
    }
    
    // 搜索页面跳转
    func goToSearch(){
        QZHCYSQSearchProListParamModel.categoryId = ""
        QZHBrandModel.categoryId = 0
        let nav = QZHSearchViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 分类
    func goToMarketClass(_ sender:UITapGestureRecognizer){
        let this:UIView = sender.view!
        let id:String! = String(stringInterpolationSegment: this.tag)
        QZHCYSQSearchProListParamModel.categoryId = String(stringInterpolationSegment: this.tag)
        
        let classArray1:[UIView] = self.MarketClassView1.subviews
        for i in 0..<classArray1.count{
            if classArray1[i].restorationIdentifier == "txt"{
                if (classArray1[i] as! UILabel).tag == this.tag{
                    (classArray1[i] as! UILabel).textColor = myColor().blue007aff()
                }else{
                    (classArray1[i] as! UILabel).textColor = myColor().gray3()
                }
            }
        }
        
        getList()
    }
}
