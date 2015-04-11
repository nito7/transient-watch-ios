//
//  Chart.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class Chart: NSObject {
    
    // MARK: - Property
    
    var title: String?
    var x: NSNumber?
    var y: NSNumber?
    var maxY: NSNumber?
    var minY: NSNumber?
    
    // LifeCycle
    
    init(response: [String: AnyObject]) {
        super.init()
        
        let title = response["title"] as? String
        let x = response[""] as? NSNumber
        let y = response[""] as? NSNumber
        let maxY = response[""] as? NSNumber
        let minY = response[""] as? NSNumber
        
        // だいにゅう...
    }
    
}
