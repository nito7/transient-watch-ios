//
//  AstroObjModel.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/12.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class AstroObjModel: NSObject {
    
    // MARK: - Public
    
    class func GET(
        #success: ((NSURLSessionDataTask!, Array<AstroObj>!) -> Void)!,
        failure: ((NSURLSessionDataTask!, NSError!) -> Void)!) {
            
            var astroObjArray: [AstroObj] = []
            
            API.sharedInstance.GET(
                "http://www12480uf.sakura.ne.jp:3000/astroObjs/",
                parameters: nil,
                success: { (task: NSURLSessionDataTask!, result: AnyObject!) -> Void in
                    var responseArray = result as NSArray
                    
                    for response in responseArray {
                        let astroObjResponse = response as [String: AnyObject]
                        let astroObj = AstroObj(response: astroObjResponse)
                        astroObjArray.append(astroObj)
                    }
                    
                    success(task, astroObjArray)
                },
                failure: { (task: NSURLSessionDataTask!, error: NSError!) -> Void in
                    failure(task, error)
                }
            )
    }
}
