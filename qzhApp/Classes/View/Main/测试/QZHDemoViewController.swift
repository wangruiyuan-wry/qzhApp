//
//  QZHDemoViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/8.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit
//import ZYSideSlipFilter

class QZHDemoViewController: QZHBaseViewController {
    
       //MARK: - 监听方法
    /// 继续PUSH一个新的控制器
    @objc func showNext(){
        let vc = QZHDemoViewController()
       // navigationController?.pushViewController(vc, animated: true)
    }
}
extension QZHDemoViewController{
    
    /// 重写父类方法
    override func setupUI(){
        super.setupUI()
        navItem.rightBarButtonItem = UIBarButtonItem(title:"下一个",style:.plain,target:self,action:#selector(showNext))
    }
}
