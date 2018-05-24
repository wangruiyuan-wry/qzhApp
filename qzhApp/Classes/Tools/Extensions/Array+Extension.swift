//
//  Array+Extension.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/15.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

extension Array {
    //Array方法扩展，支持根据索引数组删除
    mutating func removeAtIndexes(ixs: [Int]) {
        for i in ixs.sorted(by: >) {
            self.remove(at: i)
        }
    }
}
