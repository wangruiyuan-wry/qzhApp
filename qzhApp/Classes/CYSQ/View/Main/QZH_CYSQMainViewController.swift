//
//  QZH_CYSQMainViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/24.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZH_CYSQMainViewController: UITabBarController {

    //定时器
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
        setupTimer()
        
        //设置代理
        delegate=self
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: QZHUserShouldLoginNotification), object: nil)
    }
    
    
    deinit {
        //销毁时钟
        timer?.invalidate()
        
        //注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    /**
     portrait    : 竖屏，肖像
     landscape   : 横屏，风景画
     
     - 使用代码控制设备的方向，好处，可以在在需要横屏的时候，单独处理！
     - 设置支持的方向之后，当前的控制器及子控制器都会遵守这个方向！
     - 如果播放视频，通常是通过 modal 展现的！
     
     override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
     return .portrait
     }*/
    
    //MARK: -监听方法
    @objc private  func userLogin(n:Notification){
        
        //展现登录控制器 - 通常会和 UINavigationController 一起使用，方便返回
        let nav = UINavigationController(rootViewController:QZHOAuthViewController())
        present(nav, animated: true, completion: nil)
        
    }
}

// MARK: - UITabBarControllerDelegate
extension QZH_CYSQMainViewController:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        //1.>获取控制器在数组中的索引
        let idx = (childViewControllers as NSArray).index(of: viewController)
        
        //2.>判断索引是首页，同时idx也是首页，重复点击首页
        if selectedIndex == 0 && idx == selectedIndex{
            //3.>让表格滚到顶部
            //a> 获取控制器
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! QZHHomeViewController
            //b>滚动到顶部
            vc.tabbelView?.setContentOffset(CGPoint(x:0,y:-64), animated: true)
            //4.>刷新数据
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                vc.loadData()
            })
        }
        
        //判断目标控制器是否是 UIViewController
        return !viewController.isMember(of: UIViewController.self)
    }
}


//MARK: - 时钟相关方法
extension QZH_CYSQMainViewController{
    
    /// 定义时钟 - 时间间隔建议长点
    func setupTimer(){
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    /// 时钟出发方法
    @objc private func updateTimer() {
        
        if !QZHNetworkManager.shared.userLogo{
            return
        }
        //设置 APP 的 bageNumber ，从 IOS 8.0 之后，要用户授权之后才能够显示
        //UIApplication.shared.applicationIconBadgeNumber = 未读数量
    }
}

//用来切分代码块
//可以把相近功能函数，放在一个extension中
//便于代码维护
//注意：不能定义属性。只能定义方法
//MARK:-设置界面
extension QZH_CYSQMainViewController{
    //设置所有子控制器
    func setupChildControllers(){
        let array = [
            ["clsName":"QZH_CYSQHomeViewController","title":"首页","imageName":"home"],
            ["clsName":"QZH_CYSQHomeViewController","title":"分类","imageName":"sort"],
            ["clsName":"QZH_CYSQHomeViewController","title":"订单","imageName":"orderIcon"],
            ["clsName":"QZH_CYSQHomeViewController","title":"购物车","imageName":"shoppingCar"],
            ["clsName":"QZHHomeViewController","title":"我的","imageName":"user"]
        ]
        
        var arrayM = [UIViewController]()
        for dict in array{
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM
    }
    
    //使用字典创建一个子控制器
    ///
    ///-parameter dict:信息字典[clsName, title, imageName, visitorInfo]
    ///
    ///-return:子控制器
    private func controller(dict:[String:String])->UIViewController{
        //1.取得字典内容
        guard let _clsName = dict["clsName"],
            let _title = dict["title"],
            let _imageName = dict["imageName"],
            //将 clsName转换为 cls
            let cls = NSClassFromString(Bundle.main.namespace+"."+_clsName) as? UIViewController.Type
            else{
                return UIViewController()
        }
        
        //2.创建试图控制器
        let vc = cls.init()
        
        vc.title = _title
        //设置图像
        vc.tabBarItem.image = UIImage(named:""+_imageName)
        vc.tabBarItem.selectedImage = UIImage(named:""+_imageName+"Sel")?.withRenderingMode(.alwaysOriginal)
        //设置 tabbar 的标题字体（大小）
        vc.tabBarItem.setTitleTextAttributes(
            [NSForegroundColorAttributeName: myColor().blue007aff()],
            for: .highlighted)
        // 系统默认是 12 号字，修改字体大小，要设置 Normal 的字体大小
        vc.tabBarItem.setTitleTextAttributes(
            [NSFontAttributeName: UIFont.systemFont(ofSize: 12)],
            for: UIControlState(rawValue: 0))
        // 设置背景颜色
        vc.tabBarController?.tabBar.backgroundColor = UIColor.white
        vc.tabBarController?.tabBar.barTintColor = UIColor.white
        vc.tabBarController?.tabBarItem.badgeColor = UIColor.white
        //实例化导航控制器的时候会调用 push 方法对 rootVC 压栈
        let nav = QZHNavigationController(rootViewController:vc)
        
        return nav
        
    }
}
