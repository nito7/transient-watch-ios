//
//  ChartViewController.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/12.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController, UITableViewDataSource,
                                             UITableViewDelegate {
    
    // MARK: - Property
    
    @IBOutlet weak var tableView: UITableView!
    var chartArray: [Chart] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chart"
        
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.setBackgroundImage(
            UIImage(),
            forBarMetrics: UIBarMetrics.DefaultPrompt
        )
        
        self.view.backgroundColor = UIColor.clearColor()
        self.tableView.backgroundColor = UIColor.clearColor()
        let backGroundImage = UIImage(named: "BackGround")
        let imageView = UIImageView(image: backGroundImage)
        imageView.frame = self.view.bounds
        self.navigationController?.view.insertSubview(imageView, atIndex: 0)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let homeNib = UINib(nibName: "HomeCell", bundle: nil)
        self.tableView.registerNib(homeNib, forCellReuseIdentifier: "HomeCell")
        
        self.fetchChartData()
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
    
    // MARK: - Private
    
    func fetchChartData() {
        SVProgressHUD.show()
        
        ChartModel.GET(
            success: { (task: NSURLSessionDataTask!, array: Array<Chart>!) -> Void in
                SVProgressHUD.showSuccessWithStatus("load success")
                
                self.chartArray = array
                
                let frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300)
                let chart = ChartView(frame: frame)
                self.tableView.setParallaxHeaderView(chart, mode: VGParallaxHeaderMode.TopFill, height: 300)
                self.tableView.reloadData()
            },
            failure: { (task: NSURLSessionDataTask!, error: NSError!) -> Void in
                SVProgressHUD.showErrorWithStatus("load error")
            }
        )
    }
    
    // MARK: - UITableView DataSource & Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Other"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector(Selector("setSeparatorInset:")) {
            cell.separatorInset = UIEdgeInsetsZero
        }
        
        if cell.respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:")) {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        if cell.respondsToSelector(Selector("setLayoutMargins:")) {
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell") as HomeCell
        return cell
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.shouldPositionParallaxHeader()
    }
}
