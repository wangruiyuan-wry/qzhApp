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
    
    /// 获取结算页信息
    ///
    /// - Parameter completion: 回调方法
    func getOrderList(completion:@escaping (_ isSuccess:Bool,_ totalMoney:Double)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/settlement/list", params: ["ids":QZH_CYSQCarSettlementModel.ids as AnyObject]) { (result, isSuccess) in
            if isSuccess{
                if result["status"] as! Int != 200{
                    completion(false,0.0)
                }else{
                    print(result)
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    
                    // 地址信息
                    let _addressInfo:[String:AnyObject] = _data["addressInfo"] as! [String : AnyObject]
                    var listAddress = [QZH_CYSQCarSettlementAddressViewModel]()
                    let addressDic = PublicFunction().setNULLInDIC(_addressInfo)
                    //a）创建地址模型
                    let model = QZH_CYSQCarSettlementAddressModel.yy_model(with:addressDic)
                    
                    //b）将model添加到数组
                    listAddress.append(QZH_CYSQCarSettlementAddressViewModel(model:model!))
                    
                    self.addressStatus = listAddress
                    
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
    
}
