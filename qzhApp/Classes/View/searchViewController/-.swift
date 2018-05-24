//
//  QZHScreenPanViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/20.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHScreenPanViewController: QZHBaseViewController {
    // 产品列表视图懒加载
    lazy var ProList = QZHSearchProListViewModel()
    
    var tabelView:UITableView = UITableView()
    
    var blakBg:QZHUIView = QZHUIView()
    
    var screenPan:QZHUIView = QZHUIView()
    
    var min:UITextField = UITextField()
    var max:UITextField = UITextField()
    
    override func loadData() {
        getBrandSpec()
    }
    // 获取品牌规格
    func getBrandSpec(){
        if QZHBrandModel.categoryId == 0{
            QZHBrandModel.categoryId = 14
        }
        self.ProList.loadSpec { (isSuccess) in
            
        }
        
    }

}

// MARK: - 设置页面 UI 样式
extension QZHScreenPanViewController{
    override func setupUI() {
        super.setupUI()
        self.navigationBar.isHidden = true
        
        self.view.backgroundColor = UIColor.clear
        
        //tabbelView?.separatorStyle = .none
        // 注册原型 cell
        //tabbelView?.register(UINib(nibName:"CustomQZHCell",bundle:nil), forCellReuseIdentifier: cellId)
        //self.view.backgroundColor = UIColor.white
       // tabbelView?.y = 40*PX
        //tabbelView?.x = 170*PX
        //tabbelView?.backgroundColor = UIColor.gray
        setupScreenPan()
        price()
        
    }
    
    // 筛选面板
    func setupScreenPan(){
        blakBg.blackBackground(y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.view.addSubview(blakBg)
        blakBg.addOnClickLister(target: self, action: #selector(self.close))
        blakBg.isHidden = false
        
        screenPan.setupViews(x: 150*PX, y: 0, width: 600*PX, height: SCREEN_HEIGHT, bgColor: UIColor.white)
        self.view.addSubview(screenPan)
        
        let reSetBtn:QZHUILabelView = QZHUILabelView()
        reSetBtn.setLabelView(0*PX, SCREEN_HEIGHT-100*PX, 300*PX, 100*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 32, "重置")
        reSetBtn.addOnClickLister(target: self, action: #selector(self.reSet))
        screenPan.addSubview(reSetBtn)
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(SCREEN_HEIGHT-100*PX, y: 0, width: 300*PX, height: 1*PX, color: myColor().grayEB())
        screenPan.addSubview(line)
        
        let commitBtn:QZHUILabelView = QZHUILabelView()
        commitBtn.setLabelView(300*PX, SCREEN_HEIGHT-100*PX, 300*PX, 100*PX, NSTextAlignment.center,myColor().blue007aff() , UIColor.white, 32, "完成")
        commitBtn.addOnClickLister(target: self, action: #selector(self.commit))
        screenPan.addSubview(commitBtn)
        
        tabelView.frame = CGRect(x:,y:,width:height)
    }
    
    // 价格
    func price(){
        let foot:QZHUIView = QZHUIView()
        foot.setupViews(x: 0, y: 0, width: 560*PX, height: 171*PX, bgColor: UIColor.red)
        tabbelView?.tableFooterView = foot
        
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(0, 20*PX, 560*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().Gray6(), 24, "价格区间（元）")
        foot.addSubview(title)
        
        min.frame = CGRect(x:0,y:72*PX,width:260*PX,height:60*PX)
        foot.addSubview(min)
        min.placeholder = "最低价"
        min.backgroundColor = myColor().GrayF1F2F6()
        min.layer.cornerRadius = 8*PX
        min.layer.masksToBounds = true
        min.textAlignment = .center
        min.textColor = myColor().gray3()
        
        let line:QZHUILabelView = QZHUILabelView()
        line.setLabelView(272*PX, 72*PX, 15*PX, 60*PX, NSTextAlignment.center, UIColor.clear, myColor().gray9(), 24, "-")
        foot.addSubview(line)
    }
}

// MARK: - 绑定数据源
extension QZHScreenPanViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = self.ProList.proListStatus.count
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 501*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomQZHCell
        
        return cell
    }
    
    /// 捕捉滚动条动作
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}

// MARK: - 设置监听方法
extension QZHScreenPanViewController{
    // 关闭
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 重置
    func reSet(){
        
    }
    
    // 确定
    func commit(){
        
    }
}
