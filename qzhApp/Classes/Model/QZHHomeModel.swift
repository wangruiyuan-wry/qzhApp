//
//  QZHHomeModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/22.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
import YYModel

// 首页数据模型
class QZHHomeModel: NSObject {
    
    // 广告 ID
    var id:Int64 = 0
    
    // 标题
    var adTitle:String = ""
    
    // 广告文字
    var adText:String = ""
    
    // 图片地址
    var adPic:String = ""
    
    //分类code
    var adType:String = ""
    
    //分类名称
    var adTypeText:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}
