//
//  CustomQZHCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/20.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class CustomQZHCell: UITableViewCell {

    @IBOutlet weak var title: QZHUILabelView!
    @IBOutlet weak var selectText: QZHUILabelView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var ListArray: QZHUIView!
    @IBOutlet weak var allList: QZHUIView!
    var open:QZHUIView = QZHUIView()
    
    var cellHeight:CGFloat = 0
    var listHeight:CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        title.setLabelView(0, 20*PX, 120*PX, 33*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 24, "")
        selectText.setLabelView(400*PX, 20*PX, 109*PX, 33*PX, NSTextAlignment.right, UIColor.clear, myColor().blue007aff(), 24, "")
        selectText.numberOfLines = 1
        selectText.lineBreakMode = .byTruncatingTail 
        
        icon.frame = CGRect(x:529*PX,y:26*PX,width:27*PX,height:17*PX)
        icon.image = UIImage(named:"closeIcon")
        
        open.setupViews(x: 400*PX, y: 0, width: 200*PX, height: 53*PX, bgColor: UIColor.clear)
         self.addSubview(open)
        
        allList.isHidden = true
        allList.setupViews(x: 0, y: 53*PX, width: 560*PX, height: 199*PX, bgColor: UIColor.clear)
        ListArray.setupViews(x: 0, y: 53*PX, width: 560*PX, height: 199*PX, bgColor: UIColor.clear)
        ListArray.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupList(x:CGFloat,y:CGFloat,title:String,id:Int,sel:Bool)->[String:CGFloat]{
        let btn:QZHUILabelView = QZHUILabelView()
        btn.layer.cornerRadius = 8*PX
        btn.layer.masksToBounds = true
        btn.setLabelView(x, y, 173*PX, 60*PX, NSTextAlignment.center, myColor().GrayF1F2F6(), myColor().Gray6(), 24, title)
        btn.layer.borderColor = myColor().GrayF1F2F6().cgColor
        btn.layer.borderWidth = 1*PX
        btn.tag = id
        btn.addOnClickLister(target: self, action: #selector(self.click(_:)))
        ListArray.addSubview(btn)
        if listHeight > 199*PX{
            ListArray.height = listHeight
        }
        
        if sel{
            btn.layer.borderColor = myColor().blue007aff().cgColor
            btn.layer.borderWidth = 1*PX
            btn.restorationIdentifier = "sel"
            btn.textColor = myColor().blue007aff()
            btn.backgroundColor = UIColor.white
        }
        
        // allList.addSubview(btn)

        let dic:[String:CGFloat] = ["x":x+192*PX,"y":y]
        listHeight = y+80*PX
        cellHeight = listHeight + 53*PX
        return dic
    }

    
    func click(_ sender:UITapGestureRecognizer){
        let _this:QZHUILabelView = sender.view as! QZHUILabelView
        if _this.restorationIdentifier == "sel"{
            _this.restorationIdentifier = ""
            _this.backgroundColor = myColor().GrayF1F2F6()
            _this.textColor = myColor().Gray6()
            _this.layer.borderColor = myColor().GrayF1F2F6().cgColor
        }else{
            _this.restorationIdentifier = "sel"
            _this.backgroundColor = UIColor.white
            _this.textColor = myColor().blue007aff()
            _this.layer.borderColor = myColor().blue007aff().cgColor
        }
        
        selectText.text = ""
        selectText.restorationIdentifier = ""
        let children:[QZHUILabelView] = self.ListArray.subviews as! [QZHUILabelView]
        for child in children{
            if child.restorationIdentifier == "sel"{
                if selectText.text != ""{
                    selectText.text = "\(selectText.text!),\(child.text!)"

                    selectText.restorationIdentifier = "\(selectText.restorationIdentifier!),\(child.tag)"
                }else{
                    selectText.text = "\(child.text!)"
                    selectText.restorationIdentifier = "\(child.tag)"
                }
            }
        }
    }
    
}
