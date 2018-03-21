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
}
