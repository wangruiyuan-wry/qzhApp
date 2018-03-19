//
//  QZH_CYSQSortViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/2/28.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZH_CYSQSortViewController: QZHBaseViewController {
    
    // 产业商圈分类数据列表视图模型
    lazy var SortList = QZH_CYSQSortListViewModel()
    
    // 左边一级分类容器
    var leftSort:QZHUIScrollView = QZHUIScrollView()
    
    // 右边二级分类容器
    var rightSort:QZHUIScrollView = QZHUIScrollView()

    override func loadData() {
        SortList.getFristSortList { (isSuccess, result) in
            if isSuccess{
                var top:CGFloat = 0
                for i in 0..<result.count{
                    top = self.setupLeftSortItem(y: top, title: result[i].status.lableName, id: result[i].status.id, url: result[i].status.pictureUrl)
                }
                QZH_CYSQSort_SecondModel.parentId = result[0].status.id
                self.setupAD(pic: result[0].status.pictureUrl)
                self.loadSecondSort()
            }
        }
    }
    
    func loadSecondSort(){
        SortList.getSecondSortList { (isSuccess, result) in
            if isSuccess{
                for i in 0..<result.count{
                    self.setupRightSort(count: i, id: result[i].status.categoryId, pic: result[i].status.pictureUrl, name: result[i].status.name)
                }
            }
        }
    }
}

// - MARK: 设置页面 UI
extension QZH_CYSQSortViewController{
    override func setupUI() {
        super.setupUI()
        
        self.view.backgroundColor = myColor().grayF0()
        
        // 去掉 tableview 分割线
        self.tabbelView?.separatorStyle = .none
        tabbelView?.height = 1
        
        // 注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupNavTitle()
        
        setupLeftSort()
        setupRightSort()
    }
    
    // 设置头部导航栏
    func setupNavTitle(){
        navItem.title = ""
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends))
        
        let btn:SearchController = SearchController()
        btn.addOnClickLister(target: self, action:#selector( goToSearch))

        var _leftbtn=UIBarButtonItem(customView:btn.SeacrchTitleBtn3())
        navItem.leftBarButtonItem = _leftbtn
    }
    
    // 设置一级分类列表样式
    func setupLeftSort(){
        leftSort.setupScrollerView(x: 0, y: 129*PX, width: 190*PX, height: SCREEN_HEIGHT-225*PX, background: myColor().grayF0())
        leftSort.contentSize = CGSize(width:leftSort.width,height:leftSort.height)
        self.view.addSubview(leftSort)
    }
    // 设置一级分类项
    func setupLeftSortItem(y:CGFloat,title:String,id:Int,url:String)->CGFloat{
        var _topSize:CGFloat = y
        let _textLabelView:QZHUILabelView = QZHUILabelView()
        if y == 0{
            _textLabelView.setLabelView(0, y, 190*PX, 100*PX, NSTextAlignment.center, myColor().grayF0(), myColor().blue007aff(), 26, title)
            _textLabelView.restorationIdentifier = "sel"
        }else{
            _textLabelView.setLabelView(0, y, 190*PX, 100*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, title)
            _textLabelView.restorationIdentifier = "unSel"
        }
        
        _textLabelView.tag = id
        let urlView:QZHUILabelView = QZHUILabelView()
        urlView.restorationIdentifier = url
        urlView.isHidden = true
        _textLabelView.addSubview(urlView)
        _textLabelView.addOnClickLister(target: self, action: #selector(self.selectFristSort(_:)))
        leftSort.addSubview(_textLabelView)
        _topSize = _topSize + 100*PX
        leftSort.contentSize = CGSize(width:190*PX,height:_topSize)
        _topSize = _topSize + 1
        return _topSize
    }
    // 设置一级分类项样式
    func setupLeftSortItemUI(){
        let textArray:[UIView] = leftSort.subviews
        for i in 0..<textArray.count{
            if textArray[i].superclass == UILabel.self {
                (textArray[i] as! QZHUILabelView).textColor = myColor().gray3()
                (textArray[i] as! QZHUILabelView).backgroundColor = UIColor.white
                (textArray[i] as! QZHUILabelView).restorationIdentifier = "unSel"
            }
        }
    }
    
    // 设置二级分类容器
    func setupRightSort(){
        rightSort.setupScrollerView(x: 190*PX, y: 129*PX, width: SCREEN_WIDTH-190*PX, height: SCREEN_HEIGHT-225*PX, background: myColor().grayF0())
        rightSort.contentSize = CGSize(width:rightSort.width,height:rightSort.height)
        self.view.addSubview(rightSort)
    }
    
    // 设置二级分类容器广告位
    func setupAD(pic:String){
        // 设置图片 UI
        let imgView:UIImageView = UIImageView(frame:CGRect(x:20*PX,y:21*PX,width:520*PX,height:170*PX))
        if pic == ""{
            imgView.image = UIImage(named:"noPic")
        }else{
            imgView.image = UIImage(data: PublicFunction().imgFromURL(pic))
        }
        rightSort.addSubview(imgView)
    }
    
    // 设置二级分类列表项样式
    func setupRightSort(count:Int,id:Int,pic:String,name:String){
        var lineNum:CGFloat = CGFloat(count/3)
        var top:CGFloat = 211*PX + lineNum*(188*PX)
        
        let itemView:QZHUIView = QZHUIView()
        if count%3 == 0{
            itemView.setupViews(x: 20*PX, y: top, width: 174*PX, height: 188*PX, bgColor: UIColor.white)
        }else if count%3 == 1{
            itemView.setupViews(x: 194*PX, y: top, width: 174*PX, height: 188*PX, bgColor: UIColor.white)
        }else if count%3 == 2{
            itemView.setupViews(x: 368*PX, y: top, width: 174*PX, height: 188*PX, bgColor: UIColor.white)
        }
        
        // 设置图片 UI
        let imgView:UIImageView = UIImageView(frame:CGRect(x:22*PX,y:20*PX,width:130*PX,height:130*PX))
        if pic == ""{
            imgView.image = UIImage(named:"noPic")
        }else{
            imgView.image = UIImage(data: PublicFunction().imgFromURL(pic))
        }
        itemView.addSubview(imgView)
        
        // 设置名称 UI
        let nameLabel:QZHUILabelView = QZHUILabelView()
        nameLabel.setLabelView(15*PX, 160*PX, 144*PX, 28*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 20, name)
        itemView.addSubview(nameLabel)
        
        itemView.tag = id
        
        itemView.addOnClickLister(target: self, action: #selector(self.gotoProList(_:)))
        
        
        rightSort.addSubview(itemView)
        rightSort.contentSize = CGSize(width:rightSort.width,height:top+188*PX)
    }
}

//MARK:- 表格数据源方法，具体的数据源方法实现，不需要 super
extension QZH_CYSQSortViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 15
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    /// 捕捉滚动条动作
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}


// - MARK: 设置监听方法
extension QZH_CYSQSortViewController{
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //搜索页面跳转
    func goToSearch(){
        let nav = QZHSearchViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 一级分类选中监听方法
    func selectFristSort(_ sender:UITapGestureRecognizer){
        let _thisView:QZHUILabelView = sender.view as! QZHUILabelView
        
        if _thisView.restorationIdentifier == "unSel"{
            self.setupLeftSortItemUI()
            _thisView.textColor = myColor().blue007aff()
            _thisView.backgroundColor = myColor().grayF0()
            
            _thisView.restorationIdentifier = "sel"

            let chilrenviews = self.rightSort.subviews
            
            for chilren in chilrenviews {
                
                chilren.removeFromSuperview()
                
            }
            
            QZH_CYSQSort_SecondModel.parentId = _thisView.tag
            let url:UIView = _thisView.subviews[0]
            self.setupAD(pic: url.restorationIdentifier!)
            self.loadSecondSort()
            
        }
    }
   
    // 跳转至产品列表页
    func gotoProList(_ sender:UITapGestureRecognizer){
    
    }
}
