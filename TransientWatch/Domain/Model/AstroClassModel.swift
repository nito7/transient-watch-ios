//
//  AstroClass.swift
//  TransientWatch
//
//  Created by Akiho on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class AstroClassModel: NSObject {
    class func index(query: NSDictionary!, success: ((NSArray!) -> Void)!, failure: ((NSError!) -> Void)!) {
        API.sharedInstance.GET(
            "http://localhost:3000/astro_classes/",
            parameters: query,
            success: {(task: NSURLSessionDataTask!, response: AnyObject!) -> Void in
                var responseArray = response as NSArray
//                var entities = []
//                for data in responseArray {
//                    var id: String        = data["id"] as String
//                    var name: String      = data["id"] as String
//                    var createdAt: String = data["created_at"] as String
//                    var updatedAt: String = data["updated_at"] as String
//                    
//                    var astroClass: AstroClass = AstroClass(id: id, name: name, createdAt: createdAt, updatedAt: updatedAt)
//                    entities.append(astroClass)
//                }
            },
            failure: {(task: NSURLSessionDataTask!, error: NSError!) -> Void in
                println(error)
            }
        )
    }
   
}
