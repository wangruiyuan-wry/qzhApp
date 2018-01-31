//
//  QZHNavigationCobtroller.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/8.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏默认的NavigationBar
        navigationBar.isHidden = true
    }
    
    ///重写 push 方法，所有的 push 动作都会调用此方法
    /// viewController 是被 push 的控制器，设置他左侧的按钮作为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //如果不是栈底控制器则需要隐藏，跟控制器不需要隐藏
        if childViewControllers.count > 0 {
            //隐藏底部导航控制器
            viewController.hidesBottomBarWhenPushed=true
        }

        //判断控制器的类型
        if let _vc = viewController as? QZHBaseViewController{
            //取出自定义的 navItem
          //  _vc.navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(popToParent))
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    @objc private func popToParent(){
        popViewController(animated: true)
    }
}
