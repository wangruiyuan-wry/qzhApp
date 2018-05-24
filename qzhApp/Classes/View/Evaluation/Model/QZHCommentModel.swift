//
//  QZHCommentModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/27.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHCommentModel:NSObject{
    struct param {
        static var orderNum:String = ""
        static var goodsId:Int = 0
        static var goodsComment:Int = 0
        static var goodsDescripe:String = ""
        static var seviceComment:Int = 5
        static var productComment:Int = 5
        static var data:String = ""
        static var _id:String = ""
        static var status:String = ""
        static var badComment:Int = 0
        static var middleComment:Int = 0
        static var goodComment:Int = 0
        static var totalComment:Int = 0
        
        static var proImg:String = ""
        
    }
}

extension QZHCommentModel{
    class var proImg: String {
        set{
            param.proImg = newValue
        }
        get{
            return param.proImg
        }
    }
    class var totalComment: Int {
        set{
            param.totalComment = newValue
        }
        get{
            return param.totalComment
        }
    }
    class var badComment: Int {
        set{
            param.badComment = newValue
        }
        get{
            return param.badComment
        }
    }
    class var middleComment: Int {
        set{
            param.middleComment = newValue
        }
        get{
            return param.middleComment
        }
    }
    class var goodComment: Int {
        set{
            param.goodComment = newValue
        }
        get{
            return param.goodComment
        }
    }
    class var status: String {
        set{
            param.status = newValue
        }
        get{
            return param.status
        }
    }
    class var _id: String {
        set{
            param._id = newValue
        }
        get{
            return param._id
        }
    }

    class var productComment: Int {
        set{
            param.productComment = newValue
        }
        get{
            return param.productComment
        }
    }
    class var seviceComment: Int {
        set{
            param.seviceComment = newValue
        }
        get{
            return param.seviceComment
        }
    }
    class var goodsComment: Int {
        set{
            param.goodsComment = newValue
        }
        get{
            return param.goodsComment
        }
    }
    class var goodsId: Int {
        set{
            param.goodsId = newValue
        }
        get{
            return param.goodsId
        }
    }
    class var data: String {
        set{
            param.data = newValue
        }
        get{
            return param.data
        }
    }
    class var goodsDescripe: String {
        set{
            param.goodsDescripe = newValue
        }
        get{
            return param.goodsDescripe
        }
    }
    class var orderNum: String {
        set{
            param.orderNum = newValue
        }
        get{
            return param.orderNum
        }
    }
}
