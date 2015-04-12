//
//  AstroObj.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/12.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class AstroObj: NSObject {
    
    // MARK: - Property
    
    var id: Int?
    var name: String?
    var ra: Float?
    var dec: Float?
    var astroClassId: Int?
    var fluxRate: Int?
    var link: String?
    
    // MARK: - LifeCycle
    
    init(response: [String: AnyObject?]) {
        super.init()
        
        let fluxRate = response["flux_rate"] as? Int
        
        let astroObj = response["astroObj"] as [String: AnyObject]
        let id = astroObj["id"] as? Int
        let name = astroObj["name"] as? String
        let ra = astroObj["ra"] as? Float
        let dec = astroObj["dec"] as? Float
        let astroClassId = astroObj["astro_class_id"] as? Int
        let link = astroObj["link"] as? String
        
        self.id = id
        self.name = name
        self.ra = ra
        self.dec = dec
        self.astroClassId = astroClassId
        self.fluxRate = fluxRate
        self.link = link
    }
}
