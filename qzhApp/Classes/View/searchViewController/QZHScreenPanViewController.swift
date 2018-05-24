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

class QZHScreenPanViewController: UIViewController {
    // 产品列表视图懒加载
    lazy var ProList = QZHSearchProListViewModel()
    
    var tabelView:UITableView = UITableView()
    
    var blakBg:QZHUIView = QZHUIView()
    
    var screenPan:QZHUIView = QZHUIView()
    
    var min:UITextField = UITextField()
    var max:UITextField = UITextField()
    
    var flagArray:[Bool] =  []
    var spec:[String] = []
    var specId:[String] = []
    
    override func viewDidLoad() {
        setStatusBarBackgroundColor(color: .clear)
        self.view.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.clear
        tabelView.dataSource = self
        tabelView.delegate = self
        self.modalPresentationStyle = .overCurrentContext
        setupScreenPan()
        price()
        
        getBrandSpec()
    }
    // 获取品牌规格
    func getBrandSpec(){
        if QZHBrandModel.categoryId == 0{
            QZHBrandModel.categoryId = 14
        }
        self.ProList.loadSpec { (isSuccess) in
            for i in 0..<self.ProList.specNameList.count{
                self.flagArray.append(false)
                
            }
            if QZHSreenSelMode.specIdArray.count == 0{
                for i in 0..<self.ProList.specNameList.count{
                    QZHSreenSelMode.specIdArray.append("")
                    QZHSreenSelMode.specNameArray.append("")
                    
                }
            }
            self.tabelView.reloadData()
        }
        
    }

}

// MARK: - 设置页面 UI 样式
extension QZHScreenPanViewController{
    // 筛选面板
    func setupScreenPan(){
        blakBg.blackBackground(y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.view.addSubview(blakBg)
        blakBg.addOnClickLister(target: self, action: #selector(self.close))
        blakBg.isHidden = false
        
        screenPan.setupViews(x: 150*PX, y: 0, width: 600*PX, height: SCREEN_HEIGHT, bgColor: UIColor.white)
        self.view.addSubview(screenPan)
        
        let reSetBtn:QZHUILabelView = QZHUILabelView()
        reSetBtn.setLabelView(-1*PX, SCREEN_HEIGHT-100*PX, 301*PX, 100*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 32, "重置")
        reSetBtn.addOnClickLister(target: self, action: #selector(self.reSet))
        screenPan.addSubview(reSetBtn)
        reSetBtn.layer.borderColor = myColor().grayEB().cgColor
        reSetBtn.layer.borderWidth = 1*PX
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(SCREEN_HEIGHT-100*PX, y: 0, width: 300*PX, height: 1*PX, color: myColor().grayEB())
        screenPan.addSubview(line)
        
        let commitBtn:QZHUILabelView = QZHUILabelView()
        commitBtn.setLabelView(300*PX, SCREEN_HEIGHT-100*PX, 300*PX, 100*PX, NSTextAlignment.center,myColor().blue007aff() , UIColor.white, 32, "完成")
        commitBtn.addOnClickLister(target: self, action: #selector(self.commit))
        screenPan.addSubview(commitBtn)
        
        tabelView.frame = CGRect(x:20*PX,y:40*PX,width:560*PX,height:SCREEN_HEIGHT-140*PX)
        tabelView.register(UINib(nibName:"CustomQZHCell",bundle:nil), forCellReuseIdentifier: cellId)
        tabelView.separatorStyle = .none
        
        
        screenPan.addSubview(tabelView)
        
    }
    
    // 价格
    func price(){
        let foot:QZHUIView = QZHUIView()
        foot.setupViews(x: 0, y: 0, width: 560*PX, height: 171*PX, bgColor: UIColor.white)
        tabelView.tableFooterView = foot
        
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
        min.keyboardType = .numberPad
        if QZHSreenSelMode.min != ""{
            min.text = QZHSreenSelMode.min
        }
        
        max.frame = CGRect(x:300*PX,y:72*PX,width:260*PX,height:60*PX)
        foot.addSubview(max)
        max.placeholder = "最高价"
        max.backgroundColor = myColor().GrayF1F2F6()
        max.layer.cornerRadius = 8*PX
        max.layer.masksToBounds = true
        max.textAlignment = .center
        max.textColor = myColor().gray3()
        max.keyboardType = .numberPad
        if QZHSreenSelMode.max != ""{
            max.text = QZHSreenSelMode.max
        }
        
        let line:QZHUILabelView = QZHUILabelView()
        line.setLabelView(272*PX, 72*PX, 15*PX, 60*PX, NSTextAlignment.center, UIColor.clear, myColor().gray9(), 24, "-")
        foot.addSubview(line)
    }
}

// MARK: - 绑定数据源
extension QZHScreenPanViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = self.ProList.specNameList.count
        return self.ProList.specNameList.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.ProList.specOptionList[indexPath.row].count < 4{
            return 172*PX
        }else if self.ProList.specOptionList[indexPath.row].count > 6 && flagArray[indexPath.row] == true{
            let count = self.ProList.specOptionList[indexPath.row].count/3 + 1
            return 73*PX + CGFloat(count)*80*PX
        }else{
            return 252*PX
        }

        
 

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomQZHCell
        
        // 取消 cell 的选中事件
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.title.text = self.ProList.specNameList[indexPath.row].status.specName
        
        if self.flagArray[indexPath.row] == false{
            if self.ProList.specNameList[indexPath.row].status.specName == "品牌"{
                var dic = ["x":0,"y":20*PX]
                for i in 0..<self.ProList.specOptionList[indexPath.row].count{
                    if i%3 == 0 && i != 0{
                        dic["x"] = 0
                        dic["y"] = cell.listHeight
                    }
                    if i > 5{
                        break
                    }
                    for id in QZHSreenSelMode.brandId.components(separatedBy: ","){
                        if Int.init(id) == self.ProList.specOptionList[indexPath.row][i].status.id{
                            dic = cell.setupList(x: dic["x"]!, y: dic["y"]!, title: self.ProList.specOptionList[indexPath.row][i].status.optionName, id: self.ProList.specOptionList[indexPath.row][i].status.id,sel:true)
                        }else{
                            dic = cell.setupList(x: dic["x"]!, y: dic["y"]!, title: self.ProList.specOptionList[indexPath.row][i].status.optionName, id: self.ProList.specOptionList[indexPath.row][i].status.id,sel:false)
                        }
                    }
                    
                }
                cell.selectText.text = QZHSreenSelMode.brandName
                cell.selectText.restorationIdentifier = QZHSreenSelMode.brandId
            }else{
                var dic = ["x":0,"y":20*PX]
                for i in 0..<self.ProList.specOptionList[indexPath.row].count{
                    
                    if i%3 == 0 && i != 0{
                        dic["x"] = 0
                        dic["y"] = cell.listHeight
                    }
                    if i > 5{
                        break
                    }
                    for id in QZHSreenSelMode.specIdArray[indexPath.row].components(separatedBy: ","){
                        if Int.init(id) == self.ProList.specOptionList[indexPath.row][i].status.id{
                            dic = cell.setupList(x: dic["x"]!, y: dic["y"]!, title: self.ProList.specOptionList[indexPath.row][i].status.specOptionName, id: self.ProList.specOptionList[indexPath.row][i].status.id,sel:true)
                            
                        }else{
                            dic = cell.setupList(x: dic["x"]!, y: dic["y"]!, title: self.ProList.specOptionList[indexPath.row][i].status.specOptionName, id: self.ProList.specOptionList[indexPath.row][i].status.id,sel:false)
                        }
                    }
                }
                cell.selectText.text = QZHSreenSelMode.specNameArray[indexPath.row]
                cell.selectText.restorationIdentifier = QZHSreenSelMode.specIdArray[indexPath.row]
            }
        }else{
            if self.ProList.specNameList[indexPath.row].status.specName == "品牌"{
                var dic = ["x":0,"y":20*PX]
                for i in 0..<self.ProList.specOptionList[indexPath.row].count{
                    if i%3 == 0 && i != 0{
                        dic["x"] = 0
                        dic["y"] = cell.listHeight
                    }
                    for id in QZHSreenSelMode.brandId.components(separatedBy: ","){
                        
                        if Int.init(id) == self.ProList.specOptionList[indexPath.row][i].status.id{
                            dic = cell.setupList(x: dic["x"]!, y: dic["y"]!, title: self.ProList.specOptionList[indexPath.row][i].status.optionName, id: self.ProList.specOptionList[indexPath.row][i].status.id,sel:true)
                        }else{
                            dic = cell.setupList(x: dic["x"]!, y: dic["y"]!, title: self.ProList.specOptionList[indexPath.row][i].status.optionName, id: self.ProList.specOptionList[indexPath.row][i].status.id,sel:false)
                        }
                    }
                    
                }
                cell.selectText.text = QZHSreenSelMode.brandName
                cell.selectText.restorationIdentifier = QZHSreenSelMode.brandId
            }else{
                var dic = ["x":0,"y":20*PX]
                for i in 0..<self.ProList.specOptionList[indexPath.row].count{
                    
                    if i%3 == 0 && i != 0{
                        dic["x"] = 0
                        dic["y"] = cell.listHeight
                    }
                    
                    for id in QZHSreenSelMode.specIdArray[indexPath.row].components(separatedBy: ","){
                        if Int.init(id) == self.ProList.specOptionList[indexPath.row][i].status.id{
                            dic = cell.setupList(x: dic["x"]!, y: dic["y"]!, title: self.ProList.specOptionList[indexPath.row][i].status.specOptionName, id: self.ProList.specOptionList[indexPath.row][i].status.id,sel:true)
                        }else{
                            dic = cell.setupList(x: dic["x"]!, y: dic["y"]!, title: self.ProList.specOptionList[indexPath.row][i].status.specOptionName, id: self.ProList.specOptionList[indexPath.row][i].status.id,sel:false)
                        }
                    }
                }
                cell.selectText.text = QZHSreenSelMode.specNameArray[indexPath.row]
                cell.selectText.restorationIdentifier = QZHSreenSelMode.specIdArray[indexPath.row]
            }
        }
        
        cell.open.addOnClickLister(target: self, action: #selector(self.open(_:)))
        
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
    
    // 展开
    func open(_ sender:UITapGestureRecognizer){
        getParam()
        let cell = sender.view?.superview as! CustomQZHCell
        let indexPath = tabelView.indexPath(for: cell)
        if flagArray[(indexPath?.row)!] == true{
            flagArray[(indexPath?.row)!] = false
            for i in 0..<cell.ListArray.subviews.count{
                if i > 5{
                    cell.ListArray.subviews[i].isHidden = true
                }
            }
        }else{
            flagArray[(indexPath?.row)!] = true
            for i in 0..<cell.ListArray.subviews.count{
                if i > 5{
                    cell.ListArray.subviews[i].isHidden = false
                }
            }
        }
        
        tabelView.reloadData()
    }
    
    // 重置
    func reSet(){
        QZHSreenSelMode.brandId = ""
        QZHSreenSelMode.brandName = ""
        QZHSreenSelMode.specNameArray = []
        QZHSreenSelMode.specIdArray = []
        QZHSreenSelMode.max = ""
        QZHSreenSelMode.min = ""
        
        QZHCYSQSearchProListParamModel.specOptionName = ""
        QZHCYSQSearchProListParamModel.brand = ""
        QZHCYSQSearchProListParamModel.price = ""
        for i in 0..<flagArray.count{
            flagArray[i] = false
        }
        getBrandSpec()
    }
    
    // 筛选并赋值
    func getParam(){
        let cells:[CustomQZHCell] = tabelView.visibleCells  as! [CustomQZHCell]
        QZHSreenSelMode.specNameArray = []
        QZHSreenSelMode.specIdArray = []
        QZHCYSQSearchProListParamModel.specOptionName = ""
        for cell in cells{
            if cell.title.text == "品牌"{
                QZHCYSQSearchProListParamModel.brand = cell.selectText.text!
                QZHSreenSelMode.brandId = cell.selectText.restorationIdentifier!
                QZHSreenSelMode.brandName = cell.selectText.text!
            }else{
                if cell.selectText.text != ""{
                    if QZHCYSQSearchProListParamModel.specOptionName == ""{
                        QZHCYSQSearchProListParamModel.specOptionName = cell.selectText.text!
                    }else{
                        QZHCYSQSearchProListParamModel.specOptionName = "\(QZHCYSQSearchProListParamModel.specOptionName),\(cell.selectText.text!)"
                    }
                }
               
            }
            QZHSreenSelMode.specNameArray.append(cell.selectText.text!)
            QZHSreenSelMode.specIdArray.append(cell.selectText.restorationIdentifier!)
        }
        if max.text! != ""{
            if min.text! != ""{
                QZHCYSQSearchProListParamModel.price = "\(min.text!)-\(max.text!)"
            }else{
                QZHCYSQSearchProListParamModel.price = "0-\(max.text!)"
            }
        }else{
            if min.text! != ""{
                QZHCYSQSearchProListParamModel.price = "\(min.text!)- "
            }else{
                QZHCYSQSearchProListParamModel.price = ""
            }
        }
        QZHSreenSelMode.max = max.text!
        QZHSreenSelMode.min = min.text!
    }

    
    // 确定
    func commit(){
        getParam()
        //QZHCYSQSearchProListParamModel.isScreen = true
        //let nav = QZHSearchListViewController()
        //self.present(nav, animated: true, completion: nil)
        dismiss(animated: true) {
           //self.present(nav, animated: true, completion: nil)
        }
        
        /*self.presentingViewController?.viewWillAppear(true)
        //dismiss(animated: true, completion: nil)
        let this = QZHSearchListViewController()
        this.getFunc1()
        self.dismiss(animated: true) { 
           this.tabbelView?.reloadData()
        }*/
    }
}
