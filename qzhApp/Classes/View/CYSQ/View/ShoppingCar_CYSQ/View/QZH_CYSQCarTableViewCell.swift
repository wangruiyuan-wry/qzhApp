//
//  QZH_CYSQCarTableViewCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZH_CYSQCarTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var chossenView: QZHUIView!
    @IBOutlet weak var choosenBtn: UIImageView!
    @IBOutlet weak var proName: QZHUILabelView!
    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var proView: QZHUIView!
    @IBOutlet weak var proNum: QZHUILabelView!
    @IBOutlet weak var price2: QZHUILabelView!
    @IBOutlet weak var price1: QZHUILabelView!
    @IBOutlet weak var priceIcon: QZHUILabelView!
    @IBOutlet weak var proSpec: QZHUILabelView!
    @IBOutlet weak var proEditBtn: UIImageView!
    
    @IBOutlet weak var proEditView: QZHUIView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var numText: UITextField!

    @IBOutlet weak var specBtn: QZHUIView!
    @IBOutlet weak var specText: QZHUILabelView!

    @IBOutlet weak var proBtn: QZHUIView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        

        choosenBtn.frame = CGRect(x:19*PX,y:72*PX,width:37*PX,height:37*PX)
        choosenBtn.image = UIImage(named:"CarSel")
        choosenBtn.layer.cornerRadius = 17.5*PX
        choosenBtn.layer.masksToBounds = true
        choosenBtn.restorationIdentifier = "unSel"
        chossenView.setupViews(x: 0, y: 0, width: 155*PX, height: 183*PX, bgColor: UIColor.clear)
        
        proImg.frame = CGRect(x:75*PX,y:10*PX,width:160*PX,height:160*PX)
        proImg.image = UIImage(named:"loadPic")
        
        
        proBtn.setupViews(x: 80*PX, y: 0, width: 560*PX, height: 180*PX, bgColor: UIColor.clear)
        // 设置产品信息
        proView.setupViews(x: 255*PX, y: 0, width: 495*PX, height: 180*PX, bgColor: UIColor.white)
        proName.setLabelView(0, 20*PX, 400*PX, 70*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "")
        proName.numberOfLines = 2
        proName.lineBreakMode = .byTruncatingTail 
        
        proEditBtn.frame = CGRect(x:433*PX,y:22*PX,width:29*PX,height:31*PX)
        proEditBtn.image = UIImage(named:"CarEdit")
        proEditBtn.addOnClickLister(target: self, action: #selector(self.editPro(_:)))
        
        proSpec.setLabelView(0, 91*PX, 400*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray9(), 24, "")
        
        priceIcon.setLabelView(0*PX,138*PX,20*PX,28*PX, NSTextAlignment.left, UIColor.white, myColor().redFf4300(), 20, "¥")
        
        price1.setLabelView(20*PX, 129*PX, price1.autoLabelWidth(price1.text!, font: 44, height: 40*PX), 40*PX, NSTextAlignment.left, UIColor.white, myColor().redFf4300(), 28, "")
        
        price2.setLabelView(30*PX+price1.width, 139*PX, price2.autoLabelWidth(price2.text!, font: 30, height: 28*PX), 28*PX, NSTextAlignment.left, UIColor.white, myColor().gray9(), 20, "")

        
        proNum.setLabelView(475*PX - proNum.autoLabelWidth(proNum.text!, font: 30, height: 28*PX), 138*PX,proNum.autoLabelWidth(proNum.text!, font: 30, height: 28*PX), 28*PX, NSTextAlignment.right, UIColor.clear, myColor().gray9(), 20, "")
        
        // 设置编辑产品 UI
        proEditView.setupViews(x: 255*PX, y: 0, width: 495*PX, height: 180*PX, bgColor: UIColor.white)
        
        okBtn.frame = CGRect(x:385*PX,y:0,width:110*PX,height:180*PX)
        okBtn.backgroundColor = myColor().blue007aff()
        okBtn.tintColor = UIColor.white
        okBtn.setTitle("完成", for: .normal)
        
        let redBtnView:QZHUIView = QZHUIView()
        redBtnView.setupViews(x:0*PX,y:20*PX,width:70*PX,height:70*PX, bgColor: UIColor.clear)
        proEditView.addSubview(redBtnView)
        redBtnView.layer.borderWidth = 1*PX
        redBtnView.layer.borderColor = myColor().gray9().cgColor
        let redBtn:UIImageView = UIImageView(frame:CGRect(x:20*PX,y:34*PX,width:30*PX,height:3*PX))
        redBtn.image = UIImage(named:"reductionIcon")
        redBtnView.addSubview(redBtn)
        redBtnView.layer.borderWidth = 1*PX
        redBtnView.layer.borderColor = myColor().gray9().cgColor
        redBtnView.addOnClickLister(target: self, action: #selector(self.redution))
        
        let addBtnView:QZHUIView = QZHUIView()
        addBtnView.setupViews(x:295*PX,y:20*PX,width:70*PX,height:70*PX, bgColor: UIColor.clear)
        proEditView.addSubview(addBtnView)
        addBtnView.layer.borderWidth = 1*PX
        addBtnView.layer.borderColor = myColor().gray9().cgColor
        let addbtn:UIImageView = UIImageView(frame:CGRect(x:22*PX,y:22*PX,width:27*PX,height:27*PX))
        addbtn.image = UIImage(named:"addICon")
        addBtnView.addSubview(addbtn)
        addBtnView.addOnClickLister(target: self, action: #selector(self.add))
        
        numText.frame = CGRect(x:75*PX,y:20*PX,width:215*PX,height:70*PX)
        numText.textColor = myColor().gray3()
        numText.layer.borderColor = myColor().gray9().cgColor
        numText.borderStyle=UITextBorderStyle.none
        numText.layer.borderWidth = 1*PX
        numText.textAlignment = .center
        numText.contentVerticalAlignment = .center
        numText.keyboardType = UIKeyboardType.numberPad
        numText.becomeFirstResponder()
        numText.resignFirstResponder()
        numText.delegate = self 
        
        specBtn.setupViews(x: 0, y: 100*PX, width: 365*PX, height: 70*PX, bgColor: UIColor.white)
        specBtn.layer.borderWidth = 1*PX
        specBtn.layer.borderColor = myColor().gray9().cgColor
        specText.setLabelView(20*PX, 0, 295*PX, 70*PX, NSTextAlignment.left, UIColor.white, myColor().gray9(), 24, "www")
        let specIcon:UIImageView = UIImageView(frame:CGRect(x:318*PX,y:22*PX,width:27*PX,height:17*PX))
        specIcon.image = UIImage(named:"closeIcon")
        specBtn.addSubview(specIcon)
        
        proEditView.isHidden = true
        
        let line1:QZHUILabelView = QZHUILabelView()
        line1.dividers(20*PX, y: 180*PX, width: 730*PX, height: 1*PX, color: myColor().grayF0())
        self.addSubview(line1)
    }    
    // 编辑
    func editPro(_ sender:UITapGestureRecognizer){
        proView.isHidden = true
        proEditView.isHidden = false
        
        numText.text = proNum.text?.components(separatedBy: "x")[1]
        specText.text = proSpec.text
        
        proBtn.isHidden = true
    }
 
    // 增加
    func add(){
        let num:Double! = Double.init(numText.text!)!
        numText.text = "\(num + 1.0)"
        proNum.text = "x\(num + 1.0)"
    }
    // 减
    func redution(){
        let num:Double! = Double.init(numText.text!)!
        if num > 1{
            numText.text = "\(num - 1.0)"
            proNum.text = "x\(num - 1.0)"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //限制只能输入数字，不能输入特殊字符
        let length = string.lengthOfBytes(using: String.Encoding.utf8)
        for loopIndex in 0..<length {
            let char = (string as NSString).character(at: loopIndex)
            if char < 48 { return false }
            if char > 57 { return false }
        }
        return true
    }
    
}
