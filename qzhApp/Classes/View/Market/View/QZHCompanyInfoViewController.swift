//
//  QZHCompanyInfoViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/3.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHCompanyInfoViewController: QZHBaseViewController {
    
    // 公司信息视图模型懒加载
    lazy var companyStatus = QZHMarketCompanyListViewModel()

    var bodyView:QZHUIView = QZHUIView()
    
    // 企业logo
    var logoView: UIImageView = UIImageView()
    
    // 公司简介
    var infoView:QZHUILabelView = QZHUILabelView()
    
    //主营产品
    var mainPro:QZHUILabelView = QZHUILabelView()
    
    //主购产品
    var purPro:QZHUILabelView = QZHUILabelView()
    
    // 加载数据
    override func loadData() {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.companyStatus.loadCompany { (isSuccess) in
            
            if self.companyStatus.Company[0].status.logo != ""{
                if let url = URL(string: self.companyStatus.Company[0].status.logo) {
                    self.logoView.downloadedFrom(url: url)
                }else{
                    self.logoView.image = UIImage(named:"noPic")
                }
            }else{
                self.logoView.image = UIImage(named:"noPic")
            }
            
            if self.companyStatus.CompanyInfo[0].status.remark != ""{
                self.setupInfo(self.companyStatus.CompanyInfo[0].status.remark)
            }
            if self.companyStatus.Company[0].status.mainProduct != ""{
                self.setupMainPro(self.companyStatus.Company[0].status.mainProduct)
            }
            if self.companyStatus.Company[0].status.purchasingProduct != ""{
                self.setupMainPro(self.companyStatus.Company[0].status.purchasingProduct)
            }
            
            self.tabbelView?.tableHeaderView = self.bodyView
        }
    }
}

// 设置界面
extension QZHCompanyInfoViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        //注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationBar.isHidden = true
        tabbelView?.separatorStyle = .none
        tabbelView?.backgroundColor = UIColor.white
        let line:QZHUILabelView = QZHUILabelView()
        
        line.dividers(0, y: 0, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        view.addSubview(line)
        setupView()
    }
    
    // 设置view界面
    func setupView(){
        bodyView.setupViews(x: 0, y: 1*PX, width: SCREEN_WIDTH, height: SCREEN_HEIGHT, bgColor: UIColor.white)
        
        setupLogo()
        
        setupInfo("暂无公司简")
        
        setupMainPro("暂无主营产品")
        
        setupPurPro("暂无主购产品")
        
    }
    
    // 设置企业 logo
    func setupLogo(){
        logoView.frame = CGRect(x:225*PX,y:30*PX,width:300*PX,height:300*PX)
        logoView.image = UIImage(named:"logoIcon")
        bodyView.height = logoView.height+logoView.y
        bodyView.addSubview(logoView)
        
    }
    
    // 设置公司简介
    func setupInfo(_ text:String){
        let labeltile: QZHUILabelView = QZHUILabelView()
        labeltile.setLabelView(55*PX, logoView.height+logoView.y+44*PX, 640*PX, 32*PX, NSTextAlignment.center, UIColor.clear, UIColor.black, 32, "公司简介")
        bodyView.height = labeltile.height+labeltile.y
        bodyView.addSubview(labeltile)
        
        infoView.setLabelView(55*PX, bodyView.height+30*PX, 640*PX, purPro.autoLabelHeight(text, font: 28, width: 640*PX), NSTextAlignment.center, UIColor.clear, UIColor.black, 28, text)
        infoView.numberOfLines = 0
        infoView.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        bodyView.height = infoView.height+infoView.y
        bodyView.addSubview(infoView)
        
    }
    
    //设置主营产品
    func setupMainPro(_ text:String){
        let labeltile: QZHUILabelView = QZHUILabelView()
        labeltile.setLabelView(55*PX, infoView.height+infoView.y+60*PX, 640*PX, 32*PX, NSTextAlignment.center, UIColor.clear, UIColor.black, 32, "主营产品")
        bodyView.addSubview(labeltile)
        
        mainPro.setLabelView(55*PX, labeltile.height+labeltile.y+30*PX, 640*PX, purPro.autoLabelHeight(text, font: 28, width: 640*PX), NSTextAlignment.center, UIColor.clear, UIColor.black, 28, text)
        mainPro.numberOfLines = 0
        mainPro.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        bodyView.height = mainPro.height+mainPro.y
        bodyView.addSubview(mainPro)
    }
    
    //设置主购产品
    func setupPurPro(_ text:String){
        let labeltile: QZHUILabelView = QZHUILabelView()
        labeltile.setLabelView(55*PX, mainPro.height+mainPro.y+60*PX, 640*PX, 32*PX, NSTextAlignment.center, UIColor.clear, UIColor.black, 32, "主购产品")
        bodyView.addSubview(labeltile)
        
        purPro.setLabelView(55*PX, labeltile.height+labeltile.y+30*PX, 640*PX, purPro.autoLabelHeight(text, font: 28, width: 640*PX), NSTextAlignment.center, UIColor.clear, UIColor.black, 28, text)
        purPro.numberOfLines = 0
        purPro.lineBreakMode = NSLineBreakMode.byTruncatingTail 
        bodyView.height = purPro.height+purPro.y+20
        bodyView.addSubview(purPro)
    }
}

// MARK: - 数据源绑定
extension QZHCompanyInfoViewController{
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
