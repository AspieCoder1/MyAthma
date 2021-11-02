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
        
        appendViewController(blueInhalerChart, animated: false)
    }
    
}
