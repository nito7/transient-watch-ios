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
    
    var id: Int?
    var bandID: Int?
    var mjd: NSNumber?
    var flux: NSNumber?
    var err: NSNumber?
    
    // LifeCycle
    
    init(response: [String: AnyObject]) {
        super.init()
        
        let id = response["id"] as? Int
        
        let bandID = response["band_id"] as? Int
        
        var mjd: NSNumber?
        if let mjdFloat = response["mjd"] as? Float {
            mjd = NSNumber(float: mjdFloat)
        }
        
        var flux: NSNumber?
        if let fluxFloat = response["flux"] as? Float {
            flux = NSNumber(float: fluxFloat)
        }
        
        var err: NSNumber?
        if let errFloat = response["err"] as? Float {
            err = NSNumber(float: errFloat)
        }
        
        self.id = id
        self.bandID = bandID
        self.mjd = mjd
        self.flux = flux
        self.err = err
    }
    
}
