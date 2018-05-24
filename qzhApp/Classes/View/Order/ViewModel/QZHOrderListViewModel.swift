//
//  QZHOrderListViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/29.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 1

class QZHOrderListViewModel:NSObject{
    
    // 主订单列表视图模型懒加载
    lazy var OrderMainList = [QZHOrderMainViewModel]()
    
    // 子订单列表视图模型懒加载
    lazy var OrderSubList:[[QZHOrderSubViewModel]] = []
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    
    
    /// 获取订单列表
    ///
    /// - Parameters:
    ///   - pullup: 是否上拉加载
    ///   - completion: 回调方法
    func getOrderList(pullup:Bool = false,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        //判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes{
            
            completion(true,false)
            
            return
        }
        
        if pullup{
            QZHOrderListModel.pageNo = QZHOrderListModel.pageNo+1
        }else{
            QZHOrderListModel.pageNo = 1
        }
        
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/orderMain/listOrderMian", params: ["status":QZHOrderListModel.status as AnyObject,"pageNo":QZHOrderListModel.pageNo as AnyObject,"pageSize":QZHOrderListModel.pageSize as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false,false)
            }else{
                if result["status"] as! Int != 200{
                    completion(false,false)
                }else{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    let orderInfo:[[String:AnyObject]] = _data["orderInfo"] as! [[String : AnyObject]]
                    var orderMainListArray = [QZHOrderMainViewModel]()
                    var orderSubArray:[[QZHOrderSubViewModel]] = []
                    for dic in orderInfo {
                        let orderMain:[String:AnyObject] = dic["orderMain"] as! [String : AnyObject]
                        let newDic = PublicFunction().setNULLInDIC(orderMain)
                        //a）创建企业模型
                        let model = QZHOrderMainModel.yy_model(with:newDic)
                        
                        //b）将model添加到数组
                        orderMainListArray.append(QZHOrderMainViewModel(model:model!))
                        var _subList = [QZHOrderSubViewModel]()
                        let _orderSub:[[String:AnyObject]] = dic["orderSub"] as! [[String : AnyObject]]
                        for _orderSubDic in _orderSub{
                            let newsDic = PublicFunction().setNULLInDIC(_orderSubDic)
                            let models = QZHOrderSubModel.yy_model(with: newsDic)
                            _subList.append(QZHOrderSubViewModel.init(model: models!))
                        }
                        orderSubArray.append(_subList)
                    }
                    
                    //2. FIXME 拼接数据
                    if pullup{
                        
                        self.OrderMainList += orderMainListArray
                        self.OrderSubList += orderSubArray
                        
                    }else{
                        
                        self.OrderMainList = orderMainListArray
                        self.OrderSubList = orderSubArray
                        
                    }
                    
                    //3.判断上拉刷新的数据量
                    if pullup && orderMainListArray.count == 0 {
                        
                        self.pullupErrorTimes += 1
                        
                        completion(false, false)
                    }else{
                        
                        //完成回调
                        completion(isSuccess,true)
                    }

                }
            }
        }
    }
    
    /// 更改订单状态
    ///
    /// - Parameter completion: 回调方法
    func editOrderStatus(completion:@escaping (_ isSuccess:Bool,_ msg:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/orderMain/alertOrderMainStatus", params: ["orderNumber":QZHOrderListModel.orderNumber as AnyObject,"flag":QZHOrderListModel.flag  as AnyObject]) { (result, isSuccess) in
            print("result:\(result)")
            if !isSuccess{
                completion(false,"操作失败------")
            }else{
                if result["status"] as! Int == 200{
                    completion(true,"操作成功")
                }else{
                    completion(false,"操作失败,\(result["data"]!)")
                }
            }
        }
    }
    
    /// 删除订单
    ///
    /// - Parameter completion: 回调方法
    func delOrder(completion:@escaping (_ isSuccess:Bool,_ msg:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/orderMain/deleteOrderMain", params: ["orderNumber":QZHOrderListModel.orderNumber as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false,"操作失败")
            }else{
                if result["status"] as! Int == 200{
                    completion(true,"操作成功")
                }else{
                    completion(false,"操作失败")
                }
            }
        }
    }
}
