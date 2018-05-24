//
//  QZHMarketFindCompanyModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/3.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
import YYModel

class QZHMarketFindCompanyModel:NSObject{

    
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
    
    // 公司id
    var id:Int = 0
    
    // 行业（行业Code）
    var industryType:String = ""
    
    // 公司logo
    var logo:String = ""
    
    // 主营产品
    var mainProduct:String = ""
    
    // 手机号码
    var mobile:String = ""
    
    // 公司名称
    var name:String = ""
    
    // 联系人
    var nickName:String = ""
    
    // 省市区
    var pca:String = ""
    
    // 主购产品
    var purchasingProduct:String = ""
    
    
    // 参数
    struct param {
        static var searchParam:String = ""
        static var pageNo:Int = 0
        static var pageSize:Int = 20
        
        // 排序
        static var coprehensive:Int = 0
        static var area:String = ""
        static var industry_type:String = ""
        static var enterprise_type:String = ""
        
    }
}

extension QZHMarketFindCompanyModel{
    class var coprehensive:Int {
        set{
            param.coprehensive = newValue
        }
        get{
            return param.coprehensive
        }
    }
    class var enterprise_type:String {
        set{
            param.enterprise_type = newValue
        }
        get{
            return param.enterprise_type
        }
    }
    class var industry_type:String {
        set{
            param.industry_type = newValue
        }
        get{
            return param.industry_type
        }
    }
    class var area:String {
        set{
            param.area = newValue
        }
        get{
            return param.area
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
    class var pageSize:Int {
        set{
            param.pageSize = newValue
        }
        get{
            return param.pageSize
        }
    }
    class var searchParam:String {
        set{
            param.searchParam = newValue
        }
        get{
            return param.searchParam
        }
    }
}
