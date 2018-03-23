//
//  QZHAddAdressViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/21.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit
import ZWPlaceHolder

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHAddAdressViewController: QZHBaseViewController{
    
    // 地址列表视图懒加载
    lazy var addressStatus = QZHAddressListViewModel()
    
    // 收获人地址
    var txtName:UITextField = UITextField()
    
    // 联系电话
    var txtPhone:UITextField = UITextField()
    
    // 所在地区
    var txtArea:UITextField = UITextField()
    var areaLabel:QZHUILabelView = QZHUILabelView()
    
    // 详细地址
    var txtAddress:UITextView = UITextView()
    var placeholderLabel:QZHUILabelView = QZHUILabelView()
    
    // 是否为默认地址
    var defaultBtn:UISwitch = UISwitch()
    
    var headerView:QZHUIView = QZHUIView()
    
    
    // 选择地区
    var areaView:QZHUIView = QZHUIView()
    var bgView:QZHUIView = QZHUIView()
    var addressPiker:AreaPicker=AreaPicker()
    
    override func loadData() {
        
    }
}

// MARK: - 设置页面 UI 样式
extension QZHAddAdressViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        // 注册原型 cell
        tabbelView?.register(UINib(nibName:"QZHAddressManageTableViewCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        tabbelView?.y = 128*PX
        tabbelView?.height = SCREEN_HEIGHT - 128*PX
        tabbelView?.separatorStyle = .none
        tabbelView?.backgroundColor = myColor().grayF0()
        
        setupNav()
        
        setupForm()
        
        setAreaCheckView()
    }
    
    // 设置导航条
    func setupNav(){
        self.title = "新增收货地址"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon2", target: self, action: #selector(self.close),color:UIColor.white)
    }
    
    // 设置表单
    func setupForm(){
        headerView.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT, bgColor: UIColor.clear)
       
        
        var top:CGFloat = 0
        // 收货人
        let nameView:QZHUIView = QZHUIView()
        top = self.setRows(y: top, name: "收货人", thisView: nameView)
        txtName.frame = CGRect(x:165*PX,y:20*PX,width:565*PX,height:40*PX)
        txtName.delegate = self
        txtName.font = UIFont.systemFont(ofSize: 28*PX)
        //字体颜色
        txtName.setValue(myColor().gray9(), forKeyPath: "_placeholderLabel.textColor")
        txtName.textColor = myColor().gray3()
        nameView.addSubview(txtName)
        txtName.placeholder = "请输入收货人姓名"
        
        // 联系电话
        var phoneView:QZHUIView = QZHUIView()
        top = self.setRows(y: top, name: "联系电话", thisView: phoneView)
        txtPhone.frame = CGRect(x:165*PX,y:20*PX,width:565*PX,height:40*PX)
        txtPhone.font = UIFont.systemFont(ofSize: 28*PX)
        txtPhone.setValue(myColor().gray9(), forKeyPath: "_placeholderLabel.textColor")
        txtPhone.textColor = myColor().gray3()
        txtPhone.restorationIdentifier = "phone"
        txtPhone.delegate = self
        phoneView.addSubview(txtPhone)
        txtPhone.placeholder = "请输入收货人电话"
        
        // 所在地区
        var areaView:QZHUIView = QZHUIView()
        top = self.setRows(y: top, name: "所在地区", thisView: areaView)
        txtArea.frame = CGRect(x:165*PX,y:20*PX,width:400*PX,height:40*PX)
        txtArea.font = UIFont.systemFont(ofSize: 28*PX)
        txtArea.textColor = myColor().gray3()
        areaView.addSubview(txtArea)
        txtArea.setValue(myColor().gray9(), forKeyPath: "_placeholderLabel.textColor")
        txtArea.isUserInteractionEnabled = false
        areaLabel.setLabelView(591*PX, 20*PX, 90*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray9(), 28, "请选择")
        areaView.addSubview(areaLabel)
        let areaImg :UIImageView = UIImageView(frame:CGRect(x:708*PX,y:28*PX,width:14*PX,height:24*PX))
        areaImg.image = UIImage(named:"rightOpen2")
        areaView.addSubview(areaImg)
        let selBtn:QZHUIView = QZHUIView()
        selBtn.setupViews(x: 600*PX, y: 0, width: 150*PX, height: 80*PX, bgColor: UIColor.clear)
        selBtn.addOnClickLister(target: self, action: #selector(self.openArea))
        areaView.addSubview(selBtn)
        
        // 详细地址
        var addressView:QZHUIView = QZHUIView()
        top = self.setRows(y: top, name: "详细地址", thisView: addressView)
        txtAddress.frame = CGRect(x:165*PX,y:10*PX,width:565*PX,height:80*PX)
        txtAddress.font = UIFont.systemFont(ofSize: 28*PX)
        txtAddress.textColor = myColor().gray3()
        txtAddress.zw_placeHolder = "请输入详细地址"
        //txtAddress.delegate = self
        txtAddress.zw_placeHolderColor = myColor().gray9()
        addressView.addSubview(txtAddress)
        
        // 设置为默认地址
        var defaultView:QZHUIView = QZHUIView()
        top = self.setRows(y: top, name: "设为默认地址", thisView: defaultView)
        defaultBtn.frame = CGRect(x:640*PX,y:10*PX,width:90*PX,height:50*PX)
        defaultView.addSubview(defaultBtn)
        defaultBtn.offImage = UIImage(named:"addressSwitch")
        defaultBtn.onTintColor = myColor().blue007aff()
        //defaultBtn.thumbTintColor = UIColor.white
        defaultBtn.transform = CGAffineTransform(scaleX: 0.81,y: 0.81)
        
        let saveView:QZHUILabelView = QZHUILabelView()
        saveView.addOnClickLister(target: self, action: #selector(self.saveActions))
        saveView.setLabelView(20*PX, 535*PX, 710*PX, 100*PX, NSTextAlignment.center, myColor().blue007aff(), UIColor.white, 36, "保存")
        saveView.layer.cornerRadius = 5*PX
        saveView.layer.masksToBounds = true
        headerView.addSubview(saveView)
        
        headerView.height = saveView.y + 300*PX
        tabbelView?.tableHeaderView = headerView
    }
    
    // 设置每行view
    func setRows(y:CGFloat,name:String,thisView:QZHUIView)->CGFloat{
        var top = y
        thisView.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: 81*PX, bgColor: UIColor.white)
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 80*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        thisView.addSubview(line)
        if name == "详细地址"{
            thisView.height = 161*PX
            line.y = 160*PX
        }
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(20*PX, 20*PX, 180*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 28, name)
        thisView.addSubview(title)
        
        headerView.addSubview(thisView)
        
        top = top + thisView.height
        return top
    }
    
    // 设置地区选择
    func setAreaCheckView(){
        bgView.blackBackground(y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        bgView.isHidden = true
        bgView.addOnClickLister(target: self, action: #selector(self.closeArea))
        self.view.addSubview(bgView)
        
        areaView.setupViews(x: 0, y: 800*PX, width: SCREEN_WIDTH, height: 534*PX, bgColor: UIColor.white)
        self.view.addSubview(areaView)
        areaView.isHidden = true
        
        let btnView:QZHUIView = QZHUIView()
        btnView.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 100*PX, bgColor: myColor().blue007aff())
        areaView.addSubview(btnView)
        
        // 取消按钮
        let canelBtn:QZHUILabelView = QZHUILabelView()
        canelBtn.setLabelView(0, 0, 190*PX, 100*PX, NSTextAlignment.center, UIColor.clear, UIColor.white, 32, "取消")
        canelBtn.addOnClickLister(target: self, action: #selector(self.closeArea))
        btnView.addSubview(canelBtn)
        
        // 确定按钮
        let okBtn:QZHUILabelView = QZHUILabelView()
        okBtn.setLabelView(SCREEN_WIDTH - 190*PX, 0, 190*PX, 100*PX, NSTextAlignment.center, UIColor.clear, UIColor.white, 32, "确定")
        okBtn.addOnClickLister(target: self, action: #selector(self.selArea))
        btnView.addSubview(okBtn)
        
        
        let areaInfo:QZHArea = QZHArea()
        areaInfo.getJSON()
        let json = areaInfo.addressJSON
        //创建地址选择器
        addressPiker.frame = CGRect(x:0,y:80*PX,width:SCREEN_WIDTH,height:454*PX)
        addressPiker.initLoadAddressOnly()
        areaView.addSubview(addressPiker)
    }
}

// MARK: - 绑定数据源
extension QZHAddAdressViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHAddressManageTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}


// MARK: - 设置监听方法
extension QZHAddAdressViewController{
    // 输入框结束编辑状态
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.restorationIdentifier == "phone"{
            if !PublicFunction().isTelNumber(textField.text! as NSString){
                UIAlertController.showAlert(message: "你输入的是非法的手机号码，请重新输入！！！", in: self)
                textField.text = ""
            }
        }
    }
    
    // 返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    // 保存
    func saveActions(){
        QZHAddressModel.person = self.txtName.text!
        QZHAddressModel.phone = self.txtPhone.text!
        QZHAddressModel.code = self.txtArea.restorationIdentifier!
        QZHAddressModel.address = self.txtAddress.text!
        if self.defaultBtn.isOn{
            QZHAddressModel.isDefault = 1
        }else{
            QZHAddressModel.isDefault = 0
        }
        
        self.addressStatus.addAddress { (isSuccess, result) in
            self.dismiss(animated: true, completion: nil)
             UIAlertController.showAlert(message: result, in: self)
        }
    }
    
    // 打开地区选择
    func openArea(){
        bgView.isHidden = false
        areaView.isHidden = false
    }
    
    // 确定选择地区
    func selArea(){
        closeArea()
        self.txtArea.restorationIdentifier = "\(addressPiker.getSelAddress()["code"]!)"
        self.txtArea.text = addressPiker.getSelAddress()["area"] as! String
        print(addressPiker.getSelAddress())
    }
    
    // 关闭地区选择
    func closeArea(){
        bgView.isHidden = true
        areaView.isHidden = true
    }
}
