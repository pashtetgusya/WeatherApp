//
//  Settings.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 20.12.2021.
//

import Foundation
import Charts

func configLineChartDataSet(lineChartDataSet: LineChartDataSet) {
    lineChartDataSet.circleRadius = 5
    lineChartDataSet.drawValuesEnabled = false
    lineChartDataSet.drawVerticalHighlightIndicatorEnabled = false
    lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = false
    lineChartDataSet.axisDependency = .left
    lineChartDataSet.lineWidth = 3
    lineChartDataSet.mode = .cubicBezier
}

func configLineChartView(sender: LineChartView, countElements: Int, axisLabelsElements: [String]) {
    sender.xAxis.valueFormatter = IndexAxisValueFormatter(values: axisLabelsElements)
    sender.xAxis.setLabelCount(countElements, force: true)
    sender.xAxis.centerAxisLabelsEnabled = true
    sender.rightAxis.enabled = false
    sender.legend.enabled = false
}
