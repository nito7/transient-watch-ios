//
//  HomeViewController.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Property
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        self.tableView.backgroundColor = UIColor.clearColor()
        
        // Do any additional setup after loading the view.
        
//        let frame = CGRectMake(0, 50, CGRectGetWidth(self.view.frame), 450)
//        let chart = ChartView(frame: frame)
//        self.view.addSubview(chart)
        
        let headerView = CelestialView.instance()
        
        let textLabel = UILabel(frame: CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 50))
        textLabel.textAlignment = .Center
        textLabel.text = "ヘッダー"
//        headerView.addSubview(textLabel)
        
        let label = UILabel()
        label.backgroundColor = UIColor.redColor()
        label.textAlignment = .Center
        label.text = "パララックスへっだー"
        
        self.tableView.setParallaxHeaderView(headerView, mode: VGParallaxHeaderMode.TopFill, height: 300)
        
        self.tableView.parallaxHeader.stickyViewPosition = VGParallaxHeaderStickyViewPosition.Bottom
        self.tableView.parallaxHeader.setStickyView(label, withHeight: 40.0)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let homeNib = UINib(nibName: "HomeCell", bundle: nil)
        self.tableView.registerNib(homeNib, forCellReuseIdentifier: "HomeCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
    
    @IBAction func toggleMenu(sender: UIBarButtonItem) {
        self.mm_drawerController.toggleDrawerSide(.Left, animated: true, completion: nil)
    }
    
    // MARK: - UITableView DataSource & Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
        cell.textLabel?.text = "Test"
        return cell
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.shouldPositionParallaxHeader()
        
        scrollView.parallaxHeader.stickyView.alpha = scrollView.parallaxHeader.progress
    }

}
