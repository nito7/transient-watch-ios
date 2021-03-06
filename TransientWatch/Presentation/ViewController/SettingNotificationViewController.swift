//
//  SettingNotificationViewController.swift
//  TransientWatch
//
//  Created by Akiho on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class SettingNotificationViewController: UIViewController {

    @IBOutlet var SettingNotificationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        AstroClassModel.index(["": ""],
            success: {(res: NSArray!) -> Void in
                
            },
            failure: {(error: NSError!) -> Void in
                
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openMenu(sender: UIBarButtonItem) {
        self.mm_drawerController.toggleDrawerSide(.Left, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
