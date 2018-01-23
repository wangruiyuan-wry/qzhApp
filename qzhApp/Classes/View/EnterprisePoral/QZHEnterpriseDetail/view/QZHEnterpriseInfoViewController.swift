//
//  QZHEnterpriseInfoViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/17.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHEnterpriseInfoViewController: QZHBaseViewController {
    
    // 企业信息视图模型
    lazy var listViewModel = QZHEnterpriseDetailViewModels()
    
    var bodyView:QZHUIScrollView = QZHUIScrollView()
    
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
        listViewModel.loadInfo { (detail, info, isSuccess) in
            
            _ = self.bodyView.subviews.map{
                $0.removeFromSuperview()
            }
            self.setupLogo()
            
            if !isSuccess{
                self.setupInfo("暂无公司简介")
                
                self.setupMainPro("暂无主营产品")
                
                self.setupPurPro("暂无主购产品")
            }else{
                if detail[0].status.logo != "" {
                    self.logoView.image = UIImage(data:PublicFunction().imgFromURL(detail[0].status.logo!))
                }
                
                if info[0].status.remark != "" {
                    self.setupInfo(info[0].status.remark!)
                }else{
                     self.setupInfo("暂无公司简介")
                }
                
                if detail[0].status.mainProduct != ""{
                    self.setupMainPro(detail[0].status.mainProduct!)
                }else{
                    self.setupMainPro("暂无主营产品")
                }
                
                if detail[0].status.purchasingPro != ""{
                    self.setupPurPro(detail[0].status.purchasingPro!)
                } else{
                    self.setupPurPro("暂无主购产品")
                }
            }
        }
    }
}

// 设置界面
extension QZHEnterpriseInfoViewController{
    override func setupUI() {
        super.setupUI()
        tabbelView?.isHidden = true
        navigationBar.isHidden = true
        let line:QZHUILabelView = QZHUILabelView()
        
        line.divider(0, y: 0, width: Int(SCREEN_WIDTH), height: 1, color: myColor().grayF0())
        view.addSubview(line)
        setupView()
    }
    
    // 设置view界面
    func setupView(){
        bodyView.setupScrollerView(x: 1, y: 2, width: 750*PX, height: SCREEN_HEIGHT-210*PX-1, background: UIColor.white)
        bodyView.contentSize = CGSize(width:640*PX,height:0)
        bodyView.bounces = false
        bodyView.alwaysBounceVertical = false
        view.addSubview(bodyView)
        
        setupLogo()
        
        setupInfo("暂无公司简")
        
        setupMainPro("暂无主营产品")
        
        setupPurPro("暂无主购产品")
        
    }
    
    // 设置企业 logo
    func setupLogo(){
        logoView.frame = CGRect(x:225*PX,y:30*PX,width:300*PX,height:300*PX)
        logoView.image = UIImage(named:"logoIcon")
        bodyView.contentSize = CGSize(width:SCREEN_HEIGHT,height:logoView.height+logoView.y)
        bodyView.addSubview(logoView)

    }
    
    // 设置公司简介
    func setupInfo(_ text:String){
        let labeltile: QZHUILabelView = QZHUILabelView()
        labeltile.setLabelView(55*PX, logoView.height+logoView.y+44*PX, 640*PX, 32*PX, NSTextAlignment.center, UIColor.clear, UIColor.black, 32, "公司简介")
        bodyView.contentSize = CGSize(width:640*PX,height:labeltile.height+labeltile.y)
        bodyView.addSubview(labeltile)
        
        infoView.setLabelView(55*PX, bodyView.contentSize.height+30*PX, 640*PX, purPro.autoLabelHeight(text, font: 28, width: 640*PX), NSTextAlignment.center, UIColor.clear, UIColor.black, 28, text)
        infoView.numberOfLines = 0
        infoView.lineBreakMode = NSLineBreakMode.byWordWrapping
        bodyView.contentSize = CGSize(width:640*PX,height:infoView.height+infoView.y)
        bodyView.addSubview(infoView)
        
    }
    
    //设置主营产品
    func setupMainPro(_ text:String){
        let labeltile: QZHUILabelView = QZHUILabelView()
        labeltile.setLabelView(55*PX, infoView.height+infoView.y+60*PX, 640*PX, 32*PX, NSTextAlignment.center, UIColor.clear, UIColor.black, 32, "主营产品")
        bodyView.addSubview(labeltile)
        
        mainPro.setLabelView(55*PX, labeltile.height+labeltile.y+30*PX, 640*PX, purPro.autoLabelHeight(text, font: 28, width: 640*PX), NSTextAlignment.center, UIColor.clear, UIColor.black, 28, text)
        mainPro.numberOfLines = 0
        mainPro.lineBreakMode = NSLineBreakMode.byWordWrapping
        bodyView.contentSize = CGSize(width:640*PX,height:mainPro.height+mainPro.y)
        bodyView.addSubview(mainPro)
    }
    
    //设置主购产品
    func setupPurPro(_ text:String){
        let labeltile: QZHUILabelView = QZHUILabelView()
        labeltile.setLabelView(55*PX, mainPro.height+mainPro.y+60*PX, 640*PX, 32*PX, NSTextAlignment.center, UIColor.clear, UIColor.black, 32, "主购产品")
        bodyView.addSubview(labeltile)
        
        purPro.setLabelView(55*PX, labeltile.height+labeltile.y+30*PX, 640*PX, purPro.autoLabelHeight(text, font: 28, width: 640*PX), NSTextAlignment.center, UIColor.clear, UIColor.black, 28, text)
        purPro.numberOfLines = 0
        purPro.lineBreakMode = NSLineBreakMode.byWordWrapping
        bodyView.contentSize = CGSize(width:640*PX,height:purPro.height+purPro.y+20)
        bodyView.addSubview(purPro)
    }
}
