//
//  EnterprisePortalView.swift
//  qzhApp
//
//  Created by sbxmac on 2017/12/28.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

class EnterprisePortalView: UIView,UITableViewDelegate {
    
    
}
extension EnterprisePortalViewController{
    class var pageNo:Int{
        get{
            return Varribles.pageNo
        }
        set{
            Varribles.pageNo=newValue
        }
    }
    class var width:CGFloat{
        get{
            return Varribles.width
        }
        set{
            Varribles.width=newValue
        }
    }
    class var height:CGFloat{
        get{
            return Varribles.height
        }
        set{
            Varribles.height=newValue
        }
    }
}
