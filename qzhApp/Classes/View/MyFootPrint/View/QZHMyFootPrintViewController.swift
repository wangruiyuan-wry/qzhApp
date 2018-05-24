//
//  QZHMyFootPrintViewController.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHMyFootPrintViewController: QZHBaseViewController {
    // 足迹列表视图模型懒加载
    lazy var status = QZHMyFootPrintProListViewModel()
    
    var ids:String = ""
    
    // 底部设置
    var bottom:QZHUIView = QZHUIView()
    var checkAllIcon:UIImageView = UIImageView()
    
    // 操作结果显示
    var timer:Timer!
    var resultView:QZHUIView = QZHUIView()
    
    var nolist:QZHUIView = QZHUIView()
    
    override func loadData() {
        getData()
    }
    
    func getData(){
        self.status.loadFootPrint { (isSuccess, shouldRefresh) in
            //结束刷新控件
            self.refreahController?.endRefreshing()
            
            //刷新表
            if shouldRefresh {
                if self.status.footStatus.count > 0{
                     self.tabbelView?.reloadData()
                    self.tabbelView?.isHidden = false
                    self.nolist.isHidden = true
                }else{
                    self.tabbelView?.isHidden = true
                    self.nolist.isHidden = false
                }
               
                
            }

        }
    }
}

// MARK: - 设置页面 UI 样式
extension QZHMyFootPrintViewController{
    override func setupUI() {
        super.setupUI()
        //tabbelView = UITableView(frame:view.bounds,style:.plain)
        self.isPush = true
        tabbelView?.separatorStyle = .none
        tabbelView?.y = 58*PX
        tabbelView?.backgroundColor = UIColor.white
        //注册 tableView
        tabbelView?.register(UINib(nibName:"QZHFootPrintCell",bundle:nil), forCellReuseIdentifier: cellId)
        setupNavTitle()
        setupBottom()
    }
    
    // 设置头部导航栏
    func setupNavTitle(){
        navItem.rightBarButtonItem = UIBarButtonItem(title: "管理", img: "", target: self, action: #selector(self.manage))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        
        self.title = "我的足迹"
        nolist.setupNoList(y: 129*PX, str: "你还没有足迹")
        nolist.isHidden = true
        self.view.addSubview(nolist)
    }
    
    // 设置底部
    func setupBottom(){
        bottom.setupViews(x: 0, y: SCREEN_HEIGHT-100*PX, width: SCREEN_WIDTH, height: 100*PX, bgColor: UIColor.white)
        bottom.isHidden = true
        self.view.addSubview(bottom)
        
        let checkAll:QZHUIView = QZHUIView()
        checkAll.setupViews(x: 0, y: 0, width: 375*PX, height: 100*PX, bgColor: UIColor.white)
        bottom.addSubview(checkAll)
        checkAll.addOnClickLister(target: self, action: #selector(self.checkAll))
        
        checkAllIcon.frame = CGRect(x:120*PX,y:32*PX,width:36*PX,height:36*PX)
        checkAllIcon.image = UIImage(named:"CarSel")
        checkAll.addSubview(checkAllIcon)
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(186*PX, 30*PX, 65*PX, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 28, "全选")
        checkAll.addSubview(label)
        
        
        let del:QZHUILabelView = QZHUILabelView()
        del.setLabelView(375*PX, 0, 375*PX, 100*PX, NSTextAlignment.center, myColor().blue007aff(), UIColor.white, 28, "删除")
        del.addOnClickLister(target: self, action: #selector(self.del))
        bottom.addSubview(del)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 0, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        bottom.addSubview(line)
        
    }
}

// MARK: - 数据源绑定
extension QZHMyFootPrintViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = self.status.footStatus.count/3
        if self.status.footStatus.count % 3 != 0{
            count = count+1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 333*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHFootPrintCell
        let row = indexPath.row*3
        let proInfo1 = self.status.footStatus[row].status
        if proInfo1.pic == ""{
            cell.proImg1.image = UIImage(named:"noPic")
        }else{
            if let url = URL(string: proInfo1.pic.components(separatedBy: ",")[0]) {
                cell.proImg1.downloadedFrom(url: url)
            }else{
                cell.proImg1.image = UIImage(named:"noPic")
            }
        }
        cell.price1.text = "\(proInfo1.fixedPrice.roundTo(places: 2))"
        cell.price1.setRealWages(cell.price1.text!, big: 28, small: 20, fg: ".")
        cell.pro1.tag = proInfo1.id
        cell.check1.tag = proInfo1.myFootId
        cell.pro1.addOnClickLister(target: self, action: #selector(self.goToProDetail1(_:)))
        
        if self.status.footStatus.count <= row+1{
            cell.pro2.isHidden = true
            cell.pro3.isHidden = true
        }else{
            let proInfo2 = self.status.footStatus[row+1].status
            if proInfo2.pic == ""{
                cell.proImg2.image = UIImage(named:"noPic")
            }else{
                if let url = URL(string: proInfo2.pic.components(separatedBy: ",")[0]) {
                    cell.proImg2.downloadedFrom(url: url)
                }else{
                    cell.proImg2.image = UIImage(named:"noPic")
                }
            }
            cell.price2.text = "\(proInfo2.fixedPrice.roundTo(places: 2))"
            cell.price2.setRealWages(cell.price2.text!, big: 28, small: 20, fg: ".")
            cell.pro2.tag = proInfo2.id
            cell.check2.tag = proInfo2.myFootId
            cell.pro2.addOnClickLister(target: self, action: #selector(self.goToProDetail1(_:)))
            
            if self.status.footStatus.count <= row+2{
                cell.pro3.isHidden = true
            }else{
                let proInfo3 = self.status.footStatus[row+2].status
                if proInfo3.pic == ""{
                    cell.proImg3.image = UIImage(named:"noPic")
                }else{
                    if let url = URL(string: proInfo3.pic.components(separatedBy: ",")[0]) {
                        cell.proImg3.downloadedFrom(url: url)
                    }else{
                        cell.proImg3.image = UIImage(named:"noPic")
                    }
                }
                cell.price3.text = "\(proInfo3.fixedPrice.roundTo(places: 2))"
                cell.price3.setRealWages(cell.price3.text!, big: 28, small: 20, fg: ".")
                cell.pro3.tag = proInfo3.id
                cell.check3.tag = proInfo3.myFootId
                cell.pro3.addOnClickLister(target: self, action: #selector(self.goToProDetail1(_:)))
            }
        }
        return cell
    }
}

// MARK: - 监听方法
extension QZHMyFootPrintViewController{
    //返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 管理
    func manage(){
        navItem.rightBarButtonItem = UIBarButtonItem(title: "完成", img: "", target: self, action: #selector(self.save))
        tabbelView?.height = (tabbelView?.height)! - 100*PX
        self.bottom.isHidden = false
        let cells = tabbelView?.visibleCells
        for cell in cells!{
            let _cellCollect = cell as! QZHFootPrintCell
            _cellCollect.check1.isHidden = false
            _cellCollect.check2.isHidden = false
            _cellCollect.check3.isHidden = false
            _cellCollect.pro1.addOnClickLister(target: self, action: #selector(self.check(_:)))
            if !_cellCollect.pro2.isHidden{
                _cellCollect.pro2.addOnClickLister(target: self, action: #selector(self.check(_:)))
            }
            if !_cellCollect.pro3.isHidden{
                _cellCollect.pro3.addOnClickLister(target: self, action: #selector(self.check(_:)))
            }
        }
        
    }
    
    // 完成
    func save(){
        navItem.rightBarButtonItem = UIBarButtonItem(title: "管理", img: "", target: self, action: #selector(self.manage))
        tabbelView?.height = (tabbelView?.height)! + 100*PX
        self.bottom.isHidden = true
        let cells = tabbelView?.visibleCells
        for cell in cells!{
            let _cellCollect = cell as! QZHFootPrintCell
            _cellCollect.check1.isHidden = true
            _cellCollect.check2.isHidden = true
            _cellCollect.check3.isHidden = true
            _cellCollect.pro1.addOnClickLister(target: self, action: #selector(self.goToProDetail1(_:)))
            if !_cellCollect.pro2.isHidden{
                _cellCollect.pro2.addOnClickLister(target: self, action: #selector(self.goToProDetail1(_:)))
            }
            if !_cellCollect.pro3.isHidden{
                _cellCollect.pro3.addOnClickLister(target: self, action: #selector(self.goToProDetail1(_:)))
            }
        }
    }
    
    // 筛选
    func check(_ sender:UITapGestureRecognizer){
        let this:UIView! = sender.view
        let cellThis = sender.view?.superview?.superview as!QZHFootPrintCell
        if cellThis.pro1.tag == this!.tag{
            if this?.restorationIdentifier != "sel"{
                this?.restorationIdentifier = "sel"
                cellThis.check1.image = UIImage(named:"CarSel1")
            }else{
                this?.restorationIdentifier = ""
                cellThis.check1.image = UIImage(named:"CarSel")
            }
        }else if cellThis.pro2.tag == this?.tag{
            if this?.restorationIdentifier != "sel"{
                this?.restorationIdentifier = "sel"
                cellThis.check2.image = UIImage(named:"CarSel1")
            }else{
                this?.restorationIdentifier = ""
                cellThis.check2.image = UIImage(named:"CarSel")
            }
        }else if cellThis.pro3.tag == this?.tag{
            if this?.restorationIdentifier != "sel"{
                this?.restorationIdentifier = "sel"
                cellThis.check3.image = UIImage(named:"CarSel1")
            }else{
                this?.restorationIdentifier = ""
                cellThis.check3.image = UIImage(named:"CarSel")
            }
        }
        
        let cells = tabbelView?.visibleCells
        var selFlag:Bool = true
        ids = ""
        for cell in cells!{
            let _cellCollect = cell as! QZHFootPrintCell
            
            if _cellCollect.pro1.restorationIdentifier == "sel"{
                if ids != ""{
                    ids = "\(ids),"
                }
                ids = "\(ids)\(_cellCollect.check1.tag)"
            }else if !_cellCollect.pro1.isHidden{
                selFlag = false
            }
            if _cellCollect.pro2.restorationIdentifier == "sel"{
                if ids != ""{
                    ids = "\(ids),"
                }
                ids = "\(ids)\(_cellCollect.check2.tag)"
            }else if !_cellCollect.pro2.isHidden{
                selFlag = false
            }
            if _cellCollect.pro3.restorationIdentifier == "sel"{
                if ids != ""{
                    ids = "\(ids),"
                }
                ids = "\(ids)\(_cellCollect.check3.tag)"
            }else if !_cellCollect.pro3.isHidden{
                selFlag = false
            }
        }
        if selFlag{
            checkAllIcon.restorationIdentifier = "sel"
            checkAllIcon.image = UIImage(named:"CarSel1")
        }else{
            checkAllIcon.restorationIdentifier = ""
            checkAllIcon.image = UIImage(named:"CarSel")
        }
    }
    
    // 全选
    func checkAll(){
        let cells = tabbelView?.visibleCells
        if checkAllIcon.restorationIdentifier != "sel"{
            checkAllIcon.restorationIdentifier = "sel"
            checkAllIcon.image = UIImage(named:"CarSel1")
            for cell in cells!{
                let _cellCollect = cell as! QZHFootPrintCell
                _cellCollect.check1.image = UIImage(named:"CarSel1")
                _cellCollect.pro1.restorationIdentifier = "sel"
                if ids != ""{
                    ids = "\(ids),"
                }
                ids = "\(ids)\(_cellCollect.check1.tag)"
                
                if !_cellCollect.pro2.isHidden{
                    _cellCollect.pro2.restorationIdentifier = "sel"
                    _cellCollect.check2.image = UIImage(named:"CarSel1")
                    if ids != ""{
                        ids = "\(ids),"
                    }
                    ids = "\(ids)\(_cellCollect.check2.tag)"
                }
                if !_cellCollect.pro3.isHidden{
                    _cellCollect.pro3.restorationIdentifier = "sel"
                    _cellCollect.check3.image = UIImage(named:"CarSel1")
                    if ids != ""{
                        ids = "\(ids),"
                    }
                    ids = "\(ids)\(_cellCollect.check3.tag)"
                }
            }
            
        }else{
            checkAllIcon.restorationIdentifier = ""
            checkAllIcon.image = UIImage(named:"CarSel")
            ids = ""
            for cell in cells!{
                let _cellCollect = cell as! QZHFootPrintCell
                _cellCollect.check1.image = UIImage(named:"CarSel")
                if !_cellCollect.pro2.isHidden{
                    _cellCollect.pro2.restorationIdentifier = ""
                    _cellCollect.check2.image = UIImage(named:"CarSel")
                }
                if !_cellCollect.pro3.isHidden{
                    _cellCollect.pro3.restorationIdentifier = ""
                    _cellCollect.check3.image = UIImage(named:"CarSel")
                }
            }
            
        }
    }
    
    // 产品详情
    func goToProDetail1(_ sender:UITapGestureRecognizer){
        let _this = sender.view
        QZHProductDetailModel.goodsId = (_this?.tag)!
        
        let nav = QZHProductDetailViewController()
        present(nav, animated: true, completion: nil)
        
    }
    
    // 操作结果图层消失
    func resultViewXS(){
        resultView.isHidden = true
        resultView.subviews.map{ $0.removeFromSuperview()}
    }
    
    // 删除
    func del(){
        QZHMyFootPrintProModel.ids = ids
        self.status.delFootPrint{ (isSuccess, msg) in
            self.resultView.opertionSuccess(msg, isSuccess)
            self.view.addSubview(self.resultView)
            self.resultView.isHidden = false
            self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
            self.getData()
            self.tabbelView?.reloadData()
        }
    }

}
