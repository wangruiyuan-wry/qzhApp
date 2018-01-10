//
//  QZHEnterprisePortalStatusCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/10.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHEnterprisePortalStatusCell: UITableViewCell {
    
    //企业 logo 图片
    @IBOutlet weak var logoImg: imgClass!

    //公司名称
    @IBOutlet weak var companyName: labelView!
    
    //主营产品
    @IBOutlet weak var producList: labelView!
    
    //联系电话
    @IBOutlet weak var contactTEL: labelView!
    
    //地址文本
    @IBOutlet weak var address: labelView!
    
    //地址小图标
    @IBOutlet weak var addressICON: imgClass!
    
    //分割线
    @IBOutlet weak var dividerLine: UILabel!
    
    //企业列表视图模型
    var viewModel:QZHEnterprisePortalViewModel{
        didSet{
            
        }
    }
}
