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
    var astroObj: AstroObj?
    var chartArray: [Chart] = []
    var chartView = ChartView(frame: CGRectZero)
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = astroObj?.name
        
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
        let nib = UINib(nibName: "ChartCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "Chart")
        
        let frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300)
        self.chartView = ChartView(frame: frame)
        self.tableView.setParallaxHeaderView(
            self.chartView,
            mode: VGParallaxHeaderMode.TopFill,
            height: 300
        )
        
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
        
        var id = 1
        if let validId = self.astroObj?.id { id = validId }
        
        ChartModel.GET(
            id: id.description,
            success: { (task: NSURLSessionDataTask!, array: Array<Chart>!) -> Void in
                
                self.chartArray = array
                
                let frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300)
                self.chartView.chartData = self.chartArray
                self.chartView.drawChart(frame)
                self.tableView.reloadData()
                
                SVProgressHUD.showSuccessWithStatus("load success")
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
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Chart") as ChartCell
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        if indexPath.row == 0 {
            cell.textLabel?.text = astroObj?.name
        }
        else if indexPath.row == 1 {
            cell.sectionLabel.text = "Ra:"
            cell.valueLabel.text = astroObj?.ra?.description
        }
        else if indexPath.row == 2 {
            cell.sectionLabel.text = "Dec:"
            cell.valueLabel.text = astroObj?.dec?.description
        }
        else if indexPath.row == 3 {
            cell.sectionLabel.text = "Class:"
            cell.valueLabel.text = astroObj?.astroClassId?.description
        }
        else if indexPath.row == 4 {
            cell.sectionLabel.text = "Flux Chane:"
            cell.valueLabel.text = "100%"
        }
        else if indexPath.row == 5 {
            cell.sectionLabel.text = "Date URL:"
            cell.valueLabel.text = astroObj?.link
            cell.accessoryType = .DisclosureIndicator
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 5 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let browser = storyboard.instantiateViewControllerWithIdentifier("BrowserViewController") as BrowserViewController
            if let url = self.astroObj?.link {
                browser.url = NSURL(string: url)
            }
            self.navigationController?.pushViewController(browser, animated: true)
            
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.shouldPositionParallaxHeader()
    }
}
