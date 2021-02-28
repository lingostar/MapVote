//
//  PieChartViewController.swift
//  MapVote
//
//  Created by LingoStar on 2021/02/28.
//

import UIKit
import Charts

class PieChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var categorySementedControl: CustomSegmentedControl!
    
    var pieChart = PieChartView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        pieChart.delegate = self
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pieChart.frame = CGRect(x: 0, y: 0,
                                width: self.view.frame.size.width,
                                height: self.view.frame.size.width)
        pieChart.center = view.center
        
        view.addSubview(pieChart)
        
        setPieChartData(dataPoints: selectedCategory.itemNames, values: selectedCategory.weights.map{ Double($0) })
    }
    
    var selectedCategory : Category {
        return categoryData[categorySementedControl.selectedSegmentIndex]
    }
    
    // MARK: - Segmented Control Event
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        viewDidLayoutSubviews()
    }
    

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    //MARK: - PieChart
    func setPieChartData(dataPoints: [String], values: [Double]){
        
        // 데이터 생성
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        
        var colors: [UIColor] = []
            
            for _ in 0..<dataPoints.count {
              let red = Double(arc4random_uniform(200))
              let green = Double(arc4random_uniform(200))
              let blue = Double(arc4random_uniform(200))
                
              let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
              colors.append(color)
            }
        
        chartDataSet.colors = colors

        
        let data = PieChartData(dataSet: chartDataSet)
        
        data.setValueFont(.boldSystemFont(ofSize: 15))
        data.setValueTextColor(.white)
        pieChart.data = data
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
