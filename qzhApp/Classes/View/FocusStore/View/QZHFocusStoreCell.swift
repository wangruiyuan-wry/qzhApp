//
//  QZHFocusStoreCell.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHFocusStoreCell: UITableViewCell {

    @IBOutlet weak var storeImg: UIImageView!
    @IBOutlet weak var storeName: QZHUILabelView!
    @IBOutlet weak var levelImg: UIImageView!
    @IBOutlet weak var level: QZHUILabelView!
    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var line: QZHUILabelView!
    
    @IBOutlet weak var cancelBtn: QZHUIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        line.dividers(0, y: 140*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        
        storeImg.frame = CGRect(x:20*PX,y:20*PX,width:100*PX,height:100*PX)
        storeImg.image = UIImage(named:"loadPic")
        
        storeName.setLabelView(140*PX, 26*PX, 500*PX, 43*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 30, "")
        
        levelImg.frame = CGRect(x:141*PX,y:85*PX,width:23*PX,height:23*PX)
        levelImg.image = UIImage(named:"loadPic")
        
        level.setLabelView(170*PX, 81*PX, 400*PX, 30*PX, NSTextAlignment.left, UIColor.clear, myColor().yellowF5d96c(), 22, "")
        
        rightImg.frame = CGRect(x:670*PX,y:66*PX,width:30*PX,height:8*PX)
        rightImg.image = UIImage(named:"gzStoreRight")
        
        cancelBtn.setupViews(x: SCREEN_WIDTH, y: 0, width: 110, height: 141*PX, bgColor: myColor().blue007aff())
        let iconBtn:UIImageView = UIImageView(frame:CGRect(x:47*PX,y:34*PX,width:47*PX,height:41*PX))
        iconBtn.image = UIImage(named:"storeCancel")
        cancelBtn.addSubview(iconBtn)
        
        let titleBtn:QZHUILabelView = QZHUILabelView()
        titleBtn.setLabelView(0, 90*PX, 140*PX, 30*PX, NSTextAlignment.center, UIColor.clear, UIColor.white, 22, "取消关注")
        cancelBtn.addSubview(titleBtn)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
