//
//  QZHBrandAndSpecOptionModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/18.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHBrandModel:NSObject{
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 规格名／品牌
    var specName:String = ""
    
    // 规格Id
    var id:Int = 0
    
    struct param {
        static var categoryId:Int = 0
        
    }
    
}
extension QZHBrandModel{
        class var categoryId:Int{
        set{
            param.categoryId = newValue
        }
        get{
            return param.categoryId
        }
    }
}

class QZHSpecOptionModel:NSObject{
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 规格Id
    var specId:Int = 0
    
    // 规格选项名称
    var specOptionName:String = ""
    
    var attributeId:Int = 0
    
    var optionName:String = ""
    
    var id:Int = 0
}

class QZHOptionModel:NSObject{
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 规格名／品牌
    var OptionName:String = ""
    
    // 规格Id
    var id:Int = 0
    
    var attributeId:Int = 0
}
