//
//  QZHEnterprisePortalStatusCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/10.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 企业列表 Cell 的协议
/// 如果需要设置可选协议方法
/// - 需要遵守 NSObjectProtocol 协议
/// - 协议需要是 @objc 的
/// - 方法需要 @objc optional
@objc protocol QZHEnterprisePortalStatusCellDelegate: NSObjectProtocol {
    
    /// 企业列表 Cell 选中 URL 字符串
    @objc optional func statusCellDidSelectedURLString(cell: QZHEnterprisePortalStatusCell, urlString: String)
}

class QZHEnterprisePortalStatusCell: UITableViewCell {
    
    weak var delegate:QZHEnterprisePortalStatusCellDelegate?
    
    //企业 logo 图片
    @IBOutlet weak var logoImg: imgClass!

    //公司名称
    @IBOutlet weak var companyName: labelView!
    
    //主营产品
    @IBOutlet weak var productList: labelView!
    
    //联系电话
    @IBOutlet weak var contactTEL: labelView!

    //地址文本
    @IBOutlet weak var address: labelView!
    
    //地址小图标
    @IBOutlet weak var addressICON: imgClass!
    
    //分割线
    @IBOutlet weak var divider: labelView!
    
    //企业列表视图模型
    /*var viewModel:QZHEnterprisePortalViewModel{
        didSet{
            
        }
    }*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        logoImg.frame=CGRect(x:30*PX,y:30*PX,width:200*PX,height:200*PX)
        companyName.frame = CGRect(x:260*PX,y:30*PX,width:SCREEN_WIDTH-(290)*PX,height:30*PX)
        companyName.setupText(size: 30, color: myColor().gray3())
        
        productList.frame = CGRect(x:260*PX,y:74*PX,width:SCREEN_WIDTH-(290)*PX,height:26*PX)
        productList.setupText(size: 26, color: myColor().Gray8())
        
        contactTEL.frame = CGRect(x:260*PX,y:130*PX,width:SCREEN_WIDTH-(290)*PX,height:30*PX)
        contactTEL.setupText(size: 26, color: myColor().gray3())
        
        address.frame = CGRect(x:290*PX,y:200*PX,width:SCREEN_WIDTH-(320)*PX,height:30*PX)
        address.setupText(size: 24, color: myColor().gray3())
        
        addressICON.frame=CGRect(x:260*PX,y:203*PX,width:20*PX,height:26*PX)
        
        divider.divider(Int(30*PX), y: Int(260*PX), width: Int(SCREEN_WIDTH-60*PX), height: 1, color: myColor().grayE())
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
}
