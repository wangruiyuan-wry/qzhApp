//
//  QZHFocusStoreViewController.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHFocusStoreViewController: QZHBaseViewController {
    
    // 关注店铺列表视图模型懒加载
    lazy var storeStatus = QZHFocusStoreListViewModel()
    
    // 店铺信息数据列表视图模型
    lazy var StoreInfo = QZHStoreIndexViewModel()
    
    var noList:QZHUIView = QZHUIView()
    
    // 操作结果显示
    var timer:Timer!
    var resultView:QZHUIView = QZHUIView()
    
    override func loadData() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    func getData(){
        self.storeStatus.loadList(pullup: self.isPulup) { (isSuccess, shouldRefresh) in
            //结束刷新控件
            self.refreahController?.endRefreshing()
            
            //恢复上拉刷新标记
            self.isPulup = false
            
            //刷新表
            if shouldRefresh {
                if self.storeStatus.storeStatus.count > 0{
                    self.tabbelView?.reloadData()
                    self.noList.isHidden = true
                    self.tabbelView?.isHidden = false
                }else{
                    self.tabbelView?.isHidden = true
                    self.noList.isHidden = false
                }
                
                
            }

        }
    }
    
}

// MARK: - 设置页面 UI 样式
extension QZHFocusStoreViewController{
    override func setupUI() {
        super.setupUI()
        //tabbelView = UITableView(frame:view.bounds,style:.plain)
        setStatusBarBackgroundColor(color: .white)
        self.isPush = true
        tabbelView?.separatorStyle = .none
        tabbelView?.y = 58*PX
        tabbelView?.backgroundColor = UIColor.white
        //注册 tableView
        tabbelView?.register(UINib(nibName:"QZHFocusStoreCell",bundle:nil), forCellReuseIdentifier: cellId)
        setupNavTitle()
    }
    func setupNavTitle(){
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        self.title = "关注店铺"
        
        noList.setupNoList(y: 129*PX, str: "你还没有关注店铺")
        noList.isHidden = true
        self.view.addSubview(noList)
    }

}

// MARK: - 数据源绑定
extension QZHFocusStoreViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storeStatus.storeStatus.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHFocusStoreCell
        let store = self.storeStatus.storeStatus[indexPath.row].status
        
        if store.storeLogo == ""{
            cell.storeImg.image = UIImage(named:"noPic")
        }else{
            if let url = URL(string: store.storeLogo) {
                cell.storeImg.downloadedFrom(url: url)
            }else{
                cell.storeImg.image = UIImage(named:"noPic")
            }
        }
        
        cell.storeName.text = store.shortName
        
        if store.storeLevelLogo == ""{
            cell.levelImg.image = UIImage(named:"noPic")
        }else{
            if let url = URL(string: store.storeLevelLogo) {
                cell.levelImg.downloadedFrom(url: url)
            }else{
                cell.levelImg.image = UIImage(named:"noPic")
            }
        }
        
        cell.level.text = store.memberLevel
        
        cell.cancelBtn.tag = store.id
        cell.tag = store.memberId
        cell.addOnClickLister(target: self, action: #selector(self.gotoStroe(_:)))
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "取消"
     }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete {
            let cell = tableView.cellForRow(at: indexPath) as! QZHFocusStoreCell
            QZHStoreInfoModel.storeId = cell.cancelBtn.tag
            self.StoreInfo.delet { (isSuccess) in
                if isSuccess{
                    self.resultView.opertionSuccess("取消成功", isSuccess)
                    
                }else{
                    self.resultView.opertionSuccess("取消失败", isSuccess)
                }
                self.view.addSubview(self.resultView)
                self.resultView.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
                self.getData()
                tableView.reloadData()
            }

        }
     }
}

// MARK: - 监听方法
extension QZHFocusStoreViewController{
    //返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    
    // 操作结果图层消失
    func resultViewXS(){
        resultView.isHidden = true
        resultView.subviews.map{ $0.removeFromSuperview()}
    }
    
    // 进入店铺详情
    func gotoStroe(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHStoreInfoModel.memberID = (this?.tag)!
        
        let nav = QZHStoreIndexViewController()
        present(nav, animated: true, completion: nil)
    }
}
