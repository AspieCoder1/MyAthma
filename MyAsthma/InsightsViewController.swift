//
//  Insights.swift
//  MyAsthma
//
//  Created by Luke Braithwaite on 02/11/2021.
//

import Foundation
import CareKit
import CareKitStore
import CareKitUI
import UIKit

final class InsightsViewController: OCKListViewController {
    let storeManager: OCKSynchronizedStoreManager
    
    init(storeManager: OCKSynchronizedStoreManager) {
        self.storeManager = storeManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        appendViewController(blueInhalerChart(), animated: false)
        appendViewController(fostairChart(), animated: false)
    }
    
    private func blueInhalerChart() -> UIViewController {
        let blueInhalerUsages = OCKDataSeriesConfiguration(
            taskID: "salabutamol",
            legendTitle: "Blue inhaler usage (puffs)",
            gradientStartColor: UIColor.systemBlue,
            gradientEndColor:UIColor.systemBlue,
            markerSize: 10,
            eventAggregator: OCKEventAggregator.countOutcomeValues
        )
        
        let blueInhalerChart = OCKCartesianChartViewController(
            plotType: .bar,
            selectedDate: Date(),
            configurations: [blueInhalerUsages],
            storeManager: storeManager
        )
        
        blueInhalerChart.chartView.headerView.titleLabel.text = "Blue inhaler usage"
        return blueInhalerChart
    }
    
    private func fostairChart() -> UIViewController {
        let fostairUsage = OCKDataSeriesConfiguration(
            taskID: "fostair",
            legendTitle: "Fostair usage (puffs)",
            gradientStartColor: UIColor.systemBlue,
            gradientEndColor:UIColor.systemBlue,
            markerSize: 10,
            eventAggregator: OCKEventAggregator.countOutcomeValues
        )
        
        let fostairChart = OCKCartesianChartViewController(
            plotType: .bar,
            selectedDate: Date(),
            configurations: [fostairUsage],
            storeManager: storeManager
        )
        
        fostairChart.chartView.headerView.titleLabel.text = "Fostair puffs taken"
        return fostairChart
    }
    
    private func peakFlowChart() -> UIViewController {
        let peakFlow = OCKDataSeriesConfiguration(
            taskID: "fostair",
            legendTitle: "Fostair usage (puffs)",
            gradientStartColor: UIColor.systemBlue,
            gradientEndColor:UIColor.systemBlue,
            markerSize: 10,
            eventAggregator: OCKEventAggregator.custom({ events in
                events.compactMap{
                    $0.task.userInfo?.value
                }
            })
        )
        
        let fostairChart = OCKCartesianChartViewController(
            plotType: .bar,
            selectedDate: Date(),
            configurations: [peakFlow],
            storeManager: storeManager
        )
        
        fostairChart.chartView.headerView.titleLabel.text = "Peak Flow"
        return fostairChart
    }
    
}
