//
//  CelestialView.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class CelestialView: UIView {

    class func instance() -> CelestialView {
        return UINib(nibName: "CelestialView", bundle: nil).instantiateWithOwner(self, options: nil).first as CelestialView
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
