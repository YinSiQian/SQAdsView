//
//  SQAdsView.swift
//  SQAdsView
//
//  Created by YinSQ on 2017/3/31.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

enum CountDownButtonType {
    case round
    case oval
    case normal
}

enum CountDownButtonLocation {
    case TopRightCorner
    case TopLeftCorner
    case TopHorizontally
    case BottomRightCorner
    case BottomLeftCorner
    case BottomHorizontally
}


class SQAdsView: UIView {

    var imageView: UIImageView!
    
    var timeBtn: UIButton!
    
    var timer: Timer!
    
    var times = 3
    
    fileprivate var height: CGFloat = 25
    
    fileprivate let width: CGFloat = 50
    
    fileprivate let screen_width = UIScreen.main.bounds.width
    
    fileprivate let screen_height = UIScreen.main.bounds.height
    
    var location: CountDownButtonLocation = .TopRightCorner
    
    var type: CountDownButtonType = .normal
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        setupSubviews()
    }
    
    convenience init(frame: CGRect, location: CountDownButtonLocation, type: CountDownButtonType) {
        self.init(frame: frame)
        self.location = location
        self.type = type
        self.changeLocation()
        self.changeStyle()
    }
    
    fileprivate func setupSubviews() {
        self.imageView = UIImageView.init(frame: self.bounds)
        self.addSubview(self.imageView)
        
        timeBtn = UIButton.init(frame: CGRect.init(x: screen_width - 70, y: 40, width: width, height: height))
        timeBtn.setTitle("跳过 3", for: .normal)
        timeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        timeBtn.setTitleColor(UIColor.black, for: .normal)
        timeBtn.backgroundColor = UIColor.orange
        timeBtn.addTarget(self, action: #selector(SQAdsView.jumpAD), for: .touchUpInside)
        self.addSubview(timeBtn)
        
    }
    
    private func changeLocation() {
        let rect = self.timeBtn.frame
        switch location {
        case .BottomHorizontally:
            self.timeBtn.frame = CGRect(origin: CGPoint(x: (screen_width - rect.width) / 2, y: screen_height - 100 ), size: CGSize(width: rect.width, height: rect.height))
            
        case .BottomLeftCorner:
            self.timeBtn.frame = CGRect(x: 30, y: screen_height - 100, width: rect.width, height: rect.height)
            
        case .BottomRightCorner:
            self.timeBtn.frame = CGRect(x:screen_width - 70, y: screen_height - 100, width: rect.width, height: rect.height)
            
        case .TopHorizontally:
            self.timeBtn.frame = CGRect(x:(screen_width - rect.width) / 2, y: 40, width: rect.width, height: rect.height)
            
        case .TopLeftCorner:
            self.timeBtn.frame = CGRect(x:30, y: 40, width: rect.width, height: rect.height)
            
        case .TopRightCorner:
            self.timeBtn.frame = CGRect(x:screen_width - 70, y: 40, width: rect.width, height: rect.height)
            
        }
    }
    
    private func changeStyle() {
        switch type {
        case .oval:
            self.timeBtn.layer.cornerRadius = self.timeBtn.frame.height / 2
            
        case .round:
            var rect = self.timeBtn.frame
            rect.size.height = width
            self.timeBtn.frame = rect
            self.timeBtn.layer.cornerRadius = width / 2
            self.timeBtn.layer.masksToBounds = true
            
        case .normal:
            self.timeBtn.layer.cornerRadius = 2
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func start() {
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
                [unowned self] (_) in
                
               self.countDown()
            })
        } else {
            // Fallback on earlier versions
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SQAdsView.countDown), userInfo: nil, repeats: true)
        }
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    func removed() {
        timer.invalidate()
        var rect = self.frame
        rect.origin.y = -screen_height
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .beginFromCurrentState, animations: {
            self.frame = rect
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    @objc fileprivate func countDown() {
        if self.times == 0 {
            self.removed()
        }
        let title = "跳过" + " \(self.times)"
        print(title)
        self.timeBtn.setTitle(title, for: .normal)
        self.times -= 1
    }
    
    @objc fileprivate func jumpAD() {
        timer.invalidate()
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            self.alpha = 0.0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    deinit {
        print("it is dealloc")
        timer = nil
    }


}
