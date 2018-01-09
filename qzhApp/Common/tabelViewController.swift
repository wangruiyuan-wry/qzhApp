//
//  tabelViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2017/12/29.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

class tabelViewController: UITableViewCell{
    //初始设置列表
    func setlistTabel(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,bgColor:UIColor){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.backgroundColor=bgColor
    }
    
}
