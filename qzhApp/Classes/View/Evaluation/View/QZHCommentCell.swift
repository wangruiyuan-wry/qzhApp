//
//  QZHCommentCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/27.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHCommentCell: UITableViewCell {

    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var starView: QZHUIView!
    @IBOutlet weak var line1: QZHUILabelView!
    
    @IBOutlet weak var commentView: UITextView!
    
    @IBOutlet weak var line2: QZHUILabelView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        proImg.frame = CGRect(x:20*PX,y:20*PX,width:120*PX,height:120*PX)
        proImg.image = UIImage(named:"loadpic")
        
        starView.setupViews(x: 180*PX, y: 55*PX, width: 550*PX, height: 50*PX, bgColor: UIColor.clear)
        starView.tag = 0
        let proleft = 90*PX
        for i in 0..<5{
            let stars:UIImageView = UIImageView(frame:CGRect(x:proleft*CGFloat(i),y:0,width:50*PX,height:50*PX))
            stars.image = UIImage(named:"star1")
            stars.tag = i + 1
            stars.addOnClickLister(target: self, action: #selector(self.setStar(_:)))
            starView.addSubview(stars)
        }
        
        line1.dividers(0, y: 160*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayEB())
        line2.dividers(0, y: 401*PX, width: SCREEN_WIDTH, height: 20*PX, color: myColor().grayF0())
        
        commentView.frame = CGRect(x:20*PX,y:180*PX,width:710*PX,height:201*PX)
        commentView.font = UIFont.systemFont(ofSize: 28*PX)
        commentView.textColor = myColor().gray3()
        commentView.text = ""
        commentView.zw_placeHolder = "说说你的使用心得"
        commentView.zw_placeHolderColor = myColor().gray9()

    }

    // 星级评分
    func setStar(_ sender:UITapGestureRecognizer){
        let _this:UIView = sender.view!
        let children:[UIImageView] = _this.superview?.subviews as! [UIImageView]
        for child in children{
            if _this.tag < child.tag{
                child.image = UIImage(named:"star3")
            }else{
                child.image = UIImage(named:"star")
            }
        }
        _this.superview?.tag = _this.tag
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
