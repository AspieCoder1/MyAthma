//
//  CalendarView.swift
//  MyAsthma
//
//  Created by Luke Braithwaite on 01/11/2021.
//

import Foundation
import CareKit
import CareKitStore
import CareKitUI
import UIKit
import os.log

class CalendarView: OCKDailyPageViewController {
    override func dailyPageViewController(_ dailyPageViewController: OCKDailyPageViewController, prepare listViewController: OCKListViewController, for date: Date) {
        self.fetchTasks(on: date) { tasks in
            tasks.compactMap {
                self.taskViewController(for: $0, on:date)
            }.forEach {
                listViewController.appendViewController($0, animated: false)
            }
        }
    }
    
    private func fetchTasks(
        on date: Date,
        completion: @escaping([OCKAnyTask]) -> Void) {
            
            var query = OCKTaskQuery(for: date)
            query.excludesTasksWithNoEvents = true
            
            storeManager.store.fetchAnyTasks(
                query: query,
                callbackQueue: .main) { result in
                    
                    switch result {
                        
                    case .failure:
                        print("Failed to fetch tasks for date \(date)")
                        completion([])
                        
                    case let .success(tasks):
                        completion(tasks)
                    }
                }
        }
    
    private func taskViewController(
        for task: OCKAnyTask,
        on date: Date) -> UIViewController? {
            switch task.id {
            case "inhaler":
                return OCKChecklistTaskViewController(task: task,
                                                      eventQuery: .init(for: date),
                                                      storeManager: self.storeManager)
            case "salabutamol":
                return OCKButtonLogTaskViewController(task: task,
                                            eventQuery: .init(for: date),
                                            storeManager: self.storeManager)

            default:
                return OCKSimpleTaskViewController(task: task,
                                         eventQuery: .init(for: date),
                                         storeManager: self.storeManager)
            }
        }
}
