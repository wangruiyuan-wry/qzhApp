//
//  Double+Extension.swift
//  qzhApp
//
//  Created by sbxmac on 2018/2/5.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

extension Double {
    
    /// Rounds the double to decimal places value
    
    func roundTo(places:Int) -> Double {
        
        let divisor = pow(10.0, Double(places))
        
        return (self * divisor).rounded() / divisor
        
    }
    
}
