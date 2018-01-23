//
//  QZHEnterpriseDetailModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/16.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 2

class QZHEnterpriseDetailViewModels:NSObject{
    
    /// 企业信息视图模型数组懒加载
    lazy var detailList = [QZHEnterpriseDetailViewModel]()
    lazy var infoList = [QZHEnterpriseInfoViewModel]()
    
    func loadInfo(completion:@escaping (_ r1:[QZHEnterpriseDetailViewModel],_ r2:[QZHEnterpriseInfoViewModel],_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(url: "portal/myStore/companyIntroduce/\(QZHEnterpriseDetailModel.memberId)", params: [:]) { (result, isSuccess) in
            if !isSuccess{
                print("网络错误！！！")
                completion([],[],false)
            }else{
                if result["status"]as! Int != 200{
                    print("数据异常！！！")
                    completion([],[],false)
                }else{
                    let _data:Dictionary<String,AnyObject> = result["data"] as! Dictionary<String, AnyObject>
                    
                    let _detail:Dictionary<String,AnyObject> = _data["eipMember"] as! Dictionary<String, AnyObject>
                    
                    let _info:Dictionary<String,AnyObject> = _data["eipInfo"] as! Dictionary<String, AnyObject>
                    
                    let detailDic = PublicFunction().setNULLInDIC(_detail)
                    
                    let models = QZHEnterpriseDetailModel.yy_model(with: detailDic)
                    self.detailList.append(QZHEnterpriseDetailViewModel(model:models!))
                    
                    let infoDic = PublicFunction().setNULLInDIC(_info)
                    let model = QZHEnterpriseInfoModel.yy_model(with: infoDic)
                    self.infoList.append(QZHEnterpriseInfoViewModel(model:model!))
                    completion(self.detailList,self.infoList,isSuccess)

                }
            }
        }
    }
    
}
