//
//  MenuViewController.swift
//  TransientWatch
//
//  Created by Akiho on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTableView: UITableView!
    
    var menuList = [
        ["name": "Home", "value": 0],
        ["name": "通知設定", "value": 1]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.menuTableView.delegate   = self
        self.menuTableView.dataSource = self
        self.menuTableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.text      = self.menuList[indexPath.row]["name"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        
        if self.menuList[indexPath.row]["value"]! == 0 {
            var nextController = storyBoard.instantiateViewControllerWithIdentifier("HomeViewController") as HomeViewController
            let navigation     = UINavigationController(rootViewController: nextController)
            self.mm_drawerController.setCenterViewController(navigation, withCloseAnimation: true, completion: nil)
        } else if self.menuList[indexPath.row]["value"]! == 1 {
            var nextController = storyBoard.instantiateViewControllerWithIdentifier("SettingNotificationViewController") as SettingNotificationViewController
            let navigation     = UINavigationController(rootViewController: nextController)
            self.mm_drawerController.setCenterViewController(navigation, withCloseAnimation: true, completion: nil)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuList.count
    }

}
