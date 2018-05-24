//
//  QZH_CYSQSortModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/2/28.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

// 一级分类数据模型
class QZH_CYSQSortModel: NSObject {
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 分类ID
    var id:Int = 0
    
    // 广告图片
    var pictureUrl:String = ""
    
    // 一级分类名称
    var lableName:String = ""
    
    // 产品列表
    var categoryId:Int = 0
    
    // 名称
    var name:String = ""
}

// 二级分类数据模型
class QZH_CYSQSort_SecondModel:NSObject{
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // ID
    var id:Int = 0
    
    // 分类ID
    var  categoryId:Int = 0
    
    // 二级分类名称
    var name:String = ""
    
    // 分类图片
    var pictureUrl:String = ""
    
    // 父类ID
    var labelId:Int = 0
    
    struct paramer {
       static var parentId:Int = 0
    }
}
extension QZH_CYSQSort_SecondModel{
    
    class var parentId:Int{
        get{
            return paramer.parentId
        }
        set{
            paramer.parentId = newValue
        }
    }
    
}
