//
//  QZHLaunchViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/22.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHLaunchViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    fileprivate var scrollView: UIScrollView!
    
    var timer :Timer?
    
    
    fileprivate let numOfPages = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = self.view.bounds
        startButton.frame = CGRect(x:150*PX,y:SCREEN_HEIGHT - 170*PX,width:450*PX,height:100*PX)
        startButton.layer.cornerRadius = 100*PX
        startButton.backgroundColor = UIColor.clear
        startButton.layer.borderColor = myColor().blue007aff().cgColor
        //startButton.layer.borderWidth = 1*PX
        startButton.addOnClickLister(target: self, action: #selector(self.toHome))
        
        scrollView = UIScrollView(frame: frame)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPoint.zero
        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: frame.size.height)
        
        scrollView.delegate = self
        
        for index  in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "launchimg\(index + 1)"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            scrollView.addSubview(imageView)
        }
        
        self.view.insertSubview(scrollView, at: 0)
        
        // 给开始按钮设置圆角
        //startButton.layer.cornerRadius = 15.0
        // 隐藏开始按钮
        startButton.alpha = 0.0
        
        //timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: "change:", userInfo: nil, repeats: true)
    }
    
    // 隐藏状态栏
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func toHome(){
        let nav = QZHMainViewController()
        present(nav, animated: true, completion: nil)
    }
}


// MARK: - UIScrollViewDelegate
extension QZHLaunchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        pageControl.currentPage = Int(offset.x / view.bounds.width)
        
        // 因为currentPage是从0开始，所以numOfPages减1
        if pageControl.currentPage == numOfPages - 1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.startButton.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.startButton.alpha = 0.0
            })
        }
    }
    
    func change(_ timer :Timer) {
       // scrollView?.setContentOffset(CGPointMake((CGFloat(pageC!.currentPage + 1)) * SCROLL_WIDTH, 0), animated: false)
    }
    
    //开启定时器
    func addTimer() {
       //// timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.ch)), userInfo: nil, repeats: true)
    }
    //关闭定时器
    func removeTimer() {
        timer?.invalidate()
    }
    
    //开始拖拽时调用
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //关闭定时器
        removeTimer()
    }
    
    //拖拽结束后调用
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //开启定时器
        addTimer()
    }
}
