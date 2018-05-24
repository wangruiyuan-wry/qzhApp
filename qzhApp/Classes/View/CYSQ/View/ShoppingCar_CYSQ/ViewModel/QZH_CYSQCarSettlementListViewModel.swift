//
//  QZH_CYSQCarSettlementListViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/19.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZH_CYSQCarSettlementListViewModel: NSObject {
    
    // 地址视图列表懒加载
    lazy var addressStatus = [QZH_CYSQCarSettlementAddressViewModel]()
    
    // 店铺视图懒加载
    lazy var storeStatus = [QZH_CYSQCarSettlementStoreViewModel]()
    
    // 产品信息视图模型懒加载
    lazy var proStatus:[[QZH_CYSQCarSettlementProViewModel]] = []
    
    // 账期支付视图模型
    lazy var periodStatus = [QZH_CYSQCarAccountPeriodInfoViewModel]()
    
    /// 获取结算页信息
    ///
    /// - Parameter completion: 回调方法
    func getOrderList(completion:@escaping (_ isSuccess:Bool,_ totalMoney:Double)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/settlement/list", params: ["ids":QZH_CYSQCarSettlementModel.ids as AnyObject]) { (result, isSuccess) in
            if isSuccess{
                if result["status"] as! Int != 200{
                    completion(false,0.0)
                }else{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    
                    // 地址信息
                    var _addressInfo:[String:AnyObject] = [:]
                    //if _data["addressInfo"] as! String == "" {
                    
                    //}else{
                        _addressInfo = _data["addressInfo"] as! [String : AnyObject]
                    //print("_addressInfo:\(_addressInfo)")
                    //}
                    var listAddress = [QZH_CYSQCarSettlementAddressViewModel]()
                    let addressDic = PublicFunction().setNULLInDIC(_addressInfo)
                    //a）创建地址模型
                    let model = QZH_CYSQCarSettlementAddressModel.yy_model(with:addressDic)
                    
                    //b）将model添加到数组
                    listAddress.append(QZH_CYSQCarSettlementAddressViewModel(model:model!))
                    
                        self.addressStatus = listAddress
                    
                    // 帐期信息
                    var periodList = [QZH_CYSQCarAccountPeriodInfoViewModel]()
                    if _data.keys.contains("accountPeriodInfo"){
                        let period:[String:AnyObject] = _data["accountPeriodInfo"] as! [String : AnyObject]
                        let periodDic = PublicFunction().setNULLInDIC(period)
                        //a）创建地址模型
                        let models1 = QZH_CYSQCarAccountPeriodInfoModel.yy_model(with:periodDic)
                        
                        //b）将model添加到数组
                        periodList.append(QZH_CYSQCarAccountPeriodInfoViewModel(model:models1!))
                        self.periodStatus = periodList
                    }else{
                        self.periodStatus = []
                    }
                    
                    
                    // 店铺信息
                    let _store:[[String:AnyObject]] = _data["product"] as! [[String : AnyObject]]
                    var listStore = [QZH_CYSQCarSettlementStoreViewModel]()
                    var proArray:[[QZH_CYSQCarSettlementProViewModel]] = []
                    for _dic in _store{
                        let storeDic = PublicFunction().setNULLInDIC(_dic)
                        //a）创建地址模型
                        let model = QZH_CYSQCarSettlementStoreModel.yy_model(with:storeDic)
                        
                        //b）将model添加到数组
                        listStore.append(QZH_CYSQCarSettlementStoreViewModel(model:model!))
                        
                        // 产品信息
                        let proList:[[String:AnyObject]] = _dic["list"] as! [[String : AnyObject]]
                        var proListView = [QZH_CYSQCarSettlementProViewModel]()
                        for proDic in proList{
                            let model1 = QZH_CYSQCarSettlementProModel.yy_model(with:proDic)
                            proListView.append(QZH_CYSQCarSettlementProViewModel(model:model1!))
                        }
                        proArray.append(proListView)
                        
                    }
                    self.storeStatus = listStore
                    self.proStatus = proArray
                    completion(isSuccess,_data["totalMoney"] as! Double)
                }
            }
        }
    }
    
    /// 获取结算页信息(立即购买)
    ///
    /// - Parameter completion: 回调方法
    func getOrderList_buyNow(completion:@escaping (_ isSuccess:Bool,_ totalMoney:Double)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/settlement/insertSettlement", params: ["productId":QZH_CYSQCarSettlementModel.productId as AnyObject,"proCount":QZH_CYSQCarSettlementModel.proCount as AnyObject,"specOptionName":"\(QZH_CYSQCarSettlementModel.specOptionName)" as AnyObject]) { (result, isSuccess) in
            if isSuccess{
                if result["status"] as! Int != 200{
                    completion(false,0.0)
                }else{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    
                    // 地址信息
                    var _addressInfo:[String:AnyObject] = [:]
                    _addressInfo = _data["addressInfo"] as! [String : AnyObject]
                    var listAddress = [QZH_CYSQCarSettlementAddressViewModel]()
                    let addressDic = PublicFunction().setNULLInDIC(_addressInfo)
                    //a）创建地址模型
                    let model = QZH_CYSQCarSettlementAddressModel.yy_model(with:addressDic)
                    
                    //b）将model添加到数组
                    listAddress.append(QZH_CYSQCarSettlementAddressViewModel(model:model!))
                    
                    self.addressStatus = listAddress
                    
                    // 帐期信息
                    var periodList = [QZH_CYSQCarAccountPeriodInfoViewModel]()
                    if _data.keys.contains("accountPeriodInfo"){
                        let period:[String:AnyObject] = _data["accountPeriodInfo"] as! [String : AnyObject]
                        let periodDic = PublicFunction().setNULLInDIC(period)
                        
                        //a）创建地址模型
                        let models1 = QZH_CYSQCarAccountPeriodInfoModel.yy_model(with:periodDic)
                        
                        //b）将model添加到数组
                        periodList.append(QZH_CYSQCarAccountPeriodInfoViewModel(model:models1!))
                        self.periodStatus = periodList
                    }else{
                        self.periodStatus = []
                    }
                    
                    // 店铺信息
                    let _store:[[String:AnyObject]] = _data["product"] as! [[String : AnyObject]]
                    var listStore = [QZH_CYSQCarSettlementStoreViewModel]()
                    var proArray:[[QZH_CYSQCarSettlementProViewModel]] = []
                    for _dic in _store{
                        let storeDic = PublicFunction().setNULLInDIC(_dic)
                        //a）创建地址模型
                        let model = QZH_CYSQCarSettlementStoreModel.yy_model(with:storeDic)
                        
                        //b）将model添加到数组
                        listStore.append(QZH_CYSQCarSettlementStoreViewModel(model:model!))
                        
                        // 产品信息
                        let proList:[[String:AnyObject]] = _dic["list"] as! [[String : AnyObject]]
                        var proListView = [QZH_CYSQCarSettlementProViewModel]()
                        for proDic in proList{
                            let model1 = QZH_CYSQCarSettlementProModel.yy_model(with:proDic)
                            proListView.append(QZH_CYSQCarSettlementProViewModel(model:model1!))
                        }
                        proArray.append(proListView)
                        
                    }
                    self.storeStatus = listStore
                    self.proStatus = proArray
                    completion(isSuccess,_data["totalMoney"] as! Double)
                }
            }
        }
    }
    
    /// 下单(账期)
    ///
    /// - Parameter completion: 回调方法
    func insertOrderMain_Period(completion:@escaping (_ isSuccess:Bool,_ result:String,_ payNumber:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/orderMain/insertOrderMain", params: ["cartIds":QZH_CYSQCarSettlementModel.ids as AnyObject,"addressId":QZH_CYSQCarSettlementModel.addressId
            as AnyObject,"remark":QZH_CYSQCarSettlementModel.remark as AnyObject,"ui":QZH_CYSQCarSettlementModel.productId as AnyObject,"type":QZH_CYSQCarSettlementModel.type as AnyObject,"proCount":QZH_CYSQCarSettlementModel.proCount as AnyObject,"specOptionName":QZH_CYSQCarSettlementModel.specOptionName as AnyObject,"accountSettlementDays":QZH_CYSQCarSettlementModel.accountSettlementDays as AnyObject]) { (result, isSuccess) in
                print(result)
            if isSuccess{
                if result["status"] as!Int == 200{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    QZH_CYSQCarSettlementModel.payNumber = _data["payNumber"]! as! String
                     //QZHOrderDetailModel.orderNumber = _data["payNumber"]! as! String
                    completion(isSuccess, "下单成功！！",_data["payNumber"]! as! String)
                }else{
                    QZH_CYSQCarSettlementModel.payNumber = ""
                    QZHOrderDetailModel.orderNumber = ""
                    completion(false, result["msg"] as! String,"")
                }
                
            }else{
                QZH_CYSQCarSettlementModel.payNumber = ""
                QZHOrderDetailModel.orderNumber = ""
                completion(isSuccess, "下单失败！！","")
            }
        }
    }

    /// 下单
    ///
    /// - Parameter completion: 回调方法
    func insertOrderMain(completion:@escaping (_ isSuccess:Bool,_ result:String,_ payNumber:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/orderMain/insertOrderMain", params: ["cartIds":QZH_CYSQCarSettlementModel.ids as AnyObject,"addressId":QZH_CYSQCarSettlementModel.addressId
            as AnyObject,"remark":QZH_CYSQCarSettlementModel.remark as AnyObject,"productId":QZH_CYSQCarSettlementModel.productId as AnyObject,"type":QZH_CYSQCarSettlementModel.type as AnyObject,"proCount":QZH_CYSQCarSettlementModel.proCount as AnyObject,"specOptionName":QZH_CYSQCarSettlementModel.specOptionName as AnyObject,"accountSettlementDays":0 as AnyObject]) { (result, isSuccess) in
                if isSuccess{
                    if result["status"] as!Int == 200{
                        let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                        QZH_CYSQCarSettlementModel.payNumber = _data["payNumber"]! as! String
                        //QZHOrderDetailModel.orderNumber = _data["payNumber"]! as! String
                        completion(isSuccess, "下单成功！！",_data["payNumber"]! as! String)
                    }else{
                        QZH_CYSQCarSettlementModel.payNumber = ""
                        QZHOrderDetailModel.orderNumber = ""
                        completion(false, result["msg"] as! String,"")
                    }
                    
                }else{
                    QZH_CYSQCarSettlementModel.payNumber = ""
                    QZHOrderDetailModel.orderNumber = ""
                    completion(isSuccess, "下单失败！！","")
                }
        }
    }

    
    /// 支付宝支付
    ///
    /// - Parameter completion: 回调方法
    func paynow(completion:@escaping (_ isSuccess:Bool,_ url:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/alipay/payApp", params: ["payNumber":QZH_CYSQCarSettlementModel.payNumber as AnyObject]) { (reault, isSuccess) in
            print("支付宝支付：\(reault)")
            if reault["status"] as!Int == 200{
                let _data:[String:AnyObject] = reault["data"] as! [String : AnyObject]
                completion(isSuccess,_data["payUrl"] as!String)
            }else{
                completion(false,reault["data"] as!String)
            }
            
        }
    }
    
    
    /// 微信支付参数
    ///
    /// - Parameter completion: 回调方法
    func paynowWX(completion:@escaping (_ isSuccess:Bool,_ result:[String:AnyObject])->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/WeiXin/pay", params: ["payNumber":QZH_CYSQCarSettlementModel.payNumber  as AnyObject]) { (reault, isSuccess) in
            print("微信支付：\(reault)")
            completion(isSuccess,reault["data"] as! [String : AnyObject])
        }
    }
    
    /// 网银支付
    ///
    /// - Parameter completion: 回调方法
    func paynowWY(completion:@escaping (_ isSuccess:Bool,_ payData:[String:AnyObject])->()){
        QZHNetworkManager.shared.statusList(method: .GET, url: "order/PcAllinpay/getBankParams", params: ["payNumber":QZH_CYSQCarSettlementModel.payNumber  as AnyObject,"type":"APP_IOS" as AnyObject]) { (reault, isSuccess) in
            print("网银支付：\(reault)")
            completion(isSuccess,reault["data"] as! [String : AnyObject])
        }
    }
}
