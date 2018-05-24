//
//  UIImageView+extension.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/29.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleToFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // The download has finished.
            if error != nil {
                self.image = UIImage(named:"noPic")
            } else {
                if (response as? HTTPURLResponse) != nil {
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)
                        // Do something with your image.
                        DispatchQueue.main.async() { () -> Void in
                            self.image = image
                        }
                        
                    } else {
                        self.image = UIImage(named:"noPic")
                    }
                } else {
                    self.image = UIImage(named:"noPic")
                }
            }
            
            }.resume()
        
    }
    func downloadedFrom1(url: URL, contentMode mode: UIViewContentMode = .scaleToFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // The download has finished.
            if let e = error {
                self.image = UIImage(named:"noPic")
            } else {
                if let res = response as? HTTPURLResponse {
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        var image = UIImage(data: imageData)
                        // Do something with your image.
                         image = image?.specifiesWidth(80*PX)
                        DispatchQueue.main.async() { () -> Void in
                            self.image = image
                        }
                        
                    } else {
                        self.image = UIImage(named:"noPic")
                    }
                } else {
                    self.image = UIImage(named:"noPic")
                }
            }
            
            }.resume()
        
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }  
}
