//
//  QZHMainViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/8.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit


//主控制器
class QZHMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
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
}

//用来切分代码块
//可以把相近功能函数，放在一个extension中
//便于代码维护
//注意：不能定义属性。只能定义方法
//MARK:-设置界面
extension QZHMainViewController{
    //设置所有子控制器
    func setupChildControllers(){
        let array = [
            ["clsName":"QZHHomeViewController","title":"首页","imageName":"collectionIcon"],
            ["clsName":"QZHEnterprisePortalViewController","title":"分类","imageName":"collectionIcon"],
            ["clsName":"QZHHomeViewController","title":"购物车","imageName":"collectionIcon"],
            ["clsName":"QZHHomeViewController","title":"我的","imageName":"collectionIcon"]
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
            [NSForegroundColorAttributeName: UIColor.orange],
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
        let nav = QZHNavigationCobtroller(rootViewController:vc)
        
        return nav
        
    }
}
