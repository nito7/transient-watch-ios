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
    var link: String?
    
    // MARK: - LifeCycle
    
    init(response: [String: AnyObject?]) {
        super.init()
        
        let id = response["id"] as? Int
        let name = response["name"] as? String
        let ra = response["ra"] as? Float
        let dec = response["dec"] as? Float
        let astroClassId = response["astro_class_id"] as? Int
        let link = response["link"] as? String
        
        self.id = id
        self.name = name
        self.ra = ra
        self.dec = dec
        self.astroClassId = astroClassId
        self.link = link
    }
}
