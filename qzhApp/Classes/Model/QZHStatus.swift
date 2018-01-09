//
//  QZHStatus.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/9.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 千纸鹤数据模型
class QZHStatus: NSObject {
    
    /// Int 类型，在64位系统上为64位，32位的系统就是32位
    /// 如果不写，在老版本的ios系统上都会数据溢出
    
    var id: Int64 = 0
}
