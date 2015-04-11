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
    
    var id: String?
    var name: String?
    var ra: String?
    var dec: String?
    var astroClassId: String?
    var link: String?
    
    // MARK: - LifeCycle
    
    init(response: [String: AnyObject?]) {
        super.init()
        
        let id = response["id"] as? String
        let name = response["name"] as? String
        let ra = response["ra"] as? String
        let dec = response["dec"] as? String
        let astroClassId = response["astro_class_id"] as? String
        let link = response["link"] as? String
        
        self.id = id
        self.name = name
        self.ra = ra
        self.dec = dec
        self.astroClassId = astroClassId
        self.link = link
    }
}
