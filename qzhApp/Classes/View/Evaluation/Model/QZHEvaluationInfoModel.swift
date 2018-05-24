//
//  QZHEvaluationInfoModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/27.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHEvaluationInfoModel:NSObject{

    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    struct param {
        static var _id:String = ""
    }
}
extension QZHEvaluationInfoModel{
    class var _id:String{
        set{
            param._id = newValue
        }
        get{
            return param._id
        }
    }
}
