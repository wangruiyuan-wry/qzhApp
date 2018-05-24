//
//  QZHMarketCompanyListViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/4.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHMarketCompanyListViewModel: NSObject {
    
    // 公司基本信息列表视图懒加载
    lazy var CompanyInfo = [QZHMarketCompanyInfoViewModel]()
    
    // 公司详细信息列表视图懒加载
    lazy var Company = [QZHMarketCompanyViewModel]()
    
    /// 加载公司基本信息
    ///
    /// - Parameter completion: 会点方法
    func loadCompany(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "crm/company/detail", params: ["id":QZHMarketCompanyInfoModel.id as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false)
            }else{
                if result["status"] as! Int != 200{
                    completion(false)
                }else{
                    
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    let _companyInfo:[String:AnyObject] = _data["companyInfo"] as! [String : AnyObject]
                    var companyInfoArray:[QZHMarketCompanyInfoViewModel] = []
                    //对字典进行处理
                    let newDict = PublicFunction().setNULLInDIC(_companyInfo)
                    //a）创建企业模型
                    let model = QZHMarketCompanyInfoModel.yy_model(with:newDict)
                    //b）将model添加到数组
                    companyInfoArray.append(QZHMarketCompanyInfoViewModel(model:model!))
                    //2. FIXME 拼接数据
                    self.CompanyInfo = companyInfoArray

                    let _company:[String:AnyObject] = _data["company"] as! [String : AnyObject]
                    var companyArray:[QZHMarketCompanyViewModel] = []
                    
                    //对字典进行处理
                    let newDict1 = PublicFunction().setNULLInDIC(_company)
                    //a）创建企业模型
                   let model1 = QZHMarketCompanyModel.yy_model(with:newDict1)                     
                    //b）将model添加到数组
                    companyArray.append(QZHMarketCompanyViewModel(model:model1!))
                    //2. FIXME 拼接数据
                    self.Company = companyArray
                    
                    completion(isSuccess)
                }
            }
        }
    }
    
    /// 加入收藏
    ///
    /// - Parameter completion: 回调方法
    func collectCompany(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "crm/company/insert", params: ["companyId":QZHMarketCompanyInfoModel.id as AnyObject,"collectType":QZHMarketCompanyInfoModel.collectType as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false)
            }else{
                if result["status"] as! Int == 200{
                    completion(true)
                }else{
                    completion(false)
                }
            }
        }
    }
    
}
