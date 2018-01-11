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
    @IBOutlet weak var producList: labelView!
    
    //联系电话
    @IBOutlet weak var contactTEL: labelView!

    //地址文本
    @IBOutlet weak var address: labelView!
    
    //地址小图标
    @IBOutlet weak var addressICON: imgClass!
    
    //企业列表视图模型
    /*var viewModel:QZHEnterprisePortalViewModel{
        didSet{
            
        }
    }*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
    
    func setupCell(){
        
    }
}

//MARK:-列表项布局
extension QZHEnterprisePortalStatusCell{
}
