
//
//  QZHPersonalCenterMyInfoView.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/2.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHPersonalCenterMyInfoModel: NSObject {
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 关注店铺数量
    var attentionStoreCount:Int = 0
    
    // 我的足迹数量
    var myFootCount:Int = 0
    
    // 收藏产品的数量
    var collectProductCount:Int = 0
    
    // 修改个人信息参数
    struct param {
        static var phone:String = ""
        static var nickName:String = ""
        static var realName:String = ""
        static var tel:String = ""
        static var companyName:String = ""
        static var headPort:String = ""
        
        static var eidtTitle:String = ""
        static var eidtText:String = ""
        
        static var photoStr:NSData? = nil
        static var img:UIImage? = nil
    }
}
extension QZHPersonalCenterMyInfoModel{
    class var img:UIImage{
        set{
            param.img = newValue
        }
        get{
            return param.img!
        }
    }
    
    class var photoStr:NSData{
        set{
            param.photoStr = newValue
        }
        get{
            return param.photoStr!
        }
    }

    class var eidtText:String{
        set{
            param.eidtText = newValue
        }
        get{
            return param.eidtText
        }
    }
    class var eidtTitle:String{
        set{
            param.eidtTitle = newValue
        }
        get{
            return param.eidtTitle
        }
    }
    class var headPort:String{
        set{
            param.headPort = newValue
        }
        get{
            return param.headPort
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
    class var tel:String{
        set{
            param.tel = newValue
        }
        get{
            return param.tel
        }
    }
    class var realName:String{
        set{
            param.realName = newValue
        }
        get{
            return param.realName
        }
    }
    class var nickName:String{
        set{
            param.nickName = newValue
        }
        get{
            return param.nickName
        }
    }
    class var phone:String{
        set{
            param.phone = newValue
        }
        get{
            return param.phone
        }
    }
}

class QZHPersonalCenterOrderCountModel: NSObject {
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 待付款的数量
    var dfkCount:Int = 0
    
    // 待发货数量
    var dfhCount:Int = 0
    
    // 待收货数量
    var dshCount:Int = 0
    
    // 带评价数量
    var dpjCount:Int = 0
    
    // 退款中数量
    var tkCount:Int = 0
}

class QZHPersonalCenterPersonInfoModel: NSObject {
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    
    // 推荐人id
    var refrrer:Int = 0
    
   // 公司名称
    var companyName:String = ""
    
    // 部门iD
    var deptId:Int = 0
    
    // 头像地址
    var headPortrait:String = ""
    
    // 用户id
    var id:Int = 0
    
    // 公司Id
    var memberId:Int = 0
    
    // 账号
    var name:String = ""
    
    // 昵称
    var nikeName:String = ""
    
    // 密码
    var passWord:String = ""
    
    // 手机
    var  phone:String = ""
    
    // 真实姓名
    var realName:String = ""
    
    // 角色Id
    var roleId:Int = 0
    
    // 状态
    var status:Int = 0
    
    // 固定电话
    var tel:String = ""
    
}
