//
//  EnterprisePortalViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2017/12/28.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class EnterprisePortalViewModel:NSObject{
    //公司列表
    struct CompanyViewModel {
        let companyName:Driver<String>
        let prodcutName:Driver<String>
        let companyPic:Driver<String>
        let contactTel:Driver<String>
        let address:Driver<String>
        let CompanyID:Driver<Int>
    }
    //var provinceIndex=0    var cityIndedx=0      var areaIndex=0
    struct adressModel {
        static var province:String=""
        static var city:String=""
        static var area:String=""
    }
    
    struct screening {
        static var EnterpriseType:String=""
        static var primaryIndustry:String=""
        static var secondaryIndustry:String=""
    }
}

extension EnterprisePortalViewModel{
    class var province:String{
        set{adressModel.province=newValue}
        get{return adressModel.province}
    }
    class var city:String{
        set{adressModel.city=newValue}
        get{return adressModel.city}
    }
    class var area:String{
        set{adressModel.area=newValue}
        get{return adressModel.area}
    }
    class var EnterpriseType:String{
        set{screening.EnterpriseType=newValue}
        get{return screening.EnterpriseType}
    }
    class var primaryIndustry: String{
        set{screening.primaryIndustry=newValue}
        get{return screening.primaryIndustry}
    }
    class var secondaryIndustry: String {
        set{screening.secondaryIndustry=newValue}
        get{return screening.secondaryIndustry}
    }
}
