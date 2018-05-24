//
//  QZHMarketCompanyInfoModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/4.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHMarketCompanyInfoModel:NSObject{
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 创建日期
    var createDate:String = ""
    
    // email
    var email:String = ""
    
    // 传真
    var fax:String = ""
    
    // 公司ID
    var memberId:Int = 0
    
    // qq
    var qq:String = ""
    
    // 简介
    var remark:String = ""
    
    // 店铺图片
    var shopImg:String = ""
    
    // 商家编码
    var shopNo:String = ""
    
    // 联系电话
    var tel:String = ""
    
    // 网址
    var web:String = ""
    
    // 参数设置
    struct param {
        // 公司ID
        static var id:Int = 0
        
        // 公司名称
        static var companyName:String = ""
        
        // 收藏类型
        static var collectType:String = ""
    }
}
extension QZHMarketCompanyInfoModel{
    
    class var id:Int{
        set{
            param.id = newValue
        }
        get{
            return param.id
        }
    }
    
    class var collectType:String{
        set{
            param.collectType = newValue
        }
        get{
            return param.collectType
        }
    }
    
    class var companyName:String{
        set{
            param.companyName = newValue
        }
        get{
            return param.companyName
        }
    }
    
}

class QZHMarketCompanyModel:NSObject{
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 详细地址
    var address:String = ""
    
    // 公司类型
    var companyType:Int = 0
    
    // 企业类型
    var enterpriseType:String = ""
    
    // 会员状态
    var flag:Int = 0
    
    // 公司ID
    var id:Int = 0
    
    // 行业（code）
    var industryTtype:String = ""
    
    // 公司Logo
    var logo:String = ""
    
    // 主营
    var mainProduct:String = ""
    
    // 手机
    var mobile:String = ""
    
    // 公司名称
    var name:String = ""
    
    // 联系人
    var nickName:String = ""
    
    // 省市区
    var pca:String = ""
    
    // 主购
    var purchasingProduct:String = ""
    
}
