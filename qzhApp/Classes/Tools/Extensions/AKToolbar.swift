//
//  AKToolbar.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/23.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
let _SingLetonToolbar = AKToolbar(frame: CGRectMake(0, 0, kScreenWidth, 44.0))

class AKToolbar: UIToolbar, UIInputViewAudioFeedback  {
    
    let previousItem: UIBarButtonItem
    let nextItem: UIBarButtonItem
    
    private let itemSpace: CGFloat = 25.0
    
    class var sharedInstance: AKToolbar{
        return _SingLetonToolbar
    }
    
    
    private override init(frame: CGRect) {
        let akManager = AutoKeyboardManager.sharedInstance
        
        previousItem = UIBarButtonItem(image:UIImage(named: "AKPrevious"), style: UIBarButtonItemStyle.Plain, target: akManager, action: "toolbarPreviousItemAction:")
        
        nextItem = UIBarButtonItem(image:UIImage(named: "AKNext"), style: UIBarButtonItemStyle.Plain, target: akManager, action: "toolbarNextItemAction:")
        
        super.init(frame: frame)
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        spaceItem.width = itemSpace
        
        let spaceItem1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: akManager, action: "toolbarDoneItemAction:")
        
        var itemsArray = [previousItem, spaceItem, nextItem, spaceItem1, doneItem]
        
        items = itemsArray
        
    }
    
    required init(coder aDecoder: NSCoder) {
        let akManager = AutoKeyboardManager.sharedInstance
        
        previousItem = UIBarButtonItem(image:UIImage(named: "AKPrevious"), style: UIBarButtonItemStyle.Plain, target: akManager, action: "toolbarPreviousItemAction:")
        
        nextItem = UIBarButtonItem(image:UIImage(named: "AKNext"), style: UIBarButtonItemStyle.Plain, target: akManager, action: "toolbarNextItemAction:")
        
        super.init(coder: aDecoder)
        let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        spaceItem.width = itemSpace
        
        let spaceItem1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: akManager, action: "toolbarDoneItemAction:")
        
        var itemsArray = [previousItem, spaceItem, nextItem, spaceItem1, doneItem]
        
        items = itemsArray
        
    }
    
    var enableInputClicksWhenVisible: Bool {
        get {
            return true
        }
    }
}
