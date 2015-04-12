//
//  HomeViewController.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource,
                                            UITableViewDelegate,
                                            CelestialViewDelegate {
    
    // MARK: - Property
    
    @IBOutlet weak var tableView: UITableView!
    var astroObjArray: [AstroObj] = []
    var headerView = CelestialView(frame: CGRectZero)
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        
        ////////////////////////
        // 13 9 35
        // navigation controller
        ////////////////////////
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.setBackgroundImage(
            UIImage(),
            forBarMetrics: UIBarMetrics.DefaultPrompt
        )
        
        ////////////////
        // 背景画像の設定
        ////////////////
        self.view.backgroundColor = UIColor.clearColor()
        self.tableView.backgroundColor = UIColor.clearColor()
        let backGroundImage = UIImage(named: "BackGround")
        let imageView = UIImageView(image: backGroundImage)
        imageView.frame = self.view.bounds
        self.navigationController?.view.insertSubview(imageView, atIndex: 0)
                
        ////////////////
        // ヘッダー設定
        ////////////////
//        let headerView = CelestialView.instance()
        self.headerView = CelestialView(frame: CGRectMake(0, 0, self.view.frame.size.width - 20, 300))
        self.headerView.delegate = self
        self.tableView.setParallaxHeaderView(self.headerView, mode: VGParallaxHeaderMode.Top, height: 300)
        
        /////////////////
        // TableView設定
        /////////////////
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let homeNib = UINib(nibName: "HomeCell", bundle: nil)
        self.tableView.registerNib(homeNib, forCellReuseIdentifier: "HomeCell")
        
        self.fetchAstroObj()
    }
    
    deinit {
        self.headerView.delegate = nil
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
    
    @IBAction func toggleMenu(sender: UIBarButtonItem) {
        self.mm_drawerController.toggleDrawerSide(
            .Left,
            animated: true,
            completion: nil
        )
    }
    
    func fetchAstroObj() {
        SVProgressHUD.show()
        
        AstroObjModel.GET(
            success: { (task: NSURLSessionDataTask!, array: Array<AstroObj>!) -> Void in
                SVProgressHUD.showSuccessWithStatus("load success")
                
                self.astroObjArray = array
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            },
            failure: { (task: NSURLSessionDataTask!, error: NSError!) -> Void in
                SVProgressHUD.showErrorWithStatus("load error")
            }
        )
    }
    
    func pushChartViewController(#id: Int) {
        
        let astroObj = self.astroObjArray[id] as AstroObj
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chartViewController = storyboard.instantiateViewControllerWithIdentifier("ChartViewController") as ChartViewController
        chartViewController.astroObj = astroObj
        self.navigationController?.pushViewController(chartViewController, animated: true)
    }
    
    // MARK: - UITableView DataSource & Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Watch"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.astroObjArray.count
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
        cell.astroObj = self.astroObjArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.pushChartViewController(id: indexPath.row)
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.shouldPositionParallaxHeader()
    }
    
    // MARK: - CelestialViewDelegate
    
    func didPressAstroObj() {
        self.pushChartViewController(id: 1)
    }
    
}
