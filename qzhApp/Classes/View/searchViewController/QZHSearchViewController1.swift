//
//  QZHSearchViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/23.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit
import PagingMenuController

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

// 分配选项卡菜单配置
private struct PagingMenuOptionsSearch:PagingMenuControllerCustomizable{
    var menuHeight:CGFloat = 82*PX
    
    // 设置默认显示第一页
    var defaultPage: Int = 0
    
    //
    var menuControllerSet: MenuControllerSet = .multiple
    
    
    // 社区商城控制器
    private let SQSC = QZHSearchSQSC()
    
    // 产业商圈控制器
    private let CYSQ = QZHSearchCYSQ()
    
    //企业门户控制器
    private let QYMH = QZHSearchQYMH()
    
    //积分优购控制器
    private let JFYG = QZHSearchJFYG()
    
    //组件类型
    var componentType: ComponentType{
        return .all(menuOptions: MenuOptions(), pagingControllers:pagingControllers)
    }
    
    //所有子控制器
    fileprivate var pagingControllers:[UIViewController]{
        return [SQSC,CYSQ,QYMH,JFYG]
    }
    
    
    //菜单配置项
    fileprivate struct MenuOptions:MenuViewCustomizable{
        
        var backgroundColor: UIColor = UIColor.white
        
        // 高度
        var height: CGFloat = 82*PX
        
        // 页面切换动画播放时间为0.5秒
        var animationDuration: TimeInterval = 0.5
        
        // 不允许手指左右滑动
        var isScrollEnabled: Bool = false
        
        // 菜单切换动画减速
        var deceleratingRate: CGFloat = UIScrollViewDecelerationRateFast
        
        // 菜单选中样式
        var focusMode: MenuFocusMode = .underline(height: 2*PX, color: myColor().blue007aff(), horizontalPadding: 0, verticalPadding: 0)
        
        // 菜单位置
        var menuPosition: MenuPosition = .top
        
        // 菜单显示的模式
        var displayMode:MenuDisplayMode{
            return .segmentedControl
        }
        
        
        
        // 菜单项
        var itemsOptions: [MenuItemViewCustomizable]{
            return [SQSCItem(),CYSQItem(),QYMHItem(),JFYGItem()]
        }
    }
    
    // 社区商城菜单
    fileprivate struct SQSCItem:MenuItemViewCustomizable{
        
        // 自定义菜单项名称
        var displayMode: MenuItemDisplayMode{
            return .text(title:MenuItemText(text:"社区商城",color:myColor().Gray0D(),selectedColor:myColor().blue007aff(),font:UIFont.systemFont(ofSize: 28*PX),selectedFont:UIFont.systemFont(ofSize: 28*PX) ))
        }
    }
    
    // 产业商圈菜单
    fileprivate struct CYSQItem:MenuItemViewCustomizable{
        // 自定义菜单项名称
        var displayMode: MenuItemDisplayMode{
            return .text(title:MenuItemText(text:"产业商圈",color:myColor().Gray0D(),selectedColor:myColor().blue007aff(),font:UIFont.systemFont(ofSize: 28*PX),selectedFont:UIFont.systemFont(ofSize: 28*PX) ))
        }
    }
    
    // 企业门户菜单
    fileprivate struct QYMHItem:MenuItemViewCustomizable{
        // 自定义菜单项名称
        var displayMode: MenuItemDisplayMode{
            return .text(title:MenuItemText(text:"企业门户",color:myColor().Gray0D(),selectedColor:myColor().blue007aff(),font:UIFont.systemFont(ofSize: 28*PX),selectedFont:UIFont.systemFont(ofSize: 28*PX) ))
        }
    }
    
    // 积分优购菜单
    fileprivate struct JFYGItem:MenuItemViewCustomizable{
        // 自定义菜单项名称
        var displayMode: MenuItemDisplayMode{
            return .text(title:MenuItemText(text:"积分优购",color:myColor().Gray0D(),selectedColor:myColor().blue007aff(),font:UIFont.systemFont(ofSize: 28*PX),selectedFont:UIFont.systemFont(ofSize: 28*PX) ))
        }
    }
}

//菜单显示模式


class QZHSearchViewController1: QZHBaseViewController {
    override func loadData() {
        
    }
}

// MARK: - UI 界面设计
extension QZHSearchViewController1{
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
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "搜索", img: "", target: self, action: #selector(close))
        
        let btn:SearchController = SearchController()
        //btn.backgroundColor = UIColor.white
        navItem.titleView = btn.SeacrchBtn4()
    }
    //添加头部选项卡
    func setupTab(){
        //分页菜单配置
        let options = PagingMenuOptionsSearch()
        
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options:options)
        
        
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 128*PX+1
        pagingMenuController.view.frame.size.height -= 128*PX+1
        
        //建立父子关系
        addChildViewController(pagingMenuController)
        
        //分页菜单控制器视图添加到当前视图
        view.addSubview(pagingMenuController.view)
    }
}


// MARK: - 监听方法
extension QZHSearchViewController1{
    //返回
    func close(){
        dismiss(animated: true, completion: nil)
    }

}
