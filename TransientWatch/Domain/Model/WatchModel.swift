//
//  AstroObj.swift
//  TransientWatch
//
//  Created by Akiho on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class WatchModel: NSObject {
    class func index(query: NSDictionary!, success: ((NSArray!) -> Void)!, failure: ((NSError!) -> Void)!) {
        API.sharedInstance.GET(
            "",
            parameters: query,
            success: {(task: NSURLSessionDataTask!, response: AnyObject!) -> Void in
                    
            },
            failure: {(task: NSURLSessionDataTask!, error: NSError!) -> Void in
                    
            }
        )
    }
}
