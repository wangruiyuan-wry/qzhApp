//
//  QZHEnterprisePortalModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/9.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit
import YYModel

/// 企业门户企业列表数据模型
class QZHEnterprisePortalModel: NSObject {
    
    /// 企业Id
    var id: Int64 = 0
    /// 公司名称
    var companyName:String = ""
    /// 主营产品
    var mainPro:String = ""
    /// 联系电话
    var contactTel:String = ""
    /// 地址
    var address:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}
