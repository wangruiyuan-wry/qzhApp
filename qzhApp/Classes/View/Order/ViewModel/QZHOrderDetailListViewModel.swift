//
//  QZHOrderDetailListViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/9.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHOrderDetailListViewModel: NSObject {
    
    // 订单主表视图模型懒加载
    lazy var orderMainStatus = [QZHOrderMainDetailViewModel]()
    
    // 订单子表视图模型懒加载
    lazy var orderSubStatus = [QZHOrderSubDetailViewModel]()
    
    // 订单地址视图模型懒加载
    lazy var addressDetailStatus = [QZHOrderAddressDetailViewModel]()
    
    // 订单日志视图模型懒加载
    lazy var orderLogStatus = [QZHOrderLogDetailViewModel]()
    
    // 订单卖家信息视图模型懒加载
    lazy var personInfoStatus = [QZHOrderPersonInfoDetailViewModel]()
    
    // 账期时间
    lazy var time:String = ""
    
    /// 获取订单详情数据
    ///
    /// - Parameter completion: 回调方法
    func loadOrderDetail(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/OrderDetail/getBuyOrderDetail", params: ["orderNumber":QZHOrderDetailModel.orderNumber as AnyObject]) { (result, isSuccess) in
            print(result)
            if !isSuccess{
                completion(false)
            }else{
                if result["status"] as! Int != 200{
                    completion(false)
                }else{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    var orderMain:[String:AnyObject] = [:]
                    if _data.keys.contains("orderMain"){
                        orderMain = _data["orderMain"] as! [String : AnyObject]
                    }
                    var orderSub:[[String:AnyObject]] = []
                    if _data.keys.contains("orderSub"){
                        orderSub = _data["orderSub"] as! [[String : AnyObject]]
                    }
                    var addressDetail:[String:AnyObject] = [:]
                    if _data.keys.contains("addressDetail"){
                        addressDetail = _data["addressDetail"] as! [String : AnyObject]
                    }
                    var orderLog:[[String:AnyObject]] = []
                    if _data.keys.contains("orderLog"){
                        orderLog = _data["orderLog"] as! [[String : AnyObject]]
                    }
                    var personInfo:[String:AnyObject] = [:]
                    if _data.keys.contains("personInfo"){
                        personInfo = _data["personInfo"] as! [String : AnyObject]
                    }
                    
                    if _data.keys.contains("settlementTime"){
                        self.time = _data ["settlementTime"] as! String
                    }
                    
                    var orderMainArray = [QZHOrderMainDetailViewModel]()
                    var orderSubArray = [QZHOrderSubDetailViewModel]()
                    var addressDetailArray = [QZHOrderAddressDetailViewModel]()
                    var orderLogArray = [QZHOrderLogDetailViewModel]()
                    var personInfoArray = [QZHOrderPersonInfoDetailViewModel]()
                    
                    let mainDic = PublicFunction().setNULLInDIC(orderMain)
                    let mainModel = QZHOrderMainDetailModel.yy_model(with: mainDic)
                    orderMainArray.append(QZHOrderMainDetailViewModel(model:mainModel!))
                    
                    for dic in orderSub {
                        let newDic = PublicFunction().setNULLInDIC(dic)
                        //a）创建企业模型
                        let model = QZHOrderSubDetailModel.yy_model(with:newDic)
                        
                        //b）将model添加到数组
                        orderSubArray.append(QZHOrderSubDetailViewModel(model:model!))
                    }
                    
                    let addressDetailDic = PublicFunction().setNULLInDIC(addressDetail)
                    let addressDetailModel = QZHOrderAddressDetailModel.yy_model(with: addressDetailDic)
                    addressDetailArray.append(QZHOrderAddressDetailViewModel(model:addressDetailModel!))
                    
                    
                    for dic in orderLog {
                        let newDic = PublicFunction().setNULLInDIC(dic)
                        //a）创建企业模型
                        let model = QZHOrderLogDetailModel.yy_model(with:newDic)
                        
                        //b）将model添加到数组
                        orderLogArray.append(QZHOrderLogDetailViewModel(model:model!))
                    }
                   // let orderLogDic = PublicFunction().setNULLInDIC(orderLog)
                    //let orderLogModel = QZHOrderLogDetailModel.yy_model(with: orderLogDic)
                    //orderLogArray.append(QZHOrderLogDetailViewModel(model:orderLogModel!))
                    
                    let personInfoDic = PublicFunction().setNULLInDIC(personInfo)
                    let personInfoModel = QZHOrderPersonInfoDetailModel.yy_model(with: personInfoDic)
                    personInfoArray.append(QZHOrderPersonInfoDetailViewModel(model:personInfoModel!))
                    
                    self.orderMainStatus = orderMainArray
                    self.orderSubStatus = orderSubArray
                    self.addressDetailStatus = addressDetailArray
                    self.orderLogStatus = orderLogArray
                    self.personInfoStatus = personInfoArray
                    
                    completion(isSuccess)
                }
            }
        }
    }
}
