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
        
        var relvar = OCKTask(id: "inhaler-relvar", title: "Take Relvar", carePlanUUID: nil, schedule: schedule)
        relvar.instructions = "Take 1 puff of Relvar 184/22"
        relvar.asset = "puff"
        relvar.impactsAdherence = true
        addTasks([relvar], callbackQueue: .main, completion: nil)
//        let schedule = OCKSchedule(composing: [
//            OCKScheduleElement(start: beforeBreakfast, end: nil,
//                               interval: DateComponents(day: 1)),
//
//            OCKScheduleElement(start: afterLunch, end: nil,
//                               interval: DateComponents(day: 2))
//        ])
//
//        var doxylamine = OCKTask(id: "doxylamine", title: "Take Doxylamine",
//                                 carePlanUUID: nil, schedule: schedule)
//        doxylamine.instructions = "Take 25mg of doxylamine when you experience nausea."
//        doxylamine.asset = "pills"
//        let nauseaSchedule = OCKSchedule(composing: [
//            OCKScheduleElement(start: beforeBreakfast, end: nil, interval: DateComponents(day: 1),
//                               text: "Anytime throughout the day", targetValues: [], duration: .allDay)
//        ])
//
//        var nausea = OCKTask(id: "nausea", title: "Track your nausea",
//                             carePlanUUID: nil, schedule: nauseaSchedule)
//        nausea.impactsAdherence = false
//        nausea.instructions = "Tap the button below anytime you experience nausea."
//
//        let kegelElement = OCKScheduleElement(start: beforeBreakfast, end: nil, interval: DateComponents(day: 2))
//        let kegelSchedule = OCKSchedule(composing: [kegelElement])
//        var kegels = OCKTask(id: "kegels", title: "Kegel Exercises", carePlanUUID: nil, schedule: kegelSchedule)
//        kegels.impactsAdherence = true
//        kegels.instructions = "Perform kegel exercies"
//
//        addTasks([nausea, doxylamine, kegels], callbackQueue: .main, completion: nil)
    }
}
