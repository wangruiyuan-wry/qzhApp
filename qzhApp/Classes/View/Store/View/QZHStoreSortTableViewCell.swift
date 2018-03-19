//
//  QZHStoreSortTableViewCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/9.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHStoreSortTableViewCell: UITableViewCell {
    // 展开图标
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var iconOpen: UIImageView!
    
    // 一级分类名称
    @IBOutlet weak var firstName: QZHUILabelView!
    
    // 查看全部
    @IBOutlet weak var checkAll: QZHUILabelView!
    
    // 二级分类容器
    var scdView: QZHUIView! = QZHUIView()
    
    @IBOutlet weak var view1: QZHUIView!
    @IBOutlet weak var view2: QZHUIView!
    
    var line:QZHUILabelView = QZHUILabelView()
    var line2:QZHUILabelView = QZHUILabelView()
    
    // 更改后 cell 的高度
    var cellHeight:CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()

        view1.setupViews(x: 0, y: 0, width: 350*PX, height: 80*PX, bgColor: UIColor.white)
        
        // 一级分类图标
        icon.frame = CGRect(x:24*PX,y:32*PX,width:27*PX,height:17*PX)
        icon.image = UIImage(named:"closeIcon")
        iconOpen.frame = CGRect(x:24*PX,y:32*PX,width:27*PX,height:17*PX)
        iconOpen.image = UIImage(named:"openIcon")
        iconOpen.isHidden = true
        
        // 一级分类名称
        firstName.setLabelView(65*PX, 20*PX, 284*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, "")
        firstName.tag = 11
        
        view1.addSubview(icon)
        view1.addSubview(firstName)
        view1.restorationIdentifier = "close"
        
        // 查看全部
        view2.setupViews(x: 440*PX, y: 0, width: 310*PX, height: 80*PX, bgColor: UIColor.white)
        view2.addSubview(checkAll)
        view2.tag = 12
        checkAll.setLabelView(0, 24*PX, 290*PX, 30*PX, NSTextAlignment.right, UIColor.white, myColor().Gray6(), 22, "查看全部")
        
        self.addSubview(line)
        line.setLabelView(20*PX, 70*PX, 730*PX, 1*PX, NSTextAlignment.center, myColor().grayEB(), UIColor.clear, 2, "")
        self.addSubview(line2)
        line2.setLabelView(20*PX, 70*PX, 730*PX, 1*PX, NSTextAlignment.center, myColor().grayEB(), UIColor.clear, 2, "")
        line2.isHidden = true
        
        
        
        // 二级分类
        //scdView.isHidden = true
    }
    
    // 二级分类循环
    func setupSCDSort(_ scd:[[String:AnyObject]]){
        if QZHStoreSortModel.level2Array.count == 0{
            scdView.setupViews(x: 0, y: 80*PX, width: SCREEN_WIDTH, height: 0, bgColor: UIColor.white)
        }else{
            var top = 6*PX
            for i in 0..<scd.count{
                let labelView:QZHUIView = QZHUIView()
                if i%2 == 0{
                    top =  self.setupScdBtn(x: 6*PX, y: top, view: labelView, text: scd[i]["categoryName"] as! String, id: scd[i]["id"] as! Int)
                }else{
                    top = self.setupScdBtn(x: 378*PX, y: top - 86*PX, view: labelView, text: scd[i]["categoryName"] as! String, id: scd[i]["id"] as! Int)
                }
                scdView.addSubview(labelView)
                scdView.setupViews(x: 0, y: 80*PX, width: SCREEN_WIDTH, height: top, bgColor: UIColor.white)
            }
        }
        cellHeight = scdView.y + scdView.height
        line2.y = scdView.y + scdView.height
        self.addSubview(scdView)
    }
    
    // 设置二级分类按钮
    private func setupScdBtn(x:CGFloat,y:CGFloat,view:QZHUIView,text:String,id:Int)->CGFloat{
        var top = y
        
        view.setupViews(x: x, y: top, width: 366*PX, height: 80*PX, bgColor: myColor().grayF0())
        view.tag = 111
        
        let labbelText:QZHUILabelView = QZHUILabelView()
        labbelText.setLabelView(14*PX, 25*PX, 338*PX, 30*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 22, text)
        labbelText.tag = 11
        view.addSubview(labbelText)
        view.restorationIdentifier = "\(id)"
    
        top = top + 86*PX
        return top
    }
    
}
