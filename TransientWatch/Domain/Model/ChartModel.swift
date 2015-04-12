//
//  ChartModel.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class ChartModel: NSObject {
    
    class func GET(
        #id: String,
        success: ((NSURLSessionDataTask!, Array<Chart>!) -> Void)!,
        failure: ((NSURLSessionDataTask!, NSError!) -> Void)!) {
            
            var chartArray: [Chart] = []
            
            API.sharedInstance.GET(
                "http://www12480uf.sakura.ne.jp:3000/lightcurves/\(id)",
                parameters: nil,
                success: { (task: NSURLSessionDataTask!, result: AnyObject!) -> Void in
                    var responseArray = result as NSArray
                    
                    for response in responseArray {
                        let chartResponse = response as [String: AnyObject]
                        let chart = Chart(response: chartResponse)
                        chartArray.append(chart)
                    }
                    
                    success(task, chartArray)
                },
                failure: {(task: NSURLSessionDataTask!, error: NSError!) -> Void in
                    failure(task, error)
                }
            )
    }
}
