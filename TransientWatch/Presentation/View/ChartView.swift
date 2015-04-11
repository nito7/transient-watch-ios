//
//  ChartView.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

// 配列にしてDataObjectを突っ込む

class ChartView: UIView, CPTPlotDataSource, CPTPlotSpaceDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var scatterPlotData: [[NSNumber: NSNumber]] = []
    var scatterPlotData2: [[NSNumber: NSNumber]] = []
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.drawChart(frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    func drawChart(frame: CGRect) {
        
        let fieldX = NSNumber(integer: CPTRangePlotField.X.hashValue)
        let fieldY = NSNumber(integer: CPTRangePlotField.Y.hashValue)
        let fieldMaxY = NSNumber(integer: CPTRangePlotField.High.hashValue)
        let fieldMinY = NSNumber(integer: CPTRangePlotField.Low.hashValue)
        
        let r =  arc4random_uniform(10)
        
        for var i = 0; i < 10; i++ {
            let x = NSNumber(integer: i)
            let y = NSNumber(integer: (10 * i))
            let maxY = NSNumber(integer: 10)
            let minY = NSNumber(integer: 10)
            
            let object = [fieldX : x, fieldY: y, fieldMaxY: maxY, fieldMinY: minY]
            
            self.scatterPlotData.append(object)
        }
        
        for var i = 0; i < 10; i++ {
            let x = NSNumber(integer: i)
            let y = NSNumber(integer: (20 * i))
            let maxY = NSNumber(integer: 10)
            let minY = NSNumber(integer: 10)
            
            let object = [fieldX : x, fieldY: y, fieldMaxY: maxY, fieldMinY: minY]
            
            self.scatterPlotData2.append(object)
        }
        
        let hostingView = CPTGraphHostingView(frame: frame)
        hostingView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        self.addSubview(hostingView)
        
        let graph = CPTXYGraph(frame: frame)
        hostingView.hostedGraph = graph
        
        graph.paddingLeft = 10
        graph.paddingTop = 10
        graph.paddingRight = 10
        graph.paddingBottom = 10
        
        graph.plotAreaFrame.paddingLeft   = 35.0
        graph.plotAreaFrame.paddingTop    = 10.0
        graph.plotAreaFrame.paddingRight  = 20.0
        graph.plotAreaFrame.paddingBottom = 30.0
        
        var axes = graph.axisSet as? CPTXYAxisSet
        var y = axes!.yAxis
        y.majorIntervalLength = 10
        y.minorTickLength = 0
        //        y.delegate = self
        
        var x = axes!.xAxis
        //        x.majorIntervalLength = NSDecimalNumber(float: 10.0)
        //        x.minorTickLength = 0
        //        x.labelRotation = CGFloat(M_PI/2.0)
        
        var gridStyle = CPTMutableLineStyle()
        gridStyle.lineColor = CPTColor.lightGrayColor()
        gridStyle.lineWidth = 1.0
        gridStyle.dashPattern = [2.0,5.0]
        y.majorGridLineStyle = gridStyle
        x.majorGridLineStyle = gridStyle
        
        var textStyle = CPTMutableTextStyle()
        textStyle.color = CPTColor.blackColor()
        textStyle.fontSize = 20.0
        textStyle.textAlignment = CPTTextAlignment.Center
        graph.titleTextStyle = textStyle
        
        var lineStyle = CPTMutableLineStyle()
        lineStyle.lineColor = CPTColor.blackColor()
        lineStyle.lineWidth = 1.0
        axes!.xAxis.axisLineStyle = lineStyle
        axes!.yAxis.axisLineStyle = lineStyle
        
        var plotSpace = graph.defaultPlotSpace as CPTXYPlotSpace
        plotSpace.allowsUserInteraction = true
        plotSpace.xRange = CPTPlotRange(location: 0, length: 10)
        plotSpace.yRange = CPTPlotRange(location: 0, length: 100)
        plotSpace.delegate = self
        
        
        var dataStyle = CPTMutableLineStyle()
        dataStyle.lineColor = CPTColor.redColor()
        dataStyle.lineWidth = 3.0
        var plotData = CPTRangePlot(frame: CGRectZero)
        plotData.identifier = "Data1"
        plotData.dataSource = self
        plotData.barWidth = 5
        plotData.gapWidth = 5
        plotData.gapHeight = 5
        plotData.barLineStyle = dataStyle
        
        var dataStyle2 = CPTMutableLineStyle()
        dataStyle2.lineColor = CPTColor.greenColor()
        dataStyle2.lineWidth = 3.0
        var plotData2 = CPTRangePlot(frame: CGRectZero)
        plotData2.identifier = "Data2"
        plotData2.dataSource = self
        plotData2.barWidth = 5
        plotData2.gapWidth = 5
        plotData2.gapHeight = 5
        plotData2.barLineStyle = dataStyle2
        
        graph.addPlot(plotData, toPlotSpace: plotSpace)
        graph.addPlot(plotData2, toPlotSpace: plotSpace)
        
    }
    
    // MARK: -
    
    func numberOfRecordsForPlot(plot: CPTPlot!) -> UInt {
        return UInt(self.scatterPlotData.count)
    }
    
    func numberForPlot(plot: CPTPlot!, field fieldEnum: UInt, recordIndex idx: UInt) -> NSNumber! {
        
        let field: CPTRangePlotField = CPTRangePlotField(rawValue: Int(fieldEnum))!
        let data: [NSNumber: NSNumber] = self.scatterPlotData[Int(idx)]
        
        switch field {
        case .X:
            println("X座標")
        case .Y:
            println("Y座標")
        case .High:
            println("MaxY座標")
        case .Low:
            println("MinY座標")
        default:
            println("なし")
        }
        
        if plot.identifier.isEqual("Data1") {
            let object: [NSNumber: NSNumber] = self.scatterPlotData[Int(idx)]
            return object[fieldEnum]
        }
        else if plot.identifier.isEqual("Data2") {
            let object: [NSNumber: NSNumber] = self.scatterPlotData2[Int(idx)]
            return object[fieldEnum]
        }
        else {
            return NSNumber(integer: 0)
        }
    }
    
    func plotSpace(space: CPTPlotSpace!, shouldHandlePointingDeviceUpEvent event: UIEvent!, atPoint point: CGPoint) -> Bool {
        return false
    }
    
}
