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
    
    var chartData: [Chart] = []
    
    var scatterPlotData: [[NSNumber: NSNumber]] = []
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        for var i = 0; i < self.chartData.count; i++ {
            let chart = self.chartData[i] as Chart
            var x: NSNumber = 0
            if let mjd = chart.mjd {
                x = mjd
            }
            var y: NSNumber = 0
            if let flux = chart.flux {
                y = flux
            }
            var maxY: NSNumber = 0
            var minY: NSNumber = 0
            if let err = chart.err {
                maxY = err
                minY = err
            }
            
            let object: [NSNumber: NSNumber] = [fieldX : x, fieldY: y, fieldMaxY: maxY, fieldMinY: minY]
            self.scatterPlotData.append(object)
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
        
        var axes = graph.axisSet as CPTXYAxisSet
        var y = axes.yAxis
        
        var x = axes.xAxis
        x.majorIntervalLength = 10
        
        var gridStyle = CPTMutableLineStyle()
        gridStyle.lineColor = CPTColor.lightGrayColor()
        gridStyle.lineWidth = 1.0
        gridStyle.dashPattern = [2.0,5.0]
//        y.majorGridLineStyle = gridStyle
        x.majorGridLineStyle = gridStyle
        
        var textStyle = CPTMutableTextStyle()
        textStyle.color = CPTColor.blackColor()
        textStyle.fontSize = 20.0
        textStyle.textAlignment = CPTTextAlignment.Center
        graph.titleTextStyle = textStyle
        
        var lineStyle = CPTMutableLineStyle()
        lineStyle.lineColor = CPTColor.blackColor()
        lineStyle.lineWidth = 1.0
        axes.xAxis.axisLineStyle = lineStyle
        axes.yAxis.axisLineStyle = lineStyle
        
        var plotSpace = graph.defaultPlotSpace as CPTXYPlotSpace
        plotSpace.allowsUserInteraction = true
        plotSpace.xRange = CPTPlotRange(location: 0, length: 100)
        plotSpace.yRange = CPTPlotRange(location: -15, length: 30)
        plotSpace.delegate = self
        
        var dataStyle = CPTMutableLineStyle()
        dataStyle.lineColor = CPTColor.redColor()
        dataStyle.lineWidth = 1
        var plotData = CPTRangePlot(frame: CGRectZero)
        plotData.identifier = "Data1"
        plotData.dataSource = self
        plotData.barWidth = 3
        plotData.gapWidth = 3
        plotData.gapHeight = 3
        plotData.barLineStyle = dataStyle
        
        graph.addPlot(plotData, toPlotSpace: plotSpace)
    }
    
    // MARK: -
    
    func numberOfRecordsForPlot(plot: CPTPlot!) -> UInt {
        return UInt(self.scatterPlotData.count)
    }
    
    func numberForPlot(plot: CPTPlot!, field fieldEnum: UInt, recordIndex idx: UInt) -> NSNumber! {
        
//        let field: CPTRangePlotField = CPTRangePlotField(rawValue: Int(fieldEnum))!
//        let data: [NSNumber: NSNumber] = self.scatterPlotData[Int(idx)]
//        
//        switch field {
//        case .X:
//            println("X座標")
//        case .Y:
//            println("Y座標")
//        case .High:
//            println("MaxY座標")
//        case .Low:
//            println("MinY座標")
//        default:
//            println("なし")
//        }
        
        if plot.identifier.isEqual("Data1") {
            let object: [NSNumber: NSNumber] = self.scatterPlotData[Int(idx)]
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
