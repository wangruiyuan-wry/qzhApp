//
//  QZHOrderViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/27.
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
    var defaultPage: Int = QZHOrderListModel.orderType
    
    // lazyLoadingPage的页面数量（默认就是.three）
    var lazyLoadingPage: LazyLoadingPage = .three
    
    //
    var menuControllerSet: MenuControllerSet = .multiple

    // 全部订单控制器
    private let allConroller = QZHOrderListAllViewController()
    
    //待付款订单控制器
    private let payIController = QZHOrderList_PayViewController()
    
    //待发货订单控制器
    private let deliveryController = QZHOrderList_GoodsViewController()
    
    // 待收货订单制器
    private let receiveConroller = QZHOrderList_SHViewController()
    
    // 带评价订单控制器
    private let evaluationIController = QZHOrderList_CommentViewController()
    
    // 退款／售后订单控制器
    private let afterSalesController = QZHOrderList_AfterSaleViewController()
    
    //组件类型
    var componentType: ComponentType{
        return .all(menuOptions: MenuOptions(), pagingControllers:pagingControllers)
    }
    
    //所有子控制器
    fileprivate var pagingControllers:[UIViewController]{
        return [allConroller,payIController,deliveryController,receiveConroller,evaluationIController,afterSalesController]
    }
    
    
    //菜单配置项
    fileprivate struct MenuOptions:MenuViewCustomizable{
        
        var backgroundColor: UIColor = UIColor.white
        
        // 高度
        var height: CGFloat = 80*PX
        
        // 页面切换动画播放时间为0.5秒
        var animationDuration: TimeInterval = 0.3
        
        // 不允许手指左右滑动
        var isScrollEnabled: Bool = false
        
        // 菜单切换动画减速
        var deceleratingRate: CGFloat = UIScrollViewDecelerationRateFast
        
        // 菜单选中样式
        var focusMode: MenuFocusMode = .underline(height: 1*PX, color: myColor().blue007aff(), horizontalPadding: 0, verticalPadding: 0)
        
        // 菜单位置
        var menuPosition: MenuPosition = .top
        
        // 设置标签之间分割线
        var dividerImage: UIImage? = UIImage(named:"")
        
        // 菜单显示的模式
        var displayMode:MenuDisplayMode{
            return .segmentedControl
        }
        
        var titleWidth:MenuItemWidthMode{
            return .fixed(width: 100*PX)
        }
        
        // 菜单项
        var itemsOptions: [MenuItemViewCustomizable]{
            return [allItem(),payItem(),deliveryItem(),receiveItem(),evaluationItem(),afterSalesItem()]
        }
    }
    
    // 全部
    fileprivate struct allItem:MenuItemViewCustomizable{
        
        // 自定义菜单项名称
        var displayMode: MenuItemDisplayMode{
            return .text(title:MenuItemText(text:"全部",color:myColor().gray3(),selectedColor:myColor().blue007aff(),font:UIFont.systemFont(ofSize: 26*PX),selectedFont:UIFont.systemFont(ofSize: 26*PX) ))
            //.text(title: MenuItemText(text:"企业介绍"))
        }
    }
    
    // 待付款
    fileprivate struct payItem:MenuItemViewCustomizable{
        // 自定义菜单项名称
        var displayMode: MenuItemDisplayMode{
            return .text(title:MenuItemText(text:"待付款",color:myColor().gray3(),selectedColor:myColor().blue007aff(),font:UIFont.systemFont(ofSize: 26*PX),selectedFont:UIFont.systemFont(ofSize: 26*PX) ))
        }
    }
    
    // 待发货
    fileprivate struct deliveryItem:MenuItemViewCustomizable{
        // 自定义菜单项名称
        var displayMode: MenuItemDisplayMode{
            return .text(title:MenuItemText(text:"待发货",color:myColor().gray3(),selectedColor:myColor().blue007aff(),font:UIFont.systemFont(ofSize: 26*PX),selectedFont:UIFont.systemFont(ofSize: 26*PX) ))
        }
    }
    
    fileprivate struct receiveItem:MenuItemViewCustomizable{
        // 待收货
        var displayMode: MenuItemDisplayMode{
            return .text(title:MenuItemText(text:"待收货",color:myColor().gray3(),selectedColor:myColor().blue007aff(),font:UIFont.systemFont(ofSize: 26*PX),selectedFont:UIFont.systemFont(ofSize: 26*PX) ))
        }
    }
    
    // 待评价
    fileprivate struct evaluationItem:MenuItemViewCustomizable{
        // 自定义菜单项名称
        var displayMode: MenuItemDisplayMode{
            return .text(title:MenuItemText(text:"待评价",color:myColor().gray3(),selectedColor:myColor().blue007aff(),font:UIFont.systemFont(ofSize: 26*PX),selectedFont:UIFont.systemFont(ofSize: 26*PX) ))
        }
    }
    
    // 退款／售后
    fileprivate struct afterSalesItem:MenuItemViewCustomizable{
        // 自定义菜单项名称
        var displayMode: MenuItemDisplayMode{
            return .text(title:MenuItemText(text:"售后",color:myColor().gray3(),selectedColor:myColor().blue007aff(),font:UIFont.systemFont(ofSize: 26*PX),selectedFont:UIFont.systemFont(ofSize: 26*PX) ))
        }
    }

}


class QZHOrderViewController: QZHBaseViewController {
    override func loadData() {
        
    }
}


extension QZHOrderViewController{
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
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        
        self.title = "我的订单"
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
    
}

// MARK: - PagingMenuControllerDelegate
extension QZHOrderViewController{
    
    func willMoveToMenuPage(page: Int) {
    }
    
    func didMoveToMenuPage(page: Int) {
    }
}

// 监听方法
extension QZHOrderViewController{
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
       // navigationController?.pushViewController(vc, animated: true)
    }
    
    //返回
    func close(){
        if QZHOrderListModel.from == 0{
            dismiss(animated: true, completion: nil)
        }else if QZHOrderListModel.from == 11{
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
