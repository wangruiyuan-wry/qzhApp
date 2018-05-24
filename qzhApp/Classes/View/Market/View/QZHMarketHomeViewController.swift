//
//  QZHMarketHomeViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/3.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHMarketHomeViewController: QZHBaseViewController {
    lazy var tokenLogin = LoginViewModels()
    var body:QZHUIView = QZHUIView()
    override func loadData() {
        self.refreahController?.endRefreshing()
    }
}

// MARK: - 设置页面 UI 样式
extension QZHMarketHomeViewController{
    override func setupUI() {
        super.setupUI()
        setupNav()
        //注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tabbelView?.separatorStyle = .none
        tabbelView?.y = 128*PX
        tabbelView?.height = SCREEN_HEIGHT - 128*PX
        tabbelView?.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                tabbelView?.y = 176*PX
                tabbelView?.height = SCREEN_HEIGHT - 176*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        
        
        setupBody()
    }
    
    // 设置头部
    func setupNav(){
        let topView:QZHUILabelView = QZHUILabelView()
        topView.setLabelView(0, 19*PX, SCREEN_WIDTH, 50*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 36, "市场推广")
        navItem.titleView = topView 
    }
    
    // 设置页面内容
    func setupBody(){
        
        // 设置我的供应商
        let gysIcon:UIImageView = UIImageView(frame:CGRect(x:166*PX,y:71*PX,width:89*PX,height:89*PX))
        gysIcon.image = UIImage(named:"Market_GSY")
        self.setBtn(y: 40*PX, icon: gysIcon, title: "我的供应商", tag: 1, color: myColor().yellowE8a53a())
        
        // 设置我的客户
        let khIcon:UIImageView = UIImageView(frame:CGRect(x:163*PX,y:71*PX,width:94*PX,height:89*PX))
        khIcon.image = UIImage(named:"Market_KH")
        self.setBtn(y: 305*PX, icon: khIcon, title: "我的客户", tag: 2, color: myColor().redE55775())
        
        // 设置我的同行
        let thIcon:UIImageView = UIImageView(frame:CGRect(x:162*PX,y:67*PX,width:96*PX,height:97*PX))
        thIcon.image = UIImage(named:"Market_TH")
        self.setBtn(y: 570*PX, icon: thIcon, title: "我的同行", tag: 3, color: myColor().yellowE65e2e())
        
        // 找企业
        let findIcon:UIImageView = UIImageView(frame:CGRect(x:162*PX,y:67*PX,width:96*PX,height:96*PX))
        findIcon.image = UIImage(named:"Market_Find")
        self.setBtn(y: 835*PX, icon: findIcon, title: "找企业", tag: 4, color: myColor().blue007aff())
        
        tabbelView?.tableHeaderView = body
    }
    
    // 设置跳转按钮
    func setBtn(y:CGFloat,icon:UIImageView,title:String,tag:Int,color:UIColor){
        let GYSBtn:QZHUIView = QZHUIView()
        GYSBtn.setupViews(x: 40*PX, y: y, width: 670*PX, height: 230*PX, bgColor: color)
        GYSBtn.layer.cornerRadius = 10*PX
        GYSBtn.layer.shadowOffset = CGSize.init(width: 3*PX, height: 8*PX)
        GYSBtn.layer.shadowRadius = 26*PX
        GYSBtn.layer.shadowColor = UIColor.black.cgColor
        GYSBtn.layer.shadowOpacity = 0.2
        GYSBtn.tag = tag
        GYSBtn.addOnClickLister(target: self, action: #selector(self.gotoListCompany(_:)))
        GYSBtn.addSubview(icon)
        
        let titleView:QZHUILabelView = QZHUILabelView()
        titleView.setLabelView(320*PX, 90*PX, 201*PX, 50*PX, NSTextAlignment.center, UIColor.clear, UIColor.white, 36, title)
        GYSBtn.addSubview(titleView)
        
        body.addSubview(GYSBtn)
        body.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: GYSBtn.y + 265*PX , bgColor: UIColor.white)
        
    }
}

// MARK: - 数据源绑定
extension QZHMarketHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    /// 捕捉滚动条动作
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
} 

// MARK: - 监听方法
extension QZHMarketHomeViewController{
    // 供应商
    func gotoListCompany(_ sender:UITapGestureRecognizer){
        let _this = sender.view
        if _this?.tag == 1{
            QZHMarketCollectModel.collectType = "供应商"
            QZHMarketCollectModel.area = ""
            QZHMarketCollectModel.comperhensive = 1
            QZHMarketCollectModel.customerStatus = 0
            self.tokenLogin.tokenLogin { (isSuccess) in
                if !isSuccess{
                    let nav = QZHOAuthViewController()
                    self.present(nav, animated: true, completion: nil)
                }else{
                    let nav = QZHMarketCollectViewController()
                    self.present(nav, animated: true, completion: nil)
                }
            }
        }else if _this?.tag == 2{
            QZHMarketCollectModel.area = ""
            QZHMarketCollectModel.comperhensive = 1
            QZHMarketCollectModel.customerStatus = 0
            QZHMarketCollectModel.collectType = "客户"
            self.tokenLogin.tokenLogin { (isSuccess) in
                if !isSuccess{
                    let nav = QZHOAuthViewController()
                    self.present(nav, animated: true, completion: nil)
                }else{
                    let nav = QZHMarketCollectViewController()
                    self.present(nav, animated: true, completion: nil)
                }
            }
        }else if _this?.tag == 3{
            QZHMarketCollectModel.collectType = "同行"
            QZHMarketCollectModel.area = ""
            QZHMarketCollectModel.comperhensive = 1
            QZHMarketCollectModel.customerStatus = 0
            self.tokenLogin.tokenLogin { (isSuccess) in
                if !isSuccess{
                    let nav = QZHOAuthViewController()
                    self.present(nav, animated: true, completion: nil)
                }else{
                    let nav = QZHMarketCollectViewController()
                    self.present(nav, animated: true, completion: nil)
                }
            }
        }else if _this?.tag == 4{
            QZHMarketFindCompanyModel.searchParam = ""
            QZHMarketFindCompanyModel.coprehensive = 1
            QZHMarketFindCompanyModel.area = ""
            QZHMarketFindCompanyModel.industry_type = ""
            QZHMarketFindCompanyModel.enterprise_type = ""
            let nav = QZHMarketFindViewController()
            self.present(nav, animated: true, completion: nil)
        }
    }
}
