//
//  Application+Extension.swift
//  qzhApp
//
//  Created by sbxmac on 2018/2/1.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

extension UIApplication{
    var statusBarview:UIView?{
        return value(forKey: "statusBar") as? UIView
    }
}
