//
//  QZHRegisterViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/30.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHRegisterViewController: QZHBaseViewController,UITextFieldDelegate {
    
    let registerData:QZHRegisterViewModel = QZHRegisterViewModel()
    
    // 手机号码String
    var phonetext = ""
    
    // 验证码String
    var authCodetext = ""
    
    // 设置密码String
    var passwordtext = ""
    
    // 确认密码String
    var password1text = ""
    
    // 公司名称String
    var companyNametext = ""
    
    // 昵称String
    var nilkNmetext = ""
    
    // 手机号码
    var phoneLabel:UITextField = UITextField()
    
    // 验证码
    var authCodeLabel:UITextField = UITextField()
    
    // 设置密码
    var password:UITextField = UITextField()
    
    // 确认密码
    var password1:UITextField = UITextField()
    
    // 公司名称
    var companyNameLabel:UITextField = UITextField()
    
    // 昵称
    var nilkNmeLabel:UITextField = UITextField()
    
    // 提交按钮
    var submitBtn:QZHUIButton = QZHUIButton()
    var submitBtn1:QZHUIButton = QZHUIButton()
    
    // 获取验证码按钮
    var getAuthBtn:QZHUIButton = QZHUIButton()
    var getAuthBtn1:QZHUIButton = QZHUIButton()
    
    // 倒计时
    var leftTime:Int = 60
    var timer :Timer!
    
    // 确认密码验证按钮
    var pwdBtn:QZHUIButton = QZHUIButton()
    var pwdView:QZHUIView = QZHUIView()
    
    override func loadData() {
        
    }
    
    /// 获取验证码
    func getAuthCode(){
        if PublicFunction().isTelNumber(phoneLabel.text as! NSString){
            QZHRegisterModel.phone = phoneLabel.text!
            getAuthBtn.isHidden = true
            getAuthBtn1.isHidden = false
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
            registerData.getAuthCode { (result, regiuster, isSuccess) in
                if regiuster{
                   
                }else{
                    UIAlertController.showAlert(message: result, in: self)
                }
            }
        }else{
            UIAlertController.showAlert(message: "请输入正确的手机号码！！！", in: self)
        }
    }
    
    // 注册提交
    func registerSubmit(){
        QZHRegisterModel.phone = phoneLabel.text!
        QZHRegisterModel.authCode = authCodeLabel.text!
        QZHRegisterModel.password = password.text!
        QZHRegisterModel.companyName = companyNameLabel.text!
        QZHRegisterModel.nickName = nilkNmeLabel.text!
        print(QZHRegisterModel.nickName)
        registerData.register { (result, regiuster, isSuccess) in
            if regiuster{
                self.dismiss(animated: true, completion: nil)
            }else{
                UIAlertController.showAlert(message: result, in: self)
            }
        }
    }
}

// MARK: - 注册页面 UI 设置
extension QZHRegisterViewController{
    override func setupUI() {
        super.setupUI()
        
        // 去掉 tableview 分割线
        self.tabbelView?.separatorStyle = .none
        
        self.tabbelView?.y = 128*PX
        
        tabbelView?.backgroundColor = UIColor.white
        
        // 注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupNav()
        setupInfo()
        setupSubmitBtn()
    }
    // 设置导航栏
    func setupNav(){
        //设置导航条
        title = "快速注册"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        
        // 设置 logo 图像
        let logoImg:UIImageView = UIImageView(frame:CGRect(x:280*PX,y:19*PX,width:190*PX,height:190*PX))
        logoImg.image = UIImage(named:"userLogo")
        tabbelView?.addSubview(logoImg)
    }
    
    // 设置输入信息输入
    func setupInfo(){
        
       let phoneView = self.setupListView(y: 239, title: "手机号", placeholder: "请输入手机号码", inputName: phoneLabel, inputWidth: 330)
        getAuthBtn.setupButton(500*PX, 20*PX, 190*PX, 60*PX, UIColor.white, myColor().blue2088ff(), "获取验证码", 30, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        getAuthBtn.frame = CGRect(x:500*PX,y:20*PX,width:190*PX,height:60*PX)
        getAuthBtn.addTarget(self, action: #selector(self.getAuthCode), for: .touchUpInside)
        getAuthBtn.layer.cornerRadius = 5*PX
        getAuthBtn1.setupButton(500*PX, 20*PX, 190*PX, 60*PX, myColor().gray9(), myColor().grayF0(), "60S重新获取", 30, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        getAuthBtn1.frame = CGRect(x:500*PX,y:20*PX,width:190*PX,height:60*PX)
        getAuthBtn1.layer.cornerRadius = 5*PX
        getAuthBtn1.isHidden = true
        phoneLabel.restorationIdentifier = "phone"
        phoneView.addSubview(getAuthBtn)
        phoneView.addSubview(getAuthBtn1)
        
        self.setupListView(y: 341, title: "验证码", placeholder: "请输入验证码", inputName: authCodeLabel, inputWidth: 524)
        authCodeLabel.restorationIdentifier = "authCode"
        
        self.setupListView(y: 443, title: "设置密码", placeholder: "请设置密码", inputName: password, inputWidth: 524)
        password.restorationIdentifier = "password"
        password.isSecureTextEntry = true
        
        let passwordView = self.setupListView(y: 545, title: "确认密码", placeholder: "请输入确认密码", inputName: password1, inputWidth: 480)
        password1.isSecureTextEntry = true
        password1.restorationIdentifier = "password1"
        
        pwdBtn.frame = CGRect(x:651*PX,y:30*PX,width:40*PX,height:40*PX)
        pwdBtn.setImage(UIImage(named:"pwdIcon"), for: .normal)
        pwdBtn.addTarget(self, action: #selector(self.showPwdView), for: .touchUpInside)
        passwordView.addSubview(pwdBtn)
        
       // pwdView.setLabelView(391*PX, 20*PX, 243*PX, 60*PX, NSTextAlignment.center,UIColor(patternImage:UIImage(named:"pwdBG")!) , UIColor.white, 30, "密码输入错误")
        pwdView.setupViews(x: 391*PX, y: 20*PX, width: 243*PX, height: 60*PX, bgColor: UIColor.clear)
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(0*PX, 0*PX, 231*PX, 60*PX, NSTextAlignment.center, myColor().gray7F(), UIColor.white, 30, "密码输入错误")
        
        label.layer.cornerRadius = 5*PX
        label.clipsToBounds = true
        pwdView.addSubview(label)
        let img:UIImageView = UIImageView(frame:CGRect(x:231*PX,y:16*PX,width:12*PX,height:28*PX))
        img.image = UIImage(named:"pwdBG")
        
        pwdView.addSubview(img)
        passwordView.addSubview(pwdView)
        pwdView.isHidden = true
        
        self.setupListView(y: 657, title: "公司名称", placeholder: "请输入公司名称", inputName: companyNameLabel, inputWidth: 524)
        companyNameLabel.restorationIdentifier = "company"
        
        self.setupListView(y: 759, title: "昵称", placeholder: "请输入昵称", inputName: nilkNmeLabel, inputWidth: 524)
        nilkNmeLabel.restorationIdentifier = "nilk"
        
    }
    // 设置单条信息输入
    func setupListView(y:CGFloat,title:String,placeholder:String,inputName:UITextField,inputWidth:CGFloat)->QZHUIView{
        let selfView:QZHUIView = QZHUIView()
        selfView.setupViews(x: 30*PX, y: y*PX, width: 690*PX, height: 102*PX, bgColor: UIColor.clear)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 100*PX, width: 690*PX, height: 2*PX, color: myColor().grayEB())
        selfView.addSubview(line)
        
        
        let titleLabel:QZHUILabelView = QZHUILabelView()
        titleLabel.setLabelView(0, 28*PX, 140*PX, 45*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 32, title)
        selfView.addSubview(titleLabel)
        
        inputName.placeholder = placeholder
        inputName.clearButtonMode = .always
        inputName.frame = CGRect(x:166*PX,y:28*PX,width:inputWidth*PX,height:45*PX)
        inputName.textColor = myColor().gray3()
        inputName.delegate = self
        selfView.addSubview(inputName)
        
        tabbelView?.addSubview(selfView)
        return selfView
    }
    
    // 提交按钮设置
    func  setupSubmitBtn(){
        submitBtn.setupButton(30*PX, 917*PX, 690*PX, 100*PX, myColor().gray9(), myColor().grayF0(), "完成", 36, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        submitBtn.frame = CGRect(x:30*PX,y:917*PX,width:690*PX,height:100*PX)
        submitBtn.layer.cornerRadius = 5*PX
        tabbelView?.addSubview(submitBtn)
        
        submitBtn1.setupButton(30*PX, 917*PX, 690*PX, 100*PX, UIColor.white, myColor().blue2088ff(), "完成", 36, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        submitBtn1.frame = CGRect(x:30*PX,y:917*PX,width:690*PX,height:100*PX)
        submitBtn1.layer.cornerRadius = 5*PX
        submitBtn1.isHidden = true
        submitBtn1.addTarget(self, action: #selector(self.registerSubmit), for: .touchUpInside)
        tabbelView?.addSubview(submitBtn1)
    }
    
}

//MARK:- 表格数据源方法，具体的数据源方法实现，不需要 super
extension QZHRegisterViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1050*PX
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
extension QZHRegisterViewController{
    
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
        if phoneLabel.text != "" && authCodeLabel.text != "" && password.text != "" && pwdBtn.isHidden && companyNameLabel.text != "" && nilkNmeLabel.text != ""{
            submitBtn.isHidden = true
            submitBtn1.isHidden = false
        }else{
            submitBtn.isHidden = false
            submitBtn1.isHidden = true
        }
    } // 文本框是否可以清除内容
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        submitBtn.isHidden = false
        submitBtn1.isHidden = true
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
        
        if textField.restorationIdentifier == "phone"{
            phonetext = newText
        }
        
        if textField.restorationIdentifier == "password"{
            passwordtext = newText
        }
        
        if textField.restorationIdentifier == "password1"{
            password1text = newText
            if password1text == passwordtext && passwordtext != ""{
                pwdBtn.isHidden = true
            }else{
                pwdBtn.isHidden = false
            }
        }
        
        if textField.restorationIdentifier == "authCode"{
            authCodetext = newText
        }
        
        if textField.restorationIdentifier == "company"{
            companyNametext = newText
        }
        
        if textField.restorationIdentifier == "nilk"{
            nilkNmetext = newText
        }
        
        if nilkNmetext != "" && companyNametext != "" && phonetext != "" && password1text != "" && passwordtext != "" && authCodetext != "" {
            submitBtn.isHidden = true
            submitBtn1.isHidden = false
        }else{
            submitBtn.isHidden = false
            submitBtn1.isHidden = true
        }
        
        return true
    }
}
// MARK: - 监听方法
extension QZHRegisterViewController{
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
    
    // 倒计时
    func tickDown() {
        //将剩余时间减少1秒
        leftTime -= 1
        getAuthBtn1.setTitle("\(leftTime)S重新获取", for: .normal)
        //如果剩余时间小于等于0
        if leftTime <= 0 {
            //取消定时器
            timer.invalidate()
            getAuthBtn1.isHidden = true
            getAuthBtn.isHidden = false
            leftTime = 60
            getAuthBtn1.setTitle("\(leftTime)S重新获取", for: .normal)
        }
    }
}
