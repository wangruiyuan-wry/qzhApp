//
//  AutoKeyboardManager.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/23.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

let _SingLetonAutoKeyboardManager = AutoKeyboardManager()

let kScreenWidth:CGFloat = UIScreen.mainScreen().bounds.size.width
let kScreenHeight:CGFloat = UIScreen.mainScreen().bounds.size.height

class AutoKeyboardManager: NSObject{
    
    //是否启用键盘管理器
    var enable: Bool {
        willSet {
            setKeyboardManagerEnable(newValue)
        }
    }
    
    
    //启用键盘的Toolbar
    var enableToolbar: Bool
    
    //弹出动画时间
    private var animationDuration: NSTimeInterval
    
    //当前点击的控件
    private var textView: UIView!
    
    //textfiled处于的controller.view、它的上移距离、Responder数组
    private var containerViewBeginFrame: CGRect
    private var containerViewOffset: CGFloat
    private var containerViewResponderArray: [UIView]
    
    //键盘有没有弹出
    private var keyBoardDidShow: Bool
    
    //键盘尺寸
    private var keyBoardSize: CGSize!
    
    //键盘和输入框之间的距离
    var spaceBetweenKeyboardAndTextView: CGFloat
    
    //窗口
    private var keyWindow:UIWindow? {
        get {
            return UIApplication.sharedApplication().keyWindow
        }
    }
    
    //需要注册的消息通知
    private let noficications =
        [UIKeyboardWillShowNotification : "keyboardWillShow:",
         UIKeyboardWillHideNotification : "keyboardWillHide:",
         
         UITextFieldTextDidBeginEditingNotification : "textFieldDidBeginEditing:",
         UITextFieldTextDidEndEditingNotification : "textFieldDidEndEditing:",
         
         UITextViewTextDidBeginEditingNotification : "textViewDidBeginEditing:",
         UITextViewTextDidEndEditingNotification : "textViewDidEndEditing:"]
    
    class var sharedInstance: AutoKeyboardManager{
        return _SingLetonAutoKeyboardManager
    }
    
    
    private override init() {
        enable = false
        enableToolbar = true
        keyBoardDidShow = false
        
        containerViewBeginFrame = CGRectZero
        containerViewOffset = 0.0
        containerViewResponderArray = Array()
        
        animationDuration = 0.25
        spaceBetweenKeyboardAndTextView = 5.0
        
        super.init()
    }
    
    //开启
    func setKeyboardManagerEnable(kbEnable: Bool) {
        let center = NSNotificationCenter.defaultCenter()
        
        //注册消息中心
        if kbEnable && !self.enable {
            for (key: String, value:AnyObkect) in noficications {
                let sel = Selector(value)
                center.addObserver(self, selector:sel , name:key, object:nil)
            }
            
        } else if !kbEnable && self.enable {
            for key in noficications.keys {
                center.removeObserver(self, name: key, object: nil)
            }
        }
        
    }
    
    private func getContainerViewController() -> UIViewController? {
        var controller = self.keyWindow?.rootViewController
        if controller == nil {
            println("必须要设置 UIWindow.rootViewController")
        } else{
            while (controller?.presentedViewController != nil) {
                controller = controller?.presentedViewController
            }
        }
        
        return controller
    }
    
    //递归找到所有view下得输入框
    private func getAllSubviews(view: UIView) {
        
        for oneObject in view.subviews {
            println("getSubviews from\(oneObject)")
            let oneView = oneObject as! UIView
            if oneView.canBecomeFirstResponder() {
                if(oneView.isKindOfClass(UITextView)) {
                    let oneTextView = oneView as! UITextView
                    if oneTextView.editable == true && oneTextView.hidden == false {
                        containerViewResponderArray.append(oneTextView)
                    }
                } else if(oneView.isKindOfClass(UITextField)) {
                    let oneTextField = oneView as! UITextField
                    if oneTextField.enabled == true && oneTextField.hidden == false {
                        containerViewResponderArray.append(oneTextField)
                    }
                }
                
            } else {
                getAllSubviews(oneView)
            }
        }
    }
    
    private func getAllResponder() {
        let controller = getContainerViewController()
        containerViewResponderArray.removeAll(keepCapacity: false)
        
        if let vc = controller {
            getAllSubviews(vc.view)
        }
    }
    
    //更新ToolBar按钮的状态
    private func setToolbarItemsStatus() {
        getAllResponder()
        
        var textFieldIndex = findIndex(containerViewResponderArray, textView)
        
        let toolBar = AKToolbar.sharedInstance
        if containerViewResponderArray.count <= 1 {
            toolBar.previousItem.enabled = false
            toolBar.nextItem.enabled = false
        } else if (textFieldIndex == 0) {
            toolBar.previousItem.enabled = false
            toolBar.nextItem.enabled = true
        } else if (textFieldIndex == containerViewResponderArray.count - 1) {
            toolBar.previousItem.enabled = true
            toolBar.nextItem.enabled = false
        } else {
            toolBar.previousItem.enabled = true
            toolBar.nextItem.enabled = true
        }
    }
    
    //移动controller.view来适配输入框位置
    private func setContainerViewOffset(offset: CGFloat) {
        let controller = getContainerViewController()
        var rect = containerViewBeginFrame
        
        containerViewOffset = offset
        
        rect.origin.y -= containerViewOffset
        
        UIView.animateKeyframesWithDuration(animationDuration, delay: 0.0, options: UIViewKeyframeAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            controller?.view.frame = rect
        }) { (finished) -> Void in
        }
    }
    
    private func adjustContainerViewFrame() {
        keyBoardDidShow = true
        
        if textView != nil && keyBoardSize != nil{
            let window = self.keyWindow
            let controller = getContainerViewController()
            
            let textFieldViewRect = textView.superview?.convert(textView.frame, to: window)
            let containerCurrentFrame = controller?.view.frame
            
            
            let textField_Y = textFieldViewRect!.origin.y + textFieldViewRect!.size.height
            let distance_Y = containerCurrentFrame!.size.height - textField_Y - containerViewOffset
            if (distance_Y) <= keyBoardSize.height {
                setContainerViewOffset(offset: keyBoardSize.height - distance_Y + spaceBetweenKeyboardAndTextView)
            }else if(containerViewOffset > 0.0) {
                setContainerViewOffset(offset: 0.0)
            }
        }
    }
    
    //Keyboard Notification Methods
    func keyboardWillShow(aNotification: NSNotification) {
        //获取键盘弹出动画时间
        let duration = aNotification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        if duration > 0 {
            animationDuration = NSTimeInterval(duration)
        }
        
        //获取键盘尺寸
        keyBoardSize = aNotification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size
        
        
        //对UITextView和UITextField的不同处理
        if textView != nil {
            if textView.isKindOfClass(UITextField) {
                adjustContainerViewFrame()
            } else if textView.isKindOfClass(UITextView) {
                let controller = getContainerViewController()
                containerViewBeginFrame = controller!.view.frame
            }
        }
    }
    
    
    func keyboardWillHide(aNotification: NSNotification) {
        println("keyboardWillHide")
        keyBoardDidShow = false
    }
    
    
    //UITextField Notification Methods
    func textFieldDidBeginEditing(aNotification: NSNotification) {
        textView = aNotification.object as! UIView
        
        //添加toolbar
        if enableToolbar {
            (textView as! UITextField).inputAccessoryView = AKToolbar.sharedInstance
            setToolbarItemsStatus()
        }
        
        if keyBoardDidShow {
            //键盘未收回时点击其他输入框的处理
            adjustContainerViewFrame()
        } else {
            let controller = getContainerViewController()
            containerViewBeginFrame = controller!.view.frame
        }
    }
    
    func textFieldDidEndEditing(aNotification: NSNotification) {
        
        if containerViewOffset > 0 {
            (textView as! UITextField).inputAccessoryView = nil
            textView = nil
            containerViewOffset = 0
            
            let controller = getContainerViewController()
            UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                controller!.view.frame = self.containerViewBeginFrame
            }, completion: nil)
        }
    }
    
    
    //UITextView Notification Mehtods
    func textViewDidBeginEditing(aNotification: NSNotification) {
        
        textView = aNotification.object as! UIView
        
        
        //添加toolbar
        if enableToolbar {
            if textView.inputAccessoryView == nil {
                
                (self.textView as! UITextView).inputAccessoryView = AKToolbar.sharedInstance
                self.textView.resignFirstResponder()
                
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(10 * NSEC_PER_MSEC))
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    self.textView.becomeFirstResponder()
                })
            } else {
                adjustContainerViewFrame()
            }
            setToolbarItemsStatus()
        }
    }
    
    
    func textViewDidEndEditing(aNotification: NSNotification) {
        
        if containerViewOffset > 0 {
            containerViewOffset = 0;
            
            let controller = getContainerViewController()
            UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                controller!.view.frame = self.containerViewBeginFrame
            }, completion: nil)
        }
    }
    
    
    //Toolbar Item Event
    func toolbarDoneItemAction(item: UIBarButtonItem) {
        if textView != nil {
            textView.resignFirstResponder()
        }
    }
    
    func toolbarPreviousItemAction(item: UIBarButtonItem) {
        if AKToolbar.sharedInstance.enableInputClicksWhenVisible {
            UIDevice.currentDevice.playInputClick()
        }
        
        let index = AnyIndex(containerViewResponderArray, textView)
        if index > 0 {
            let oneControl = containerViewResponderArray[index! - 1]
            oneControl.becomeFirstResponder()
        }
        
    }
    
    func toolbarNextItemAction(item: UIBarButtonItem) {
        if AKToolbar.sharedInstance.enableInputClicksWhenVisible {
            UIDevice.currentDevice.playInputClick()
        }
        
        let index = AnyIndex(containerViewResponderArray, textView)
        if index < containerViewResponderArray.count - 1 {
            let oneControl = containerViewResponderArray[index! + 1]
            oneControl.becomeFirstResponder()
        }
    }
}
