//
//  QZHMarketCollectModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/4.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHMarketCollectModel:NSObject {
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 详细地址
    var address:String = ""
    
    // 会员状态
    var flag:Int = 0
    
    // 公司类型
    var companyType:Int = 0
    
    // 联系人
    var nickName:String = ""
    
    // 收藏Id
    var collectId:Int = 0
    
    // 手机
    var mobile:String = ""
    
    // 企业类型
    var enterpriseType:String = ""
    
    // 省市区
    var pca:String = ""
    
    // 主购
    var purchasingProduct:String = ""
    
    // 行业（code）
    var industrytype:String = ""
    
    // 公司名称
    var name:String = ""
    
    // 公司logo
    var logo:String = ""
    
    // 公司ID
    var id:Int = 0
    
    // 主营
    var mainProduct:String = ""
    
    // 参数设置
    struct  param {
        static var collectType:String = ""
        static var pageNo:Int = 0
        static var pageSize:Int = 20
        
        static var comperhensive:Int = 0
        static var area:String = ""
        static var customerStatus:Int = 0
    }
}

extension QZHMarketCollectModel{
    class var area:String {
        set{
            param.area = newValue
        }
        get{
            return param.area
        }
    }
    class var customerStatus:Int {
        set{
            param.customerStatus = newValue
        }
        get{
            return param.customerStatus
        }
    }
    class var comperhensive:Int {
        set{
            param.comperhensive = newValue
        }
        get{
            return param.comperhensive
        }
    }
    class var collectType:String {
        set{
            param.collectType = newValue
        }
        get{
            return param.collectType
        }
    }
    class var pageSize:Int {
        set{
            param.pageSize = newValue
        }
        get{
            return param.pageSize
        }
    }
    class var pageNo:Int {
        set{
            param.pageNo = newValue
        }
        get{
            return param.pageNo
        }
    }
}
