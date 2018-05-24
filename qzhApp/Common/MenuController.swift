//
//  MenuController.swift
//  qzhApp
//
//  Created by sbxmac on 2017/12/27.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

//页面导航条

class Menus:UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor=UIColor.white
        
        //self.tabBar.tintColor=UIColor(red:67/255,green:137/255,blue:197/255,alpha:1)
        self.tabBar.barTintColor=UIColor.white
        self.tabBarItem.imageInsets=UIEdgeInsetsMake(0, -10, -6, -10)
        if #available(iOS 10.0, *) {
            self.tabBarItem.badgeColor=UIColor.white
        } else {
            // Fallback on earlier versions
        }
        self.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 20)], for: .normal)
        self.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 10.0)], for: .selected)
        
        self.tabBarItem.titlePositionAdjustment=UIOffset(horizontal:0,vertical:-10)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
