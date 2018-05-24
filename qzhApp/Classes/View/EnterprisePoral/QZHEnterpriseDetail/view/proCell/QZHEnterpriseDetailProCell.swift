//
//  QZHEnterpriseDetailProCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/19.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 企业列表 Cell 的协议
/// 如果需要设置可选协议方法
/// - 需要遵守 NSObjectProtocol 协议
/// - 协议需要是 @objc 的
/// - 方法需要 @objc optional
@objc protocol QZHEnterpriseDetailProCellDelegate: NSObjectProtocol {
    
    /// 企业列表 Cell 选中 URL 字符串
    @objc optional func statusCellDidSelectedURLString(cell: QZHEnterpriseDetailProCell, urlString: String)
}

class QZHEnterpriseDetailProCell: UITableViewCell {
    weak var delegate:QZHEnterpriseDetailProCellDelegate?
    
    //产品图片
    @IBOutlet weak var proLogo: UIImageView!
    
    //产品名称
    @IBOutlet weak var proName: QZHUILabelView!
    
    //产品规格
    @IBOutlet weak var proSpec: QZHUILabelView!
    
    //产品价格
    @IBOutlet weak var proPrice: QZHUILabelView!
    
    //收藏
    @IBOutlet weak var proCllection: QZHUIButton!
    
    //购物车
    @IBOutlet weak var proCar: QZHUIButton!
    
    //分割线
    @IBOutlet weak var line: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        proLogo.frame = CGRect(x:30*PX,y:20*PX,width:200*PX,height:200*PX)
        proLogo.image = UIImage(named:"noPic")
        
        proName.setLabelView(260*PX, 20*PX, 460*PX, 70*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, "")
        proName.lineBreakMode = NSLineBreakMode.byCharWrapping
        proName.numberOfLines = 2
        
        proSpec.setLabelView(260*PX, 100*PX, 460*PX, 25*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray8(), 26, "颜色分类：")
        
        proPrice.setLabelView(260*PX, 170*PX, 298*PX, 30*PX, .left, UIColor.clear, myColor().redFf4300(), 36, "")
        
        proCllection.frame = CGRect(x:558*PX,y:170*PX,width:36*PX,height:30*PX)
        proCllection.setBackgroundImage(UIImage(named:"collectionIcon"), for: .normal)
        
        proCar.frame = CGRect(x:664*PX,y:170*PX,width:36*PX,height:34*PX)
        proCar.setBackgroundImage(UIImage(named:"carIcon"), for: .normal)
        
        line.frame = CGRect(x:260*PX,y:240*PX,width:490*PX,height:1*PX)
        line.backgroundColor = myColor().grayF0()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
