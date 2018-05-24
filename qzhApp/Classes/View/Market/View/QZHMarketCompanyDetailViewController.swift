//
//  QZHMarketCompanyDetailViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/3.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit
import PagingMenuController

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

// 分配选项卡菜单配置
private struct PagingMenuOptions:PagingMenuControllerCustomizable{
    var menuHeight:CGFloat = 80*PX
    
    // 设置默认显示第一页
    var defaultPage: Int = 0
    
    // lazyLoadingPage的页面数量（默认就是.three）
    var lazyLoadingPage: LazyLoadingPage = .three
    
    //
    var menuControllerSet: MenuControllerSet = .multiple
    
    
    // 企业介绍控制器
    private let infoConroller = QZHCompanyInfoViewController()
    
    //联系方式控制器
    private let contactController = QZHCompanyContactViewController()
    
    //企业产品控制器
    private let proController = QZHCompanyProViewController()
    
    //组件类型
    var componentType: ComponentType{
        return .all(menuOptions: MenuOptions(), pagingControllers:pagingControllers)
    }
    
    //所有子控制器
    fileprivate var pagingControllers:[UIViewController]{
        return [infoConroller,contactController,proController]
    }
    
    
    //菜单配置项
    fileprivate struct MenuOptions:MenuViewCustomizable{
        
        var backgroundColor: UIColor = UIColor.white
        
        // 高度
        var height: CGFloat = 80*PX
        
        // 页面切换动画播放时间为0.5秒
        var animationDuration: TimeInterval = 0.5
        
        // 不允许手指左右滑动
        var isScrollEnabled: Bool = false
        
        // 菜单切换动画减速
        var deceleratingRate: CGFloat = UIScrollViewDecelerationRateFast
        
        // 菜单选中样式
        var focusMode: MenuFocusMode = .underline(height: 1*PX, color: myColor().blue007aff(), horizontalPadding: 0, verticalPadding: 0)
        
        // 菜单位置
        var menuPosition: MenuPosition = .top
        
        // 设置标签之间分割线
        var dividerImage: UIImage? = UIImage(named:"tabDiver")
        
        // 菜单显示的模式
        var displayMode:MenuDisplayMode{
            return .segmentedControl
        }
        
        
        
        // 菜单项
        var itemsOptions: [MenuItemViewCustomizable]{
            return [InfoItem(),ContactItem(),ProItem()]
        }
    }
    
    // 企业介绍菜单
    fileprivate struct InfoItem:MenuItemViewCustomizable{
        
        // 自定义菜单项名称
        var displayMode: MenuItemDisplayMode{
            return .text(title:MenuItemText(text:"企业介绍",color:UIColor.black,selectedColor:myColor().blue007aff(),font:UIFont.systemFont(ofSize: 30*PX),selectedFont:UIFont.systemFont(ofSize: 30*PX) ))
            //.text(title: MenuItemText(text:"企业介绍"))
        }
    }
    
    // 联系我们菜单
    fileprivate struct ContactItem:MenuItemViewCustomizable{
        // 自定义菜单项名称
        var displayMode: MenuItemDisplayMode{
            return .text(title:MenuItemText(text:"联系我们",color:UIColor.black,selectedColor:myColor().blue007aff(),font:UIFont.systemFont(ofSize: 30*PX),selectedFont:UIFont.systemFont(ofSize: 30*PX) ))
        }
    }
    
    // 企业产品菜单
    fileprivate struct ProItem:MenuItemViewCustomizable{
        // 自定义菜单项名称
        var displayMode: MenuItemDisplayMode{
            return .text(title:MenuItemText(text:"企业产品",color:UIColor.black,selectedColor:myColor().blue007aff(),font:UIFont.systemFont(ofSize: 30*PX),selectedFont:UIFont.systemFont(ofSize: 30*PX) ))
        }
    }
}

//菜单显示模式


class QZHMarketCompanyDetailViewController: QZHBaseViewController {
    
    lazy var companyStatus = QZHMarketCompanyListViewModel()
    
    // 收藏
    var scView:QZHUIView = QZHUIView()
    var whiteBg:QZHUIView = QZHUIView()
    
    // 收藏结果
    var scResult1:QZHUIView = QZHUIView()
    var scResult2:QZHUIView = QZHUIView()
    
    var timer:Timer!
    
    // 加载的数据
    override func loadData() {
    }
}

// 界面设置
extension QZHMarketCompanyDetailViewController{
    override func setupUI() {
        super.setupUI()
        
        //设置导航栏按钮
        setupNavTitle()
        
        //注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tabbelView?.isHidden = true
        
        setupTab()
        
        setupSC()
    }
    
    // 设置头部导航栏
    func setupNavTitle(){
        navItem.rightBarButtonItem = UIBarButtonItem(title: "收藏", img: "Market_SC", target: self, action: #selector(companySC))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        
        self.title = QZHMarketCompanyInfoModel.companyName
    }
    
    //添加头部选项卡
    func setupTab(){
        //分页菜单配置
        let options = PagingMenuOptions()
        
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options:options)
        
        
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 128*PX+1
        pagingMenuController.view.frame.size.height -= 128*PX+1
        
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                pagingMenuController.view.frame.origin.y += 48*PX+1
                pagingMenuController.view.frame.size.height -= 48*PX+1
            }
            
        } else {
            // Fallback on earlier versions
        }
        
        //建立父子关系
        addChildViewController(pagingMenuController)
        
        //分页菜单控制器视图添加到当前视图
        view.addSubview(pagingMenuController.view)
        
    }
    
    // 设置收藏
    func setupSC(){
        whiteBg.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT, bgColor: UIColor.clear)
        whiteBg.isHidden = true
        self.whiteBg.addOnClickLister(target: self, action: #selector(self.ycSC))
        self.view.addSubview(whiteBg)
        
        scView.setupViews(x: 530*PX, y: 100*PX, width: 220*PX, height: 298*PX, bgColor: UIColor.clear)
        scView.backgroundColor = UIColor(patternImage: UIImage(named:"Market_CollectBG")!)
        scView.isHidden = true
        self.view.addSubview(scView)
        
        // 供应商
        let gys:QZHUILabelView = QZHUILabelView()
        gys.setLabelView(40*PX, 58*PX, 140*PX, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 28, "供应商")
        gys.addOnClickLister(target: self, action: #selector(self.addCollection(_:)))
        gys.restorationIdentifier = gys.text
        scView.addSubview(gys)
        let lin1:QZHUILabelView = QZHUILabelView()
        lin1.dividers(40*PX, y: 118*PX, width: 140*PX, height: 2*PX, color: myColor().grayEB())
        scView.addSubview(lin1)
        
        // 同行
        let th:QZHUILabelView = QZHUILabelView()
        th.setLabelView(40*PX, 138*PX, 140*PX, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 28, "同行")
        th.addOnClickLister(target: self, action: #selector(self.addCollection(_:)))
        th.restorationIdentifier = th.text
        scView.addSubview(th)
        let lin2:QZHUILabelView = QZHUILabelView()
        lin2.dividers(40*PX, y: 198*PX, width: 140*PX, height: 2*PX, color: myColor().grayEB())
        scView.addSubview(lin2)
        
        // 客户
        let kh:QZHUILabelView = QZHUILabelView()
        kh.setLabelView(40*PX, 218*PX, 140*PX, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 28, "客户")
        kh.addOnClickLister(target: self, action: #selector(self.addCollection(_:)))
        kh.restorationIdentifier = kh.text
        scView.addSubview(kh)
        
        // 收藏果
        scResult1.setupViews(x: 250*PX, y: 593*PX, width: 250*PX, height: 150*PX, bgColor: UIColor.black)
        scResult1.alpha = 0.5
        self.view.addSubview(scResult1)
        let icon:UIImageView = UIImageView(frame:CGRect(x:97*PX,y:34*PX,width:46*PX,height:33*PX))
        icon.image = UIImage(named:"Market_Collect_Success")
        scResult1.addSubview(icon)
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(0, 85*PX, 250*PX, 40*PX, NSTextAlignment.center, UIColor.clear, UIColor.white, 28, "收藏成功")
        scResult1.addSubview(label)
        
        scResult2.setupViews(x: 250*PX, y: 593*PX, width: 250*PX, height: 150*PX, bgColor: UIColor.black)
        scResult2.alpha = 0.5
        self.view.addSubview(scResult2)
        let icon1:UIImageView = UIImageView(frame:CGRect(x:97*PX,y:34*PX,width:46*PX,height:33*PX))
        icon1.image = UIImage(named:"Market_Collect_Failed")
        scResult2.addSubview(icon1)
        let label1:QZHUILabelView = QZHUILabelView()
        label1.setLabelView(0, 85*PX, 250*PX, 40*PX, NSTextAlignment.center, UIColor.clear, UIColor.white, 28, "收藏成功")
        scResult2.addSubview(label1)
        
        scResult1.isHidden = true
        scResult2.isHidden = true
        
    }
    
}

// MARK: - PagingMenuControllerDelegate
extension QZHMarketCompanyDetailViewController{
    
    func willMoveToMenuPage(page: Int) {
    }
    
    func didMoveToMenuPage(page: Int) {
    }
}

// 监听方法
extension QZHMarketCompanyDetailViewController{
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
       // navigationController?.pushViewController(vc, animated: true)
    }
    
    //返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 收藏
    func companySC(){
        scView.isHidden = false
        whiteBg.isHidden = false
    }
    
    // 隐藏收藏
    func ycSC(){
        scView.isHidden = true
        whiteBg.isHidden = true
        scResult1.isHidden = true
        scResult2.isHidden = true
    }
    
    func addCollection(_ sender:UITapGestureRecognizer){
        let _this = sender.view
        QZHMarketCompanyInfoModel.collectType = (_this?.restorationIdentifier)!
        self.companyStatus.collectCompany { (isSuccess) in
            if isSuccess{
                self.scResult1.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 2, target:self,selector:#selector(self.ycSC),userInfo:nil,repeats:true)
            }else{
                self.scResult2.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 2, target:self,selector:#selector(self.ycSC),userInfo:nil,repeats:true)
            }
        }
    }
}
