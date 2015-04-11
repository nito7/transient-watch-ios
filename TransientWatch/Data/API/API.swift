//
//  API.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class API: AFHTTPSessionManager {
    
    // MARK: - Singleton
    
    class var sharedInstance: API {
        struct Static {
            static let instance: API = API()
        }
        
        return Static.instance
    }
}
