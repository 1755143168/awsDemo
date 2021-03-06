//
//  AppDelegate.swift
//  lastdemo
//
//  Created by Super on 2021/8/26.
//

import UIKit
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import Amplify
import AmplifyPlugins


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        do {
            AppCenter.start(withAppSecret: "afbe496c-055f-42b8-8b3b-00c2da8a16ec", services:[
              Analytics.self,
              Crashes.self
            ])
            let syncExpr = DataStoreSyncExpression.syncExpression(Todo.schema) {
            
                            return QueryPredicateConstant.all
                        }
//                let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels(),
                                                       configuration: .custom(
                                                        syncExpressions: [syncExpr])))
//                try Amplify.add(plugin: dataStorePlugin)
                try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
                try Amplify.configure()
                print("Amplify configured with API plugin")
            } catch {
                print("Failed to initialize Amplify with \(error)")
            }
        return true
    }
    
    public var rating: Int? = 5

//    func initialize() {
//        let syncExpr = DataStoreSyncExpression.syncExpression(Todo.schema) {
//
//                return QueryPredicateConstant.all
//            }
//        }
        
    
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

