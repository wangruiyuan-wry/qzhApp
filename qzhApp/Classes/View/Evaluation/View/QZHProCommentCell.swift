//
//  QZHProCommentCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/5/2.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHProCommentCell: UITableViewCell {

    @IBOutlet weak var CommentView: QZHUIView!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: QZHUILabelView!
    @IBOutlet weak var flag: QZHUILabelView!
    @IBOutlet weak var time: QZHUILabelView!
    @IBOutlet weak var commentLabel: QZHUILabelView!
    @IBOutlet weak var line: QZHUILabelView!
    @IBOutlet weak var checke: QZHUILabelView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CommentView.setupViews(x: 20*PX, y: 0, width: 710*PX, height: 205*PX, bgColor: myColor().grayF0())
        userPhoto.frame = CGRect(x:20*PX,y:20*PX,width:50*PX,height:50*PX)
        userPhoto.image = UIImage(named:"proUserLogo")
        userPhoto.layer.cornerRadius = 25*PX
        userPhoto.layer.masksToBounds = true
        
        userName.setLabelView(90*PX, 27*PX, 150*PX, 36*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 26, "")
        let width = userName.autoLabelWidth(userName.text!, font: 26, height: 36*PX)
        if width < 250*PX{
            userName.width = width
        }else{
            userName.width = 250*PX
            userName.lineBreakMode = .byTruncatingTail
        }
        
        flag.setLabelView(userName.x + userName.width + 10*PX, 31*PX, 65*PX, 30*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 20, "买家")
        flag.layer.borderColor = myColor().blue007aff().cgColor
        flag.layer.borderWidth = 1*PX
        flag.layer.cornerRadius = 8*PX
        flag.layer.masksToBounds = true
        
        time.setLabelView(480*PX, 31*PX, 211*PX, 28*PX, NSTextAlignment.right, UIColor.clear, myColor().Gray6(), 20, "")
        
        commentLabel.setLabelView(18*PX, 90*PX, 673*PX, 180*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 24, "")
        commentLabel.numberOfLines = 0
        commentLabel.height = commentLabel.autoLabelHeight(commentLabel.text!, font: 25, width: 673*PX)
        
        line.dividers(0, y: commentLabel.height + 105*PX, width: 710*PX, height: 1*PX, color: myColor().GrayD8())
        
        checke.setLabelView(20*PX, 0, 710*PX, 79*PX, NSTextAlignment.center, myColor().grayF0(), myColor().gray9(), 24, "查看全部")
        checke.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
