//
//  QZHSearchCYSQ.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/23.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHSearchCYSQ: QZHBaseViewController {
    override func loadData() {
        
    }
}

// MARK: - 设置UI界面
extension QZHSearchCYSQ{
    override func setupUI() {
        super.setupUI()
        //去掉单元格的分割线
        self.tabbelView?.separatorStyle = .none
        
        //tabbelView?.isHidden = true
        navigationBar.isHidden = true
        let line:QZHUILabelView = QZHUILabelView()
        
        line.divider(0, y: 0, width: Int(SCREEN_WIDTH), height: 1, color: myColor().grayEB())
        view.addSubview(line)
        
        setupTitle()
        setupLabelItem()
    }
    
    // title标签
    func setupTitle(){
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(20*PX, 19*PX, 150*PX, 37*PX, NSTextAlignment.left, UIColor.clear,myColor().gray3(), 26, "历史搜索")
        tabbelView?.addSubview(label)
        
        let icon:UIImageView = UIImageView(frame:CGRect(x:683*PX,y:26*PX,width:30*PX,height:30*PX))
        icon.image = UIImage(named:"trashIcon")
        tabbelView?.addSubview(icon)
    }
    
    // 标签
    func setupLabelItem(){
        let labelItem:QZHUILabelView = QZHUILabelView()
        labelItem.layer.cornerRadius = 8*PX
        labelItem.clipsToBounds = true
        let widthLabel = labelItem.autoLabelWidth("珠光打印纸", font: 25, height: 60*PX)
        labelItem.setLabelView(20*PX, 76*PX, widthLabel+62*PX, 60*PX, NSTextAlignment.center, myColor().GrayF1F2F6(), myColor().gray4(), 24, "珠光打印纸")
        tabbelView?.addSubview(labelItem)
    }}
