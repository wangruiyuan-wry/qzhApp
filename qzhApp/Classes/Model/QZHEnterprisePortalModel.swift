//
//  QZHEnterprisePortalModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/9.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit
import YYModel

/// 企业类型数据模型
class QZHEnterpriseTypeModel:NSObject{
    //企业类型
    var typeName:String = ""
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

/// 一级行业分类数据模型
class QZHEnterpriseFirstModel:NSObject{
    //分类key
    var key:String = ""
    
    //分类值
    var value:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

/// 二级行业分类数据模型
class QZHEnterpriseSecondModel:NSObject{
    //分类key
    var key:String = ""
    
    //分类值
    var value:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}


/// 企业门户企业列表数据模型
class QZHEnterprisePortalModel: NSObject {
    
    /// 企业Id
    var id: Int64 = 0
    /// 公司名称
    var name:String = ""
    /// 主营产品
    var mainproduct:String = ""
    /// 联系电话
    var mobile:String = ""
    /// 地址
    var address:String = ""
    ///公司 logo 图片
    var logo:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }

    
    struct paramers {
        static var pca :String? = ""
        static var enterpriceType: String? = ""
        static var industryType:String? = ""
        static var order:String? = ""
        static var pageNo :Int? = 1
        //一级行业key
        static var superKey:String? = ""
    }
}

extension QZHEnterprisePortalModel{
    class var pageNo:Int{
        get{
            return paramers.pageNo!
        }
        set{
            paramers.pageNo=newValue
        }
    }
    class var pca:String{
        get{
            return paramers.pca!
        }
        set{
            paramers.pca = newValue
        }
    }
    class var enterpriceType:String{
        get{
            return paramers.enterpriceType!
        }
        set{
            paramers.enterpriceType = newValue
        }
    }
    class var industryType:String{
        get{
            return paramers.industryType!
        }
        set{
            paramers.industryType = newValue
        }
    }
    class var order:String{
        get{
            return paramers.order!
        }
        set{
            paramers.order = newValue
        }
    }
    
    class var superKey:String{
        get{
            return paramers.superKey!
        }
        set{
            paramers.superKey = newValue
        }
    }
}
