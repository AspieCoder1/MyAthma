//
//  AppDelegate.swift
//  MyAsthma
//
//  Created by Luke Braithwaite on 01/11/2021.
//

import UIKit
import CareKit
import CareKitStore
import Contacts
import HealthKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    lazy private(set) var coreDataStore = OCKStore(name: "MyAsthma", type: .inMemory)
    
    //    lazy private(set) var healthKitStore = OCKHealthKitPassthroughStore(store: coreDataStore)
    
    lazy private(set) var synchronizedStoreManager: OCKSynchronizedStoreManager = {
        let coordinator = OCKStoreCoordinator()
        //        coordinator.attach(eventStore: healthKitStore)
        coreDataStore.populateSampleData()
        coordinator.attach(store: coreDataStore)
        return OCKSynchronizedStoreManager(wrapping: coordinator)
    }()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        coreDataStore.populateSampleData()
        //        healthKitStore.populateSampleData()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

private extension OCKStore {
    
    // Adds tasks and contacts into the store
    func populateSampleData() {
        
        // Morning and evening times for inhalers
        let today = Calendar.current.startOfDay(for: Date())
        let morning = Calendar.current.date(byAdding: .hour, value: 8, to: today)!
        let evening = Calendar.current.date(byAdding: .hour, value: 20, to: today)!
        let schedule = OCKSchedule(composing: [
            OCKScheduleElement(start: morning, end: nil, interval: DateComponents(day: 1)),
            OCKScheduleElement(start: evening, end: nil, interval: DateComponents(day: 1)),
        ])
        
        // Relvar
        var relvar = OCKTask(id: "inhaler", title: "Relvar 184/22", carePlanUUID: nil, schedule: schedule)
        relvar.instructions = "Take 1 puff"
        relvar.asset = "puff"
        relvar.impactsAdherence = true
        
        // Fexofenadine
        let fexofenadineSchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: morning, end: nil, interval: DateComponents(day: 1)),
        ])
        var fexofenadine = OCKTask(id: "fexofenadine", title: "Fexofendaine", carePlanUUID: nil, schedule: fexofenadineSchedule)
        fexofenadine.instructions = "Take 1 tablet"
        fexofenadine.asset = "tablet"
        fexofenadine.impactsAdherence = true
        
        // Montelukast
        let montelukastSchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: evening, end: nil, interval: DateComponents(day: 1)),
        ])
        var montelukast = OCKTask(id: "montelukast", title: "Montelukast", carePlanUUID: nil, schedule: montelukastSchedule)
        montelukast.instructions = "Take 1 tablet"
        montelukast.asset = "tablet"
        montelukast.impactsAdherence = true
        
        addTasks([relvar, fexofenadine, montelukast], callbackQueue: .main, completion: nil)
    }
}
