//
//  CelestialView.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class CelestialView: UIView {
    
    // MARK: - Property
    
    class func instance() -> CelestialView {
        return UINib(nibName: "CelestialView", bundle: nil).instantiateWithOwner(self, options: nil).first as CelestialView
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.drawCelestial()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    // 引数にobjectもらって描写
    // UIButtonで
    func drawCelestial() {
        
        // base circle view
        let circleFrame = CGRectMake(20, 0, self.frame.size.width - 20, self.frame.size.height - 20)
        let circle = UIView(frame: circleFrame)
        circle.layer.cornerRadius = (self.frame.size.width - 20) / 2
        circle.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        self.addSubview(circle)
        
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
