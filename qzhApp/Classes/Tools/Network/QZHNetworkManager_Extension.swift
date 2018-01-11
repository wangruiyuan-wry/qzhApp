//
//  QZHNetworkManager_Extension.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/9.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

// MARK: - 封装千纸鹤的网络请求
extension QZHNetworkManager{
    
    /// 加载千纸鹤数据字典数组
    ///
    /// - Parameters:
    ///   - url: 接口连接
    ///   - params: 参数字典
    ///   - pageSize: 每次加载的数据量
    ///   - pageNo: 加载数据的页码
    ///   - completion: 完成回调[list:千纸鹤数据字典／是否成功]
    func statusList(url:String,params:[String:AnyObject],completion:@escaping (_ list:[String:AnyObject],_ isSuccess:Bool)->()){
        let urlString = "http://192.168.100.73:81/\(url)"
        request(URLString:urlString, parameters: params){
            (json,isSuccess) in
            if json == nil {
                print("网络错误")
            }else{
                completion(json as! [String : AnyObject],isSuccess)
            }
        }
    }
}
