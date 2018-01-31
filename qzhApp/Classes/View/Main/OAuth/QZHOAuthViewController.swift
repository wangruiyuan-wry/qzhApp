//
//  QZHAOuthViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

// 加载千纸鹤登录控制器
class QZHOAuthViewController: QZHBaseViewController,UITextFieldDelegate {
    
    var nameText = ""
    var pwdText = ""
    
    // 登录视图模型懒加载
    lazy var loginData = LoginViewModels()
    
    // 头像
    var UserLogo:UIImageView = UIImageView()
    
    // 账号
    var userName:UITextField! = UITextField()
    
    // 密码框
    var passWord:UITextField! = UITextField()
    
    // 明文显示密码图片
    var pwdImg:UIImageView = UIImageView()
    
    // 验证码
    var authCode:UITextField! = UITextField()
    
    //  验证码图片
    var authImg:UIImageView = UIImageView()
    
    // 登录按钮
    var loginBtn:QZHUIButton = QZHUIButton()
    var loginBtn1:QZHUIButton = QZHUIButton()
    
    override func loadData() {
       getAuthCode()
    }
    
    // 获取验证码图片
    func getAuthCode(){
        loginData.loadAuthCode { (image, isSuccess) in
            self.authImg.image = image
        }
    }
    
    // 提交登录
    func logins(){
        LoginModel.userName = userName.text!
        LoginModel.passWord = passWord.text!
        LoginModel.authCode = authCode.text!
        
        loginData.Login { (text, loginSuccess, isSuccess) in
            if loginSuccess{
                UIAlertController.showAlert(message: text)
                self.dismiss(animated: true, completion: nil)
            }else{
                UIAlertController.showAlert(message: text, in: self)
            }
        }
    }
}

// MARK: - 登录页面 UI 设置
extension QZHOAuthViewController{
    override func setupUI() {
        super.setupUI()
        
        // 去掉 tableview 分割线
        self.tabbelView?.separatorStyle = .none
        
        self.tabbelView?.y = 128*PX
        
        tabbelView?.backgroundColor = UIColor.white
        
        // 注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupNav()
        setupUserLogo()
        setTextFeild()
    }
    
    // 设置导航栏
    func setupNav(){
        //设置导航条
        title = "登录"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
    }
    
    // 设置头像
    func setupUserLogo(){
        UserLogo.frame = CGRect(x:280*PX,y:21*PX,width:190*PX,height:190*PX)
        UserLogo.image = UIImage(named:"userLogo")
        tabbelView?.addSubview(UserLogo)
    }
    
    // 设置账号/密码/验证码框
    func setTextFeild(){
    
      let _userView = setupInputArray(y: 241*PX, title: "账号")
        userName.frame = CGRect(x:134*PX,y:28*PX,width:513*PX,height:45*PX)
        userName.placeholder = "请输入账号"
        userName.textColor = myColor().gray3()
        userName.tag = 1
        userName.restorationIdentifier = "name"
        userName.clearButtonMode = UITextFieldViewMode.always
        userName.keyboardType = UIKeyboardType.numberPad
        userName.delegate = self
        _userView.addSubview(userName)
        
      let _passWord = setupInputArray(y: 343*PX, title: "密码")
        passWord.frame = CGRect(x:134*PX,y:28*PX,width:473*PX,height:45*PX)
        passWord.placeholder = "请输入密码"
        passWord.isSecureTextEntry = true
        passWord.textColor = myColor().gray3()
        passWord.tag = 1
        passWord.restorationIdentifier = "pwd"
        passWord.delegate = self
        passWord.clearButtonMode = UITextFieldViewMode.always
       _passWord.addSubview(passWord)
        pwdImg.frame = CGRect(x:612*PX,y:41*PX,width:45*PX,height:25*PX)
        pwdImg.image = UIImage(named:"pwdEye")
        pwdImg.tag = 1
        pwdImg.addOnClickLister(target: self, action: #selector(self.pwdOnclick))
        _passWord.addSubview(pwdImg)
        
      let _autoCode = setupInputArray(y: 445*PX, title: "验证码")
        authCode.frame = CGRect(x:134*PX,y:28*PX,width:424*PX,height:45*PX)
        authCode.placeholder = "请输入验证码"
        authCode.clearButtonMode = UITextFieldViewMode.always
        authCode.delegate = self
        authCode.textColor = myColor().gray3()
        authCode.resignFirstResponder()
        _autoCode.addSubview(authCode)
        
        authImg.frame = CGRect(x:563*PX,y:25*PX,width:127*PX,height:50*PX)
        authImg.layer.borderWidth = 0
        authImg.addOnClickLister(target: self, action: #selector(self.getAuthCode))
        _autoCode.addSubview(authImg)
        
        
        loginBtn.setupButton(30*PX, 617*PX, 69*PX, 100*PX, myColor().gray9(), myColor().grayF0(), "登录", 36, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        loginBtn.frame = CGRect(x:30*PX,y:617*PX,width:690*PX,height:100*PX)
        loginBtn.layer.cornerRadius = 5*PX
        tabbelView?.addSubview(loginBtn)
        
        loginBtn1.setupButton(30*PX, 617*PX, 69*PX, 100*PX,UIColor.white, myColor().blue2088ff(), "登录", 36, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        loginBtn1.frame = CGRect(x:30*PX,y:617*PX,width:690*PX,height:100*PX)
        loginBtn1.layer.cornerRadius = 5*PX
        loginBtn1.addTarget(self, action: #selector(self.logins), for: .touchUpInside)
        loginBtn1.isHidden = true
        tabbelView?.addSubview(loginBtn1)
        
        let registerBtn:QZHUILabelView = QZHUILabelView()
        registerBtn.setLabelView(30*PX, 777*PX, 160*PX, 37*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 26, "手机快速注册")
        registerBtn.addOnClickLister(target:self, action: #selector(self.goToRegister))
        tabbelView?.addSubview(registerBtn)
        
        let forgetPwdBtn:QZHUILabelView = QZHUILabelView()
        forgetPwdBtn.setLabelView(611*PX, 777*PX, 110*PX, 37*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 26, "忘记密码")
        forgetPwdBtn.addOnClickLister(target:self, action: #selector(self.goToForgetPWD))
        tabbelView?.addSubview(forgetPwdBtn)
    
    }
    
    // 输入框组设置
    func setupInputArray(y:CGFloat,title:String)->QZHUIView{
        let selfView:QZHUIView = QZHUIView()
        selfView.setupViews(x: 30*PX, y: y, width: 690*PX, height: 102*PX, bgColor: UIColor.clear)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 100*PX, width: 690*PX, height: 2*PX, color: myColor().grayEB())
        selfView.addSubview(line)
        
        let titleLabel:QZHUILabelView = QZHUILabelView()
        titleLabel.setLabelView(0, 28*PX, 100*PX, 45*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 32, title)
        selfView.addSubview(titleLabel)
        
        
        tabbelView?.addSubview(selfView)
        return selfView
    }
}

//MARK:- 设置 UITextFieldDelegate 代理方法
extension QZHOAuthViewController{
    
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
        if userName.text! != "" && passWord.text! != ""{
            loginBtn1.isHidden = false
            loginBtn.isHidden = true
        }else{
            loginBtn1.isHidden = true
            loginBtn.isHidden = false
        }
    } // 文本框是否可以清除内容
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField.tag == 1{
            loginBtn1.isHidden = true
            loginBtn.isHidden = false
        }
        return true
    }
    // 输入框按下键盘 return 收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // 该方法当文本框内容出现变化时 及时获取文本最新内容
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = currentText.replacingCharacters(in:range.toRange(string: currentText), with: string)
        if textField.restorationIdentifier == "name"{
           nameText = newText
        }else{
           pwdText = newText
        }
        
        if nameText != "" && pwdText != ""{
            loginBtn1.isHidden = false
            loginBtn.isHidden = true
        }else{
            loginBtn1.isHidden = true
            loginBtn.isHidden = false
        }
        return true
    }
}

//MARK:- 表格数据源方法，具体的数据源方法实现，不需要 super
extension QZHOAuthViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 850*PX
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

// MARK: - 监听方法
extension QZHOAuthViewController{
    //MARK: - 监听方法
    @objc func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 密码明文显示监听方法
    func pwdOnclick(){
        if pwdImg.tag == 1{
            pwdImg.image = UIImage(named:"pwdEye1")
            pwdImg.tag = 2
            passWord.isSecureTextEntry = false
        }else{
            pwdImg.image = UIImage(named:"pwdEye")
            pwdImg.tag = 1
            passWord.isSecureTextEntry = true
        }
    }
    
    // 跳转注册
    func goToRegister(){
        let nav = QZHRegisterViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 跳转忘记密码
    func goToForgetPWD(){
        let nav = QZHForgetPWDViewController()
        present(nav, animated: true, completion: nil)
    }
}
