//
//  CelestialView.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

protocol CelestialViewDelegate {
    func didPressAstroObj(#id: Int)
}

class CelestialView: UIView {
    
    // MARK: - Property
    
    var delegate: CelestialViewDelegate?
    
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
        
        // 天体
        let button = UIButton(frame: CGRectMake(30, 100, 30, 30))
        button.backgroundColor = UIColor.redColor()
        button.alpha = 0.5
        button.layer.cornerRadius = 15
        circle.addSubview(button)
        button.addTarget(
            self, 
            action: "pressButton",
            forControlEvents: UIControlEvents.TouchUpInside
        )
        
        let button2 = UIButton(frame: CGRectMake(200, 200, 30, 30))
        button2.backgroundColor = UIColor.redColor()
        button2.alpha = 0.5
        button2.layer.cornerRadius = 15
        circle.addSubview(button2)
        button2.addTarget(
            self,
            action: "pressButton2",
            forControlEvents: UIControlEvents.TouchUpInside
        )
        
        let button3 = UIButton(frame: CGRectMake(150, 130, 20, 20))
        button3.backgroundColor = UIColor.redColor()
        button3.alpha = 0.5
        button3.layer.cornerRadius = 10
        circle.addSubview(button3)
        button3.addTarget(
            self,
            action: "pressButton3",
            forControlEvents: UIControlEvents.TouchUpInside
        )
    }
    
    func pressButton() {
        self.delegate?.didPressAstroObj(id: 1)
    }
    
    func pressButton2() {
        self.delegate?.didPressAstroObj(id: 2)
    }
    
    func pressButton3() {
        self.delegate?.didPressAstroObj(id: 3)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
