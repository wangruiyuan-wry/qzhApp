//
//  QZHEnterpriseDetail.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/16.
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
    var defaultPage: Int = 1
 
    // lazyLoadingPage的页面数量（默认就是.three）
     var lazyLoadingPage: LazyLoadingPage = .three
 
    //
    var menuControllerSet: MenuControllerSet = .multiple
 
 
    // 企业介绍控制器
    private let infoConroller = QZHEnterpriseInfoViewController()
 
    //联系方式控制器
    private let contactController = QZHEnterpriseContactViewController()
 
    //企业产品控制器
    private let proController = QZHEnterpriseProViewController()
 
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


class QZHEnterpriseDetail: QZHBaseViewController {
    // 加载的数据
    override func loadData() {
    }
}

// 界面设置
extension QZHEnterpriseDetail{
    override func setupUI() {
        super.setupUI()
        
        //设置导航栏按钮
        setupNavTitle()
        
        //注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tabbelView?.isHidden = true
        
        setupTab()
    }
    
    // 设置头部导航栏
    func setupNavTitle(){
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "", target: self, action: #selector(showFriends))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))

        self.title = QZHEnterpriseDetailModel.name
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
                pagingMenuController.view.frame.origin.y += 176*PX+1
                pagingMenuController.view.frame.size.height -= 176*PX+1
            }
            
        } else {
            // Fallback on earlier versions
        }
        
        //建立父子关系
        addChildViewController(pagingMenuController)
        
        //分页菜单控制器视图添加到当前视图
        view.addSubview(pagingMenuController.view)
    }
    
}

// MARK: - PagingMenuControllerDelegate
extension QZHEnterpriseDetail{
    
    func willMoveToMenuPage(page: Int) {
    }
    
    func didMoveToMenuPage(page: Int) {
    }
}

// 监听方法
extension QZHEnterpriseDetail{
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    //返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
}
