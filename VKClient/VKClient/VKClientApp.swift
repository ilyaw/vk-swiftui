//
//  VKClientApp.swift
//  VKClient
//
//  Created by Ilya on 13.09.2021.
//

import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var mainCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        
        // Create the SwiftUI view that provides the window contents.
        mainCoordinator = AppCoordinator(navigationController: UINavigationController())
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            window.rootViewController = mainCoordinator?.navigationController
            
            self.window = window
            window.makeKeyAndVisible()
            
            mainCoordinator?.start()
        }
    }
}

//@main
//struct VKClientApp: App {
//    var body: some Scene {
//        WindowGroup {
//            StartView()
//        }
//    }
//}
