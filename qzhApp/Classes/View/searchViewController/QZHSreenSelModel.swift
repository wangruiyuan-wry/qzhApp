//
//  QZHSreenSelModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/20.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHSreenSelMode:NSObject{
    struct param {
        static var specNameArray:[String] = []
        static var specIdArray:[String] = []
        static var brandName:String = ""
        static var brandId:String = ""
        static var min:String = ""
        static var max:String = ""
    }
}

extension QZHSreenSelMode{
    class var min:String{
        set{
            param.min = newValue
        }
        get{
            return param.min
        }
    }
    class var max:String{
        set{
            param.max = newValue
        }
        get{
            return param.max
        }
    }
    class var brandName:String{
        set{
            param.brandName = newValue
        }
        get{
            return param.brandName
        }
    }
    class var brandId:String{
        set{
            param.brandId = newValue
        }
        get{
            return param.brandId
        }
    }
    class var specNameArray:[String]{
        set{
            param.specNameArray = newValue
        }
        get{
            return param.specNameArray
        }
    }
    class var specIdArray:[String]{
        set{
            param.specIdArray = newValue
        }
        get{
            return param.specIdArray
        }
    }
}
