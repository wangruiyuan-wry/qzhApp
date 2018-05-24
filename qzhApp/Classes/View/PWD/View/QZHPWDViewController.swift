//
//  QZHPWDViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/31.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHPWDViewController: QZHBaseViewController{
    
    // 视图模型初始化
    lazy var pwdData = QZHPWDViewModel()
    
    // 手机号码
    var phoneLabel:UITextField = UITextField()
    var phonetext = ""
    
    // 验证码
    var authCodeLabel:UITextField = UITextField()
    var authCodeText = ""
    
    // 获取验证码按钮
    var authBtn:QZHUIButton = QZHUIButton()
    var authBtn1:QZHUIButton = QZHUIButton()
    
    
    // 下一步按钮
    var nextBtn:QZHUIButton = QZHUIButton()
    var nextBtn1:QZHUIButton = QZHUIButton()
    
    // 倒计时
    var leftTime:Int = 60
    var timer :Timer!
    
    override func loadData() {
        
    }
    
    // 获取验证码
    func getAuth(){
        QZHPWDModel.phone = phoneLabel.text!
        if PublicFunction().isTelNumber(QZHPWDModel.phone as NSString){
            authBtn.isHidden = true
            authBtn1.isHidden = false
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
            pwdData.getAuthCode { (result, flag, isSuccess) in
                if flag{
                    
                }else{
                    UIAlertController.showAlert(message: result, in: self)
                }
            }
        }else{
            UIAlertController.showAlert(message: "请输入正确的手机号码!!", in: self)
        }
    }
    
    // 提交验证码
    func verifyAuthCode(){
        QZHPWDModel.phone = phoneLabel.text!
        QZHPWDModel.authCode = authCodeLabel.text!
        pwdData.verifyAuthCode { (result, flag, isSuccess) in
            if flag{
                let nav = QZHEditPWDViewController()
                self.present(nav, animated: true, completion: nil)
            }else{
                UIAlertController.showAlert(message: result, in: self)
            }
        }
    }
}
// MARK: - 设置忘记密码页面 UI
extension QZHPWDViewController{
    override func setupUI() {
        super.setupUI()
                
        // 去掉 tableview 分割线
        self.tabbelView?.separatorStyle = .none
        
        self.tabbelView?.y = 128*PX
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                self.tabbelView?.y = 176*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        
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
        title = QZHPWDModel.pageName
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        
        // 设置 logo 图像
        let logoImg:UIImageView = UIImageView(frame:CGRect(x:280*PX,y:19*PX,width:190*PX,height:190*PX))
        logoImg.image = UIImage(named:"userLogo")
        tabbelView?.addSubview(logoImg)
    }
    
    // 设置提交按钮
    func setupBtn(){
        nextBtn.setupButton(30*PX, 513*PX, 690*PX, 100*PX, myColor().gray9(), myColor().grayF0(), "下一步", 36, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        nextBtn.frame = CGRect(x:30*PX,y:513*PX,width:690*PX,height:100*PX)
        nextBtn.layer.cornerRadius = 5*PX
        tabbelView?.addSubview(nextBtn)
        
        nextBtn1.setupButton(30*PX, 513*PX, 690*PX, 100*PX, UIColor.white, myColor().blue2088ff(), "下一步", 36, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        nextBtn1.frame = CGRect(x:30*PX,y:513*PX,width:690*PX,height:100*PX)
        nextBtn1.addTarget(self, action: #selector(self.verifyAuthCode), for: .touchUpInside)
        nextBtn1.isHidden = true
        nextBtn1.layer.cornerRadius = 5*PX
        tabbelView?.addSubview(nextBtn1)
    }
    
    // 设置输入框表单
    func setupTextField(){
        let phoneView = self.setupListView(y: 241, title: "手机号", placeholder: "请输入手机号", inputName: phoneLabel, inputWidth: 324)
        phoneLabel.restorationIdentifier = "phone"
        authBtn.setupButton(499*PX, 20*PX, 195*PX, 60*PX, UIColor.white, myColor().blue2088ff(), "获取验证码", 30, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        authBtn.layer.cornerRadius = 5*PX
        authBtn.frame = CGRect(x:499*PX,y:20*PX,width:195*PX,height:60*PX)
        authBtn.addTarget(self, action: #selector(self.getAuth), for: .touchUpInside)
        phoneView.addSubview(authBtn)
        authBtn1.setupButton(499*PX, 20*PX, 195*PX, 60*PX, myColor().gray9(), myColor().grayF0(), "60S重新获取", 30, 0, UIColor.clear, "", UIControlState.normal, 0, UIViewContentMode.center)
        authBtn1.layer.cornerRadius = 5*PX
        authBtn1.frame = CGRect(x:499*PX,y:20*PX,width:195*PX,height:60*PX)
        authBtn1.isHidden = true
        phoneView.addSubview(authBtn1)
        
        self.setupListView(y: 343, title: "验证码", placeholder: "请输入验证码", inputName: authCodeLabel, inputWidth: 524)
        authCodeLabel.restorationIdentifier = "auth"
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

}

//MARK:- 表格数据源方法，具体的数据源方法实现，不需要 super
extension QZHPWDViewController{
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
extension QZHPWDViewController{
    
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
        nextBtn.isHidden = false
        nextBtn1.isHidden = true
        return true
    }
    // 该方法当文本框内容出现变化时 及时获取文本最新内容
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = currentText.replacingCharacters(in:range.toRange(string: currentText), with: string)
        if textField.restorationIdentifier == "phone"{
            phonetext = newText
        }
        if textField.restorationIdentifier == "auth"{
            authCodeText = newText
        }
        
        if phonetext != "" && authCodeText != "" {
            nextBtn.isHidden = true
            nextBtn1.isHidden = false
        }else{
            nextBtn.isHidden = false
            nextBtn1.isHidden = true
        }
        
        return true
    }
}

// MARK: - 监听方法
extension QZHPWDViewController{
    //MARK: - 监听方法
    @objc func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 倒计时
    func tickDown() {
        //将剩余时间减少1秒
        leftTime -= 1
        authBtn1.setTitle("\(leftTime)S重新获取", for: .normal)
        //如果剩余时间小于等于0
        if leftTime <= 0 {
            //取消定时器
            timer.invalidate()
            authBtn1.isHidden = true
            authBtn.isHidden = false
            leftTime = 60
            authBtn1.setTitle("\(leftTime)S重新获取", for: .normal)
        }
    }
}
