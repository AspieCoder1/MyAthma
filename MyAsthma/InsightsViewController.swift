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

class InsightsViewController: OCKListViewController {
    let storeManager: OCKSynchronizedStoreManager
    
    init(storeManager: OCKSynchronizedStoreManager) {
         self.storeManager = storeManager
         super.init(nibName: nil, bundle: nil)
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override func viewDidLoad() {
        self.viewDidLoad()
    }
}
