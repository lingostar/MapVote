//
//  BarChartViewController.swift
//  MapVote
//
//  Created by LingoStar on 2021/02/28.
//

import UIKit
import Charts

class BarChartViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var categorySementedControl: CustomSegmentedControl!
    
    lazy var barChart : BarChartView = {
        let barChartView = BarChartView()
        barChartView.backgroundColor = .white
        
        barChartView.rightAxis.enabled = false
        
        //y축 custom
        let yAxis = barChartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = UIColor(named: "SegmentColor")!
        yAxis.axisLineColor = UIColor(named: "SegmentColor")!
        yAxis.labelPosition = .outsideChart
        
        //x축 custom
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        barChartView.xAxis.setLabelCount(6, force: false)
        barChartView.xAxis.labelTextColor = UIColor(named: "SegmentColor")!
        barChartView.xAxis.axisLineColor = UIColor(named: "SegmentColor")!
        barChartView.xAxis.drawGridLinesEnabled = false
        
        barChartView.doubleTapToZoomEnabled = false
        
        //chart animation
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        return barChartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        barChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        barChart.frame = CGRect(x: 0, y: 0,
                                width: self.view.frame.size.width,
                                height: self.view.frame.size.width)
        barChart.center = view.center
        
        view.addSubview(barChart)
        
        setBarChartData(dataPoints: selectedCategory.itemNames, values: selectedCategory.weights)
    }
    
    var selectedCategory : Category {
        return categoryData[categorySementedControl.selectedSegmentIndex]
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        viewDidLayoutSubviews()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    //MARK: - BarChart
    func setBarChartData(dataPoints: [String], values: [Int]){
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        
        var colors: [UIColor] = []
            
            for _ in 0..<dataPoints.count {
              let red = Double(arc4random_uniform(200))
              let green = Double(arc4random_uniform(200))
              let blue = Double(arc4random_uniform(200))
                
              let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
              colors.append(color)
            }
        
        chartDataSet.colors = colors
        
        let data = BarChartData(dataSet: chartDataSet)
        
        // X축 레이블 포맷 지정
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: selectedCategory.itemNames)
        
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        barChart.xAxis.setLabelCount(selectedCategory.itemNames.count, force: false)
        
        //data 숫자 제거
        data.setValueFont(.boldSystemFont(ofSize: 15))
        data.setValueTextColor(UIColor(named: "SegmentColor")!)
        barChart.data = data
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
