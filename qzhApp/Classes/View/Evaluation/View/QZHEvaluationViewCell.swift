//
//  QZHEvaluationViewCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/27.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHEvaluationViewCell: UITableViewCell {

    @IBOutlet weak var creatTime: QZHUILabelView!
    @IBOutlet weak var proSpec: QZHUILabelView!
    @IBOutlet weak var starView: QZHUIView!
    @IBOutlet weak var commentLabel: QZHUILabelView!
    @IBOutlet weak var proView: QZHUIView!
    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var ProName: QZHUILabelView!
    @IBOutlet weak var icon: QZHUILabelView!
    @IBOutlet weak var price: QZHUILabelView!
    @IBOutlet weak var check: QZHUILabelView!
    @IBOutlet weak var AddComment: QZHUILabelView!
    @IBOutlet weak var line: QZHUILabelView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        creatTime.setLabelView(20*PX, 25*PX, 180*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray9(), 24, "")
        
        proSpec.setLabelView(180*PX, 25*PX, 300*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray9(), 24, "")
        proSpec.lineBreakMode = .byTruncatingTail
        
        starView.setupViews(x: 550*PX, y: 26*PX, width: 180*PX, height: 28*PX, bgColor: UIColor.clear)
        
        commentLabel.setLabelView(20*PX, 79*PX, 710*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, "")
        
        proView.setupViews(x: 20*PX, y: 139*PX, width: 710*PX, height: 165*PX, bgColor: myColor().grayF9())
        
        proImg.frame = CGRect(x:2*PX,y:2*PX,width:160*PX,height:160*PX)
        proImg.image = UIImage(named:"loadPic")
        
        ProName.setLabelView(178*PX, 0, 496*PX, 70*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, "")
        ProName.numberOfLines = 2
        ProName.lineBreakMode = .byTruncatingTail
        
        icon.setLabelView(178*PX, 123*PX, 18*PX, 30*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 20, "¥")
        price.setLabelView(196*PX, 115*PX, 300*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, "")
        
        check.setLabelView(500*PX, 323*PX, 98*PX, 48*PX, NSTextAlignment.center, UIColor.white, myColor().gray9(), 22, "查看评论")
        check.layer.borderColor = myColor().gray9().cgColor
        check.layer.borderWidth = 1*PX
        
        AddComment.setLabelView(630*PX, 323*PX, 98*PX, 48*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 22, "写追评")
        AddComment.layer.borderColor = myColor().blue007aff().cgColor
        AddComment.layer.borderWidth = 1*PX
        
        line.dividers(0, y: 394*PX, width: SCREEN_WIDTH, height: 19*PX, color: myColor().grayF0())
        
    }
    
    func setStar(_ num:Int){
        let left:CGFloat = 38*PX
        for i in 0..<5{
            let star:UIImageView = UIImageView(frame:CGRect(x:left*CGFloat(i),y:0,width:28*PX,height:28*PX))
            if num > i{
                star.image = UIImage(named:"star")
            }else{
                star.image = UIImage(named:"star1")
            }
            starView.addSubview(star)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
