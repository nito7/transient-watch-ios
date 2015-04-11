//
//  HomeViewController.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, PNChartDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let lineChart = PNLineChart(frame: CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 200))
        lineChart.yLabelFormat = "%1.1"
        lineChart.backgroundColor = UIColor.clearColor()
        let xLabels = ["1", "2", "3", "4", "5", "6", "7"]
        lineChart.xLabels = xLabels
        lineChart.showCoordinateAxis = true
        
        lineChart.yFixedValueMax = 300
        lineChart.yFixedValueMin = 0.0
        
        let yLabels = ["0", "50", "100", "150", "200", "250", "300"]
//        lineChart.yLabels = yLabels
        lineChart.yLabelHeight = 20
        lineChart.yLabelFormat = "%1.0f"
        
        let dataArray = [
            NSNumber(double: 10.0),
            NSNumber(double: 30.0),
            NSNumber(double: 10.0),
            NSNumber(double: 45.0),
            NSNumber(double: 80.0)
        ]
        let chartData = PNLineChartData()
        chartData.dataTitle = "title"
        chartData.color = UIColor.redColor()
        chartData.alpha = 0.3
        chartData.itemCount = UInt(dataArray.count)
        chartData.inflexionPointStyle = .Triangle
        chartData.getData = ({(index: UInt) -> PNLineChartDataItem in
            var yValue = dataArray[Int(index)]
            var float = CGFloat(yValue)
            var item = PNLineChartDataItem(y: float)
            return item
        })
        
        lineChart.chartData = [chartData]
        lineChart.strokeChart()
        lineChart.delegate = self
        self.view.addSubview(lineChart)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PNChartDelegate
    
    func userClickedOnLinePoint(point: CGPoint, lineIndex: Int) {
        
    }
    
    func userClickedOnLineKeyPoint(point: CGPoint, lineIndex: Int, pointIndex: Int) {
        
    }
    
    func userClickedOnBarAtIndex(barIndex: Int) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func toggleMenu(sender: UIBarButtonItem) {
        self.mm_drawerController.toggleDrawerSide(.Left, animated: true, completion: nil)
    }

}
