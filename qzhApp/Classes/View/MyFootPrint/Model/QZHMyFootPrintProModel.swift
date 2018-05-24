//
//  QZHMyFootPrintProModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHMyFootPrintProModel:NSObject{
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 是否推荐
    var isRecommend:Int = 0
    
    // 货品单位
    var unit:String = ""
    
    // 货品销售量
    var salesVolume:Double = 0.0
    
    // 是否自营
    var selfSupport:Int = 0
    
    // 货品Id
    var id:Int = 0
    
    // 货品图片 （以逗号隔开）
    var pic:String = ""
    
    // 货品总库存
    var stock:Double = 0.0
    
    // 货品价格
    var fixedPrice:Double = 0.0
    
    // 货品名称
    var  goodsName:String = ""
    
    // 货品上架
    var eipMemberId:Int = 0
    
    // 我的足迹ID
    var myFootId:Int = 0
    
    struct param {
        static var ids:String = ""
    }
}

extension QZHMyFootPrintProModel{
    class var ids:String {
        get{
            return param.ids
        }
        set{
            param.ids = newValue
        }
    }
}
