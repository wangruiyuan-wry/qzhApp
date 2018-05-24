//
//  QZHCYSQSearchProListParamModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/13.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHCYSQSearchProListParamModel:NSObject{
    
    struct param {
        // 查询内容
        static var q:String = ""
        
        // 页码
        static var pageNo:Int = 0
        
        // 页面容量
        static var pageSize:Int = 20
        
        // 排序（1：综合排序，2:销量优先，3:价格递增，4:价格递减，5:新品）
        static var order:Int = 1
        
        // 规格（多个规格以逗号隔开）
        static var specOptionName:String = ""
        
        // 店铺id
        static var shopId:Int = 0
        
        // 店铺自定义分类Id
        static var customCategoryId:String = ""
        
        // 品牌（多个品牌逗号隔开）
        static var brand:String = ""
        
        // 价格区间筛选(1-100)
        static var price:String = ""
        
        // 分类id
        static var categoryId:String = ""
        
        // 一级分类id
        static var category_id_lv1:String = ""
        
        static var closeFlag:Bool = true
        
        // 是否筛选
        static var isScreen:Bool = false
    }
    
}

extension QZHCYSQSearchProListParamModel{
    class var isScreen:Bool{
        set{
            param.isScreen = newValue
        }
        get{
            return param.isScreen
        }
    }

    class var closeFlag:Bool{
        set{
            param.closeFlag = newValue
        }
        get{
            return param.closeFlag
        }
    }

    
    class var category_id_lv1:String{
        set{
            param.category_id_lv1 = newValue
        }
        get{
            return param.category_id_lv1
        }
    }
    
    class var categoryId:String{
        set{
            param.categoryId = newValue
        }
        get{
            return param.categoryId
        }
    }

    class var price:String{
        set{
            param.price = newValue
        }
        get{
            return param.price
        }
    }

    class var brand:String{
        set{
            param.brand = newValue
        }
        get{
            return param.brand
        }
    }

    class var customCategoryId:String{
        set{
            param.customCategoryId = newValue
        }
        get{
            return param.customCategoryId
        }
    }

    class var specOptionName:String{
        set{
            param.specOptionName = newValue
        }
        get{
            return param.specOptionName
        }
    }
    class var q:String{
        set{
            param.q = newValue
        }
        get{
            return param.q
        }
    }
    class var pageNo:Int{
        set{
            param.pageNo = newValue
        }
        get{
            return param.pageNo
        }
    }
    class var pageSize:Int{
        set{
            param.pageSize = newValue
        }
        get{
            return param.pageSize
        }
    }
    class var order:Int{
        set{
            param.order = newValue
        }
        get{
            return param.order
        }
    }

    class var shopId:Int{
        set{
            param.shopId = newValue
        }
        get{
            return param.shopId
        }
    }
}
