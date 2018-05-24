//
//  QZHAddComentViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/27.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHAddComentViewController: QZHBaseViewController {
    // 评价详情视图列表懒加载
    lazy var Status = QZHEvaluationListViewModel()
    
    // 暂无评论
    var noList:QZHUIView = QZHUIView()
    
    // 操作结果显示
    var timer:Timer!
    var resultView:QZHUIView = QZHUIView()
    
    var body:QZHUIView = QZHUIView()
    var proImg:UIImageView = UIImageView()
    var proName:QZHUILabelView = QZHUILabelView()
    var contentView:UITextView = UITextView()
    
    override func loadData() {
        self.Status.loadInfo { (isSuccess) in
            if isSuccess{
                self.noList.isHidden = true
                self.body.isHidden = false
                
                let list = self.Status.infoStatus[0].status
                if list.goodsPic == ""{
                    self.proImg.image = UIImage(named:"noPic")
                }else{
                    if let url = URL(string: list.goodsPic) {
                        self.proImg.downloadedFrom(url: url)
                    }else{
                        self.proImg.image = UIImage(named:"noPic")
                    }
                }
                self.proName.text = list.goodsName
                
            }else{
                self.noList.isHidden = false
                self.body.isHidden = true
            }
        }
    }
    
}

// MARK: - 设置页面UI样式
extension QZHAddComentViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        tabbelView?.isHidden = true
        
        self.view.backgroundColor = myColor().grayF0()
        self.noList.isHidden = false
        setupNav()
        
        setupBody()
    }
    
    // 设置头部导航
    func setupNav(){
        self.title  = "发表追评"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        
        noList.setupNoList(y: 129*PX, str: "数据出错")
        self.view.addSubview(noList)
    }
    
    // 设置内容区
    func setupBody(){
        body.setupViews(x: 0, y: 129*PX, width: SCREEN_WIDTH, height: 401*PX, bgColor: UIColor.white)
        self.view.addSubview(body)
        
        proImg.frame = CGRect(x:20*PX,y:20*PX,width:120*PX,height:120*PX)
        body.addSubview(proImg)
        
        proName.setLabelView(160*PX, 59*PX, 564*PX, 43*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 30, "")
        body.addSubview(proName)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 160*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayEB())
        body.addSubview(line)
        
        contentView.frame = CGRect(x:20*PX,y:181*PX,width:710*PX,height:200*PX)
        contentView.font = UIFont.systemFont(ofSize: 28*PX)
        contentView.textColor = myColor().gray3()
        contentView.text = ""
        contentView.zw_placeHolder = "已经使用一段时间，有更多的使用心得？"
        contentView.zw_placeHolderColor = myColor().gray9()
        body.addSubview(contentView)
        
        let btn:QZHUILabelView = QZHUILabelView()
        self.view.addSubview(btn)
        btn.setLabelView(20*PX, 570*PX, 710*PX, 104*PX, NSTextAlignment.center, myColor().blue007aff(), UIColor.white, 36, "提交")
        btn.layer.cornerRadius = 5*PX
        btn.layer.masksToBounds = true
        btn.addOnClickLister(target: self, action: #selector(self.save))
    }

}

// MARK: - 绑定数据源
extension QZHAddComentViewController{}

// MARK: - 设置监听方法
extension QZHAddComentViewController{
    // 后退
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 提交
    func save(){
        QZHCommentModel.goodsDescripe = self.contentView.text!
        self.Status.AddComment{ (isSuccess) in
            if isSuccess{
                self.resultView.opertionSuccess("追加成功", isSuccess)
                self.view.addSubview(self.resultView)
                self.resultView.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
                self.dismiss(animated: true, completion: nil)
            }else{
                self.resultView.opertionSuccess("追加失败", isSuccess)
                self.view.addSubview(self.resultView)
                self.resultView.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 3, target:self,selector:#selector(self.resultViewXS),userInfo:nil,repeats:true)
            }
        }

    }
    
    // 操作结果图层消失
    func resultViewXS(){
        resultView.isHidden = true
        resultView.subviews.map{ $0.removeFromSuperview()}
        
    }

}
