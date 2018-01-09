//
//  EnterprisePortalControllerData.swift
//  qzhApp
//
//  Created by sbxmac on 2017/12/28.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

class EnterprisePortalData: NSObject {
    func getData(pageNo:Int)->Dictionary<String,AnyObject>{
        let data:Dictionary<String,AnyObject>=Dictionary()
        let pageSize:Int=15
        NetworkRequest().postRequest("portal/myStore/enterpriseList/\(pageNo)/\(pageSize)", params: [:], urlType: 0, success: {
            (reponse)->Void in
                print(reponse)
            //  data
            
        }, failture: {
            (error)->Void in
           // PublicFunction().alertPromptNET(EnterprisePortalViewController.self())
            print("网络错误:\(error)")
            //return data
        })
        return data
    }

}
