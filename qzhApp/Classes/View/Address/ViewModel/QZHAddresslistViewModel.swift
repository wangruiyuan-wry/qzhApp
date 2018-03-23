//
//  QZHAddresslistViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/20.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class  QZHAddressListViewModel: NSObject {
    
    // 收货人地址视图列表懒加载
    lazy var addressListStatus = [QZHAddressViewModel]()
    
    // 地址详细信息
    lazy var addressInfoStatus = [QZHAddressViewModel]()
    
    /// 获取收货地址列表
    ///
    /// - Parameter completion: 回调方法
    func getAddressList(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/address/listAddress", params: [:]) { (result, isSuccess) in
            if isSuccess{
                if result["status"]as!Int != 200{
                    completion(false)
                }else{
                    let _data:[[String:AnyObject]] = result["data"] as! [[String : AnyObject]]
                    var listArray = [QZHAddressViewModel]()
                    for dic in _data{
                        let newDic = PublicFunction().setNULLInDIC(dic)
                        //a）创建企业模型
                        let model = QZHAddressModel.yy_model(with:newDic)
                        
                        //b）将model添加到数组
                        listArray.append(QZHAddressViewModel(model:model!))
                    }
                    self.addressListStatus = listArray
                    completion(isSuccess)
                }
            }
        }
    }
    
    /// 设置默认地址
    ///
    /// - Parameter completion: 回调方法
    func setDefault(completion:@escaping (_ isSuccess:Bool,_ msg:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/address/insertAddress", params: ["isDefault":1 as AnyObject,"addressId":QZHAddressModel.addressId as AnyObject]) { (result, isSuccess) in
            if isSuccess{
                completion(isSuccess, "设置成功！！！")
            }else{
                completion(isSuccess, "设置失败！！！")
            }
        }
    }
    
    /// 删除地址
    ///
    /// - Parameter completion: 回调方法
    func delAdress(completion:@escaping (_ isSuccess:Bool,_ msg:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/address/deleteAddress", params: ["addressId":QZHAddressModel.addressId as AnyObject]) { (result, isSuccess) in
            if isSuccess{
                completion(isSuccess, "删除成功！！！")
            }else{
                completion(isSuccess, "删除失败！！！")
            }
        }
    }
    
    /// 根据地址ID 获取地址详细信息
    ///
    /// - Parameter completion: 回调方法
    func getAddressInfo(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/address/getReceiverAddress", params: ["id":QZHAddressModel.addressId as AnyObject]) { (result, isSuccess) in
            if isSuccess{
                if result["status"]as!Int != 200{
                    completion(false)
                }else{
                    
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    var listArray = [QZHAddressViewModel]()

                    let newDic = PublicFunction().setNULLInDIC(_data)
                    //a）创建企业模型
                    let model = QZHAddressModel.yy_model(with:newDic)
                        
                    //b）将model添加到数组
                    listArray.append(QZHAddressViewModel(model:model!))
                    self.addressInfoStatus = listArray
                    completion(isSuccess)
                }
            }

        }
    }
    
    /// 编辑地址
    ///
    /// - Parameter completion: 回调方法
    func editAddress(completion:@escaping (_ isSuccess:Bool,_ msg:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/address/insertAddress", params: ["person":QZHAddressModel.person as AnyObject,"phone":QZHAddressModel.phone as AnyObject,"code":QZHAddressModel.code as AnyObject,"address":QZHAddressModel.address as AnyObject,"isDefault":QZHAddressModel.isDefault as AnyObject,"addressId":QZHAddressModel.addressId as AnyObject]) { (result, isSuccess) in
            if isSuccess{
                completion(isSuccess, "编辑成功！！！")
            }else{
                completion(isSuccess, "编辑失败！！！")
            }
        }
    }
    
    /// 添加地址
    ///
    /// - Parameter completion: 回调方法
    func addAddress(completion:@escaping (_ isSuccess:Bool,_ msg:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/address/insertAddress", params: ["person":QZHAddressModel.person as AnyObject,"phone":QZHAddressModel.phone as AnyObject,"code":QZHAddressModel.code as AnyObject,"address":QZHAddressModel.address as AnyObject,"isDefault":QZHAddressModel.isDefault as AnyObject]) { (result, isSuccess) in
            if isSuccess{
                completion(isSuccess, "添加成功！！！")
            }else{
                completion(isSuccess, "添加失败！！！")
            }
        }
    }

}
