//
//  UIViewController+Extension.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/27.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
extension UIViewController {
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}
