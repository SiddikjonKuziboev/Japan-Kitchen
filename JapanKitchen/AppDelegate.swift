//
//  AppDelegate.swift
//  JapanKitchen
//
//  Created by Kuziboev Siddikjon on 2/4/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("didFinishLaunchingWithOptions")
        
        window = UIWindow()
        let vc = MainVC(nibName: "MainVC", bundle: nil)
        let navigation = UINavigationController.init(rootViewController: vc)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColors.navigation_backround_color
        appearance.titleTextAttributes = [.font:
        UIFont.boldSystemFont(ofSize: 20.0), .foregroundColor: UIColor.white]
        
        
        navigation.navigationBar.standardAppearance = appearance
        navigation.navigationBar.scrollEdgeAppearance = appearance
        navigation.navigationBar.tintColor = .white
       
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()

        return true
    }
   
}

