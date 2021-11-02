//
//  SceneDelegate.swift
//  MyAsthma
//
//  Created by Luke Braithwaite on 01/11/2021.
//

import UIKit
import CareKitStore
import CareKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var storeManager: OCKSynchronizedStoreManager {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.synchronizedStoreManager
    }
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Sets up the calendar view
        let feed = CalendarView(storeManager: appDelegate.synchronizedStoreManager)
        feed.title = "My tasks"
        feed.tabBarItem = UITabBarItem(
            title: "Tasks",
            image: UIImage(systemName: "heart.text.square"),
            tag: 0
        )
        
        let insights = InsightsViewController(storeManager: appDelegate.synchronizedStoreManager)
        insights.title = "Insights"
        insights.tabBarItem = UITabBarItem(
            title: "insights", image: UIImage(systemName: "chart.xyaxis.line"), tag: 0
        )
        
        
        let root = UITabBarController()
        let feedTab = UINavigationController(rootViewController: feed)
        
        root.setViewControllers([feedTab, insights], animated: false)
        
        window = UIWindow(windowScene: scene as! UIWindowScene)
        window?.rootViewController = root
        window?.makeKeyAndVisible()
    }
}

