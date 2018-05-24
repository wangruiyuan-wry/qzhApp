//
//  QZHEvalustionInfoCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/27.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHEvalustionInfoCell: UITableViewCell {

    @IBOutlet weak var listView: QZHUIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: QZHUILabelView!
    @IBOutlet weak var which: QZHUILabelView!
    @IBOutlet weak var createTime: QZHUILabelView!
    @IBOutlet weak var content: QZHUILabelView!
    @IBOutlet weak var line: QZHUILabelView!
    
    @IBOutlet weak var btn: QZHUILabelView!
    var cellHeight:CGFloat = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btn.setLabelView(20*PX, 0, 710*PX, 79*PX, NSTextAlignment.center, myColor().grayF0(), myColor().gray9(), 24, "")
        
        img.frame = CGRect(x:20*PX,y:20*PX,width:50*PX,height:50*PX)
        img.image = UIImage(named:"noHeader")
        img.layer.cornerRadius = 25*PX
        img.layer.masksToBounds = true
        
        name.setLabelView(90*PX, 26*PX, 131*PX, 38*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 26, "")
        name.width = name.autoLabelWidth(name.text!, font: 26, height: 38*PX)
        
        which.setLabelView(name.width + name.x + 9*PX, 30*PX, 60*PX, 30*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 20, "买家")
        which.layer.borderColor = myColor().blue007aff().cgColor
        which.layer.borderWidth = 1*PX
        which.layer.cornerRadius = 8*PX
        which.layer.masksToBounds = true
        
        createTime.setLabelView(480*PX, 30*PX, 211*PX, 29*PX, NSTextAlignment.right, UIColor.clear, myColor().Gray6(), 20, "")
        
        content.setLabelView(18*PX, 90*PX, 673*PX, 70*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 24, "")
        content.height = content.autoLabelHeight(content.text!, font: 24, width: 673*PX)
        
        line.dividers(0, y: content.y + content.height + 20*PX, width: 710*PX, height: 1*PX, color: myColor().GrayD8())
        
        cellHeight = line.y + line.height
        
        listView.setupViews(x: 20*PX, y: 0, width: 710*PX, height: cellHeight, bgColor: myColor().grayF0())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
