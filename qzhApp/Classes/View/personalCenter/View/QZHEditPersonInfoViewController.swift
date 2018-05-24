//
//  QZHEditPersonInfoViewController.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/13.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHEditPersonInfoViewController: QZHBaseViewController {
    
    // 个人信息视图模型懒加载
    lazy var userInfo = QZHPersonalCenterMyViewModel()
    
    // 文本输入框
    var textFiled:UITextField = UITextField()
    
    override func loadData() {
        
    }

}

// MARK: - 设置页面 UI样式
extension QZHEditPersonInfoViewController{
    override func setupUI() {
        super.setupUI()
        tabbelView?.isHidden = true
        setStatusBarBackgroundColor(color: .white)
        self.view.backgroundColor = myColor().grayF0()
        setupNavTitle()
        setBody()
    }
    
    // 设置头部导航栏
    func setupNavTitle(){
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(self.close))
        
        self.title = "修改\(QZHPersonalCenterMyInfoModel.eidtTitle)"
    }
    
    // 设置页面内容
    func setBody(){
        let btn:UIButton = UIButton(frame:CGRect(x:20*PX,y:268*PX,width:710*PX,height:104*PX))
        self.view.addSubview(btn)
        btn.setTitle("保存", for: .normal)
        btn.tintColor = UIColor.white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 36*PX)
        btn.backgroundColor = myColor().blue007aff()
        btn.addTarget(self, action: #selector(self.edit), for:.touchUpInside)
        btn.layer.cornerRadius = 5*PX
        
        
        let thisView:QZHUIView = QZHUIView()
        thisView.setupViews(x: 0, y: 148*PX, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
        self.view.addSubview(thisView)
        textFiled.frame = CGRect(x:20*PX,y:0,width:SCREEN_WIDTH-38*PX,height:80*PX)
        thisView.addSubview(textFiled)
       
        if QZHPersonalCenterMyInfoModel.eidtTitle == "昵称"{
            textFiled.placeholder = QZHPersonalCenterMyInfoModel.nickName
        }else if QZHPersonalCenterMyInfoModel.eidtTitle == "真实姓名"{
            textFiled.placeholder = QZHPersonalCenterMyInfoModel.realName
        }else if QZHPersonalCenterMyInfoModel.eidtTitle == "联系电话"{
            textFiled.placeholder = QZHPersonalCenterMyInfoModel.phone
        }
        
        textFiled.textColor = myColor().gray3()
        textFiled.restorationIdentifier = "name"
        textFiled.clearButtonMode = UITextFieldViewMode.always
        textFiled.delegate = self

        
    }
}

// MARK: - 监听方法
extension QZHEditPersonInfoViewController{
    // 返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    // 保存
    func edit(){
        if QZHPersonalCenterMyInfoModel.eidtTitle == "昵称"{
            QZHPersonalCenterMyInfoModel.nickName = textFiled.text!
        }else if QZHPersonalCenterMyInfoModel.eidtTitle == "真实姓名"{
            QZHPersonalCenterMyInfoModel.realName = textFiled.text!
        }else if QZHPersonalCenterMyInfoModel.eidtTitle == "联系电话"{
            QZHPersonalCenterMyInfoModel.phone = textFiled.text!
        }
        self.userInfo.editPersonInfo { (isSuccess, msg) in
            if isSuccess{
                self.dismiss(animated: true, completion: nil)
            }else{
                UIAlertController.showAlert(message: msg, in: self)
            }
        }
    }
}
