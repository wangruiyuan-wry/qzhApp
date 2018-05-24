//
//  QZHVisitorView.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/9.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHVisitorView: QZHBaseViewController {
    
    // 网络错误
    
    override func loadData() {
        
    }

}
extension QZHVisitorView{
    override func setupUI() {
        super.setupUI()
        
        tabbelView?.isHidden = true

        
        self.view.backgroundColor = UIColor.white
        
        let img:UIImageView = UIImageView(frame:CGRect(x:325*PX,y:282*PX,width:100*PX,height:100*PX))
        img.image = UIImage(named:"NetWrong")
        self.view.addSubview(img)
        
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(0, 422*PX, SCREEN_WIDTH, 50*PX, NSTextAlignment.center, UIColor.clear, myColor().gray3(), 36, "网络连接超时")
        self.view.addSubview(label)
        
        let btn:QZHUILabelView = QZHUILabelView()
        btn.setLabelView(175*PX, 607*PX, 400*PX, 80*PX, NSTextAlignment.center, myColor().redDe2222(), UIColor.white, 28, "返回重试")
        btn.layer.cornerRadius = 5*PX
        btn.layer.masksToBounds = true
        btn.addOnClickLister(target: self, action: #selector(self.refresh))
        self.view.addSubview(btn)
        
        self.navigationBar.isHidden = true
        
    }
    
    func refresh(){
        dismiss(animated: true, completion: nil)
    }
}
