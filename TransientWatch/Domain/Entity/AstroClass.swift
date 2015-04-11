//
//  AstroClass.swift
//  TransientWatch
//
//  Created by Akiho on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class AstroClass: NSObject {
    var id: String?
    var name: String?
    var createdAt: String?
    var updatedAt: String?
    
    init(id: String, name: String, createdAt: String, updatedAt: String) {
        self.id        = id
        self.name      = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
