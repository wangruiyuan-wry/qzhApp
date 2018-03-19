//
//  QZHStoreSortViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/8.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHStoreSortViewController: QZHBaseViewController {
    
    // 店铺信息数据列表视图模型
    lazy var StoreInfo = QZHStoreIndexViewModel()
    
    // 一级分类
    var headerView:QZHUIView = QZHUIView()
    
    // 全部
    var titleLabel:QZHUILabelView = QZHUILabelView()

    override func loadData() {
        StoreInfo.getStoreSort { (isSuccess,shouldRefresh) in
            //刷新表
            if shouldRefresh {
                
                self.tabbelView?.reloadData()
                
            }
        }
    }
}

// MARK: - 页面 UI 样式
extension QZHStoreSortViewController{
    override func setupUI() {
        super.setupUI()
        
        self.isPush = true
        // 去掉 tableview 分割线
        self.tabbelView?.separatorStyle = .none
        
        // 设置 tabbleView 背景色
        self.tabbelView?.backgroundColor = UIColor.white
        
        // 注册原型 cell
        tabbelView?.register(UINib(nibName:"QZHStoreSortTableViewCell",bundle:nil), forCellReuseIdentifier: cellId)
        tabbelView?.y = 128*PX
        tabbelView?.height = SCREEN_HEIGHT - 128*PX
        tabbelView?.backgroundColor = UIColor.white
        
        // 设置导航条
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends),color:UIColor.white)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon2", target: self, action: #selector(self.close),color:UIColor.white)
        self.title = "店铺分类"
        
        setupHeaderTable()
    }
    
    // 设置表头
    func setupHeaderTable(){
        let headerView:QZHUIView = QZHUIView()
        headerView.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 100*PX, bgColor: myColor().grayF0())
        let btnView:QZHUIView = QZHUIView()
        btnView.setupViews(x: 0, y: 10*PX, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
        btnView.restorationIdentifier = ""
        btnView.addOnClickLister(target: self, action: #selector(self.goToStoreProList(_:)))
        headerView.addSubview(btnView)

        titleLabel.setLabelView(20*PX, 20*PX, 130*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().blue007aff(), 28, "全部商品")
        btnView.addSubview(titleLabel)
        
        let all:QZHUILabelView = QZHUILabelView()
        btnView.addSubview(all)
        all.setLabelView(630*PX, 25*PX, 100*PX, 30*PX, NSTextAlignment.right, UIColor.white, myColor().Gray6(), 22, "查看全部")
        
        tabbelView?.tableHeaderView = headerView
    }
}

// MARK: - 数据源绑定
extension QZHStoreSortViewController{
    //返回表格行数（也就是返回控件数）
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 4
        return self.StoreInfo.storeSort.count
    }
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHStoreSortTableViewCell
        
        
        let _index = QZHStoreSortModel.selectedCellIndexPaths.index(of: indexPath)
        
        if (_index == nil){
            cell.iconOpen.isHidden = true
            cell.icon.isHidden = false
            cell.line.isHidden = false
            cell.line2.isHidden = true
        }else{
            cell.iconOpen.isHidden = false
            cell.icon.isHidden = true
            cell.line.isHidden = true
            cell.line2.isHidden = false
        }
        
        cell.firstName.textColor = cell.firstName.textColor
        cell.firstName.text = self.StoreInfo.storeSort[indexPath.row].status.categoryName
        cell.view2.restorationIdentifier = "\(self.StoreInfo.storeSort[indexPath.row].status.id)"
        QZHStoreSortModel.level2Array = self.StoreInfo.storeSort[indexPath.row].status.level2

        cell.view1.addOnClickLister(target: self, action: #selector(self.openList(_:)))
        
        cell.view2.addOnClickLister(target: self, action: #selector(self.goToStoreProList(_:)))
        
        cell.setupSCDSort(self.StoreInfo.storeSort[indexPath.row].status.level2)
        cell.scdView.viewWithTag(111)?.addOnClickLister(target: self, action: #selector(self.goToStoreProList(_:)))
        
        cell.scdView.subviews.forEach { (this) in
            this.addOnClickLister(target: self, action: #selector(self.goToStoreProList(_:)))
        }
        
        cell.layer.masksToBounds = true
        
        return cell
    }

    // UITableViewDelegate 方法，处理列表项的选中事件
   /* func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cells = tableView.cellForRow(at: indexPath) as! QZHStoreSortTableViewCell
        tabbelView?.deselectRow(at: indexPath, animated: false)
        let index = QZHStoreSortModel.selectedCellIndexPaths.index(of: indexPath)
        
       if  (index == nil){
            QZHStoreSortModel.selectedCellIndexPaths.append(indexPath)
            QZHStoreSortModel.cellHeightArray.append(cells.cellHeight)
        }else{
            QZHStoreSortModel.selectedCellIndexPaths.remove(at: index!)
            QZHStoreSortModel.cellHeightArray.remove(at: index!)
        }
        tableView.reloadRows(at:[indexPath] , with: .automatic)
    }*/
    
    func openList(_ sender:UITapGestureRecognizer){
        let this:QZHUIView = sender.view as! QZHUIView
        let cells = this.superview?.superview as! QZHStoreSortTableViewCell
        let indexPath = self.tabbelView?.indexPath(for: cells)
        tabbelView?.deselectRow(at: indexPath!, animated: false)
        let index = QZHStoreSortModel.selectedCellIndexPaths.index(of: indexPath!)
        
        if  (index == nil){
            QZHStoreSortModel.selectedCellIndexPaths.append(indexPath!)
            QZHStoreSortModel.cellHeightArray.append(cells.cellHeight)
        }else{
            QZHStoreSortModel.selectedCellIndexPaths.remove(at: index!)
            QZHStoreSortModel.cellHeightArray.remove(at: index!)
        }
        tabbelView?.reloadRows(at:[indexPath!] , with: .automatic)
    }
    
    // 更改cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if QZHStoreSortModel.selectedCellIndexPaths.contains(indexPath){
            let cellheight = QZHStoreSortModel.cellHeightArray[QZHStoreSortModel.selectedCellIndexPaths.index(of: indexPath)!]
            return cellheight + 2*PX
        }
        return 82*PX
    }
    //在本列表中，只有一个分区
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// 捕捉滚动条动作
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    // 设置分类默认字体颜色
    func setupCell(){
        let cells = tabbelView?.visibleCells
        for cell in cells!{
            (cell as! QZHStoreSortTableViewCell).firstName.textColor = myColor().gray3()
            let children = (cell as! QZHStoreSortTableViewCell).scdView.subviews
            for child in children{
                (child.viewWithTag(11) as! QZHUILabelView).textColor = myColor().gray3()
            }
        }
    }

}

// MARK: - 监听方法
extension QZHStoreSortViewController{

    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 返回
    func close(){
        QZHStoreSortModel.selectedCellIndexPaths = []
        QZHStoreSortModel.cellHeightArray = []
        dismiss(animated: true, completion: nil)
    }
    
    // 跳转至店铺产品列表
    func goToStoreProList(_ sender:UITapGestureRecognizer){
        let this:UIView = sender.view!
        QZHStoreProModel.q = ""
        QZHStoreProModel.pageNo = 1
        QZHStoreProModel.brand = ""
        QZHStoreProModel.order = 1
        QZHStoreProModel.customCategoryId = this.restorationIdentifier!
        let nav = QZHStore_SearchList_ViewController()
        QZHStoreSearchProModel.fromPage = 0
        present(nav, animated: true, completion: nil)
         setupCell()
        if this.restorationIdentifier! == ""{
            titleLabel.textColor = myColor().blue007aff()
        }else if this.tag == 12{
            let cells = this.superView(of: UITableViewCell.self)! as! QZHStoreSortTableViewCell
            cells.firstName.textColor = myColor().blue007aff()
            titleLabel.textColor = myColor().gray3()
        }else{
            (this.viewWithTag(11) as! QZHUILabelView).textColor =  myColor().blue007aff()
            titleLabel.textColor = myColor().gray3()
        }
    }
}
