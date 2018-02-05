//
//  QZHEditPWDViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/31.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHEditPWDViewController: QZHBaseViewController,UITextFieldDelegate{
    // 视图模型初始化
    lazy var pwdData = QZHPWDViewModel()
    
    // 新的密码
    var pwdLabel:UITextField = UITextField()
    var pwdtext = ""
    
    // 确认新的密码
    var pwd1Label:UITextField = UITextField()
    var pwd1Text = ""
    
    // 确认密码验证按钮
    var pwdBtn:QZHUIButton = QZHUIButton()
    var pwdView:QZHUIView = QZHUIView()
    
    // 下一步按钮
    var Btn:QZHUIButton = QZHUIButton()
    var Btn1:QZHUIButton = QZHUIButton()
    
    // 倒计时
    var leftTime:Int = 60
    var timer :Timer!
    
    override func loadData() {
        
    }
    
    // 提交修改
    func EditPWD(){
        QZHPWDModel.password = pwdLabel.text!
        pwdData.editPWD(completion: { (result, flag, isSuccess) in
            if flag{
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }else{
                UIAlertController.showAlert(message: result, in: self)
            }
        })
    }
}
// MARK: - 设置修改密码页面 UI
extension QZHEditPWDViewController{
    override func setupUI() {
        super.setupUI()
        // 去掉 tableview 分割线
        self.tabbelView?.separatorStyle = .none
        
        self.tabbelView?.y = 128*PX
        
        tabbelView?.backgroundColor = UIColor.white
        
        // 注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupNav()
        setupTextField()
        setupBtn()
    }
    
    // 设置导航栏
    func setupNav(){
        //设置导航条
        title = "修改密码"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        
        // 设置 logo 图像
        let logoImg:UIImageView = UIImageView(frame:CGRect(x:280*PX,y:19*PX,width:190*PX,height:190*PX))
        logoImg.image = UIImage(named:"userLogo")
        tabbelView?.addSubview(logoImg)
    }
    
    // 设置提交按钮
    func setupBtn(){
        Btn.setupButton(30*PX, 513*PX, 690*PX, 100*PX, myColor().gray9(), myColor().grayF0(), "完成", 36, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        Btn.frame = CGRect(x:30*PX,y:513*PX,width:690*PX,height:100*PX)
        Btn.layer.cornerRadius = 5*PX
        tabbelView?.addSubview(Btn)
        
        Btn1.setupButton(30*PX, 513*PX, 690*PX, 100*PX, UIColor.white, myColor().blue2088ff(), "完成", 36, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        Btn1.frame = CGRect(x:30*PX,y:513*PX,width:690*PX,height:100*PX)
        Btn1.addTarget(self, action: #selector(self.EditPWD), for: .touchUpInside)
        Btn1.isHidden = true
        Btn1.layer.cornerRadius = 5*PX
        tabbelView?.addSubview(Btn1)
    }
    
    // 设置输入框表单
    func setupTextField(){
        self.setupListView(y: 241, title: "输入新密码", placeholder: "请输入新密码", inputName: pwdLabel, inputWidth: 460)
        pwdLabel.restorationIdentifier = "pwd"
         pwdLabel.isSecureTextEntry = true
        
        let password1View = self.setupListView(y: 343, title: "确认新密码", placeholder: "请确认新密码", inputName: pwd1Label, inputWidth: 410)
        pwd1Label.restorationIdentifier = "pwd1"
        pwd1Label.isSecureTextEntry = true
        pwdBtn.frame = CGRect(x:651*PX,y:30*PX,width:40*PX,height:40*PX)
        pwdBtn.setImage(UIImage(named:"pwdIcon"), for: .normal)
        pwdBtn.addTarget(self, action: #selector(self.showPwdView), for: .touchUpInside)
        password1View.addSubview(pwdBtn)

        pwdView.setupViews(x: 391*PX, y: 20*PX, width: 243*PX, height: 60*PX, bgColor: UIColor.clear)
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(0*PX, 0*PX, 231*PX, 60*PX, NSTextAlignment.center, myColor().gray7F(), UIColor.white, 30, "密码输入错误")
        
        label.layer.cornerRadius = 5*PX
        label.clipsToBounds = true
        pwdView.addSubview(label)
        let img:UIImageView = UIImageView(frame:CGRect(x:231*PX,y:16*PX,width:12*PX,height:28*PX))
        img.image = UIImage(named:"pwdBG")
        
        pwdView.addSubview(img)
        password1View.addSubview(pwdView)
        pwdView.isHidden = true

    }
    // 设置单条信息输入
    func setupListView(y:CGFloat,title:String,placeholder:String,inputName:UITextField,inputWidth:CGFloat)->QZHUIView{
        let selfView:QZHUIView = QZHUIView()
        selfView.setupViews(x: 30*PX, y: y*PX, width: 690*PX, height: 102*PX, bgColor: UIColor.clear)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 100*PX, width: 690*PX, height: 2*PX, color: myColor().grayEB())
        selfView.addSubview(line)
        
        
        let titleLabel:QZHUILabelView = QZHUILabelView()
        titleLabel.setLabelView(0, 28*PX, 180*PX, 45*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 32, title)
        selfView.addSubview(titleLabel)
        
        inputName.placeholder = placeholder
        inputName.clearButtonMode = .always
        inputName.frame = CGRect(x:230*PX,y:28*PX,width:inputWidth*PX,height:45*PX)
        inputName.textColor = myColor().gray3()
        inputName.delegate = self
        selfView.addSubview(inputName)
        
        tabbelView?.addSubview(selfView)
        return selfView
    }
    
}

//MARK:- 表格数据源方法，具体的数据源方法实现，不需要 super
extension QZHEditPWDViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 750*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    /// 捕捉滚动条动作
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}

//MARK:- 设置 UITextFieldDelegate 代理方法
extension QZHEditPWDViewController{
    
    // 输入框询问是否可以编辑 true 可以编辑  false 不能编辑
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    // 该方法代表输入框已经可以开始编辑  进入编辑状态
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    // 输入框将要将要结束编辑
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    // 输入框结束编辑状态
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    } // 文本框是否可以清除内容
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        Btn.isHidden = false
        Btn1.isHidden = true
        return true
    }
    // 输入框按下键盘 return 收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    // 该方法当文本框内容出现变化时 及时获取文本最新内容
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = currentText.replacingCharacters(in:range.toRange(string: currentText), with: string)
        if textField.restorationIdentifier == "pwd"{
            pwdtext = newText
        }
        if textField.restorationIdentifier == "pwd1"{
            pwd1Text = newText
            if pwdtext == pwd1Text && pwdtext != ""{
                pwdBtn.isHidden = true
            }else{
                pwdBtn.isHidden = false
            }
        }
        
        if pwdtext != "" && pwd1Text != "" {
            Btn.isHidden = true
            Btn1.isHidden = false
        }else{
            Btn.isHidden = false
            Btn1.isHidden = true
        }
        
        return true
    }
}

// MARK: - 监听方法
extension QZHEditPWDViewController{
    //MARK: - 监听方法
    @objc func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 显示确认密码提示信息
    func showPwdView(){
        if pwdView.restorationIdentifier == "show"{
            pwdView.restorationIdentifier = ""
            pwdView.isHidden = true
        }else{
            pwdView.restorationIdentifier = "show"
            pwdView.isHidden = false
        }
    }
}
