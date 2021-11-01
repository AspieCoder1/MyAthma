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
        
        let feed = CalendarView(storeManager: appDelegate.synchronizedStoreManager)
        feed.title = "My medicines"
        feed.tabBarItem = UITabBarItem(
            title: "Calendar",
            image: UIImage(systemName: "calendar"),
            tag: 0
        )
        
        let root = UITabBarController()
        let feedTab = UINavigationController(rootViewController: feed)
        root.setViewControllers([feedTab], animated: false)
        
        window = UIWindow(windowScene: scene as! UIWindowScene)
        window?.rootViewController = root
        window?.makeKeyAndVisible()
    }
}

