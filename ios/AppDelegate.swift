//
//  AppDelegate.swift
//  ios
//
//  Created by Jerry Jung on 06/08/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import CoreData
import AlamofireNetworkActivityIndicator
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // Production 서버
    // let baseUrl = "https://beluv.softsquared.com"
    // Dev 서버
    //let baseUrl = "http://13.124.75.140"
    
    let baseUrl = "http://test.danggeun.ga"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NetworkActivityIndicatorManager.shared.isEnabled = true
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor.black
        
        UINavigationBar.appearance().tintColor = .black
        
        window?.makeKeyAndVisible()
        
        //MARK: - User Defaults info initialize
        var certificationNumber = 0
        var myTown = ""
        var placeID = 0
        var phone_number = ""
        var user_nickname = ""
        var user_image = ""
        var myLatitude: Float = 0.0
        var mylongitude:Float = 0.0
        var distance: Float = 0.0
        var jwt = ""
        var post_id = 0
        var my_id = 0
        
        //MARK: - User Defaults Login Info
        let is_member_userDefaults = UserDefaults.standard.value(forKey: "save_isMember")
        if is_member_userDefaults != nil{
            certificationNumber = UserDefaults.standard.value(forKey: "save_isMember") as! Int
        }
        
        let myTown_userDefaults =  UserDefaults.standard.value(forKey: "save_myTown")
        if myTown_userDefaults != nil{
            myTown =  UserDefaults.standard.value(forKey: "save_myTown") as! String
        }
        
        let placeID_userDefaults = UserDefaults.standard.value(forKey: "save_placeID")
        if placeID_userDefaults != nil{
            placeID = UserDefaults.standard.value(forKey: "save_placeID") as! Int
        }
        
        let phone_number_userDefaults = UserDefaults.standard.value(forKey: "save_phone_number")
        if phone_number_userDefaults != nil{
            phone_number = UserDefaults.standard.value(forKey: "save_phone_number") as! String
        }
        //MARK: -
        let user_nickname_userDefaults = UserDefaults.standard.value(forKey: "save_user_nickname")
        if user_nickname_userDefaults != nil{
            user_nickname = UserDefaults.standard.value(forKey: "save_user_nickname") as! String
        }
        
        let user_image_userDefaults = UserDefaults.standard.value(forKey: "save_user_image")
        if user_image_userDefaults != nil{
            user_image = UserDefaults.standard.value(forKey: "save_user_image") as! String
        }
        
        let myLatitude_userDefaults = UserDefaults.standard.value(forKey: "save_myLatitude")
        if myLatitude_userDefaults != nil{
            myLatitude = UserDefaults.standard.value(forKey: "save_myLatitude") as! Float
        }
        
        let mylongitude_userDefaults = UserDefaults.standard.value(forKey: "save_mylongitude")
        if mylongitude_userDefaults != nil{
            mylongitude = UserDefaults.standard.value(forKey: "save_mylongitude") as! Float
        }
        
        let distance_userDefaults = UserDefaults.standard.value(forKey: "save_distance")
        if distance_userDefaults != nil{
            distance = UserDefaults.standard.value(forKey: "save_distance") as! Float
        }
        
        let jwt_userDefaults = UserDefaults.standard.value(forKey: "save_jwt")
        if jwt_userDefaults != nil{
            jwt = UserDefaults.standard.value(forKey: "save_jwt") as! String
        }
        
        let post_id_userDefaults = UserDefaults.standard.value(forKey: "save_post_id")
        if post_id_userDefaults != nil{
            post_id = UserDefaults.standard.value(forKey: "save_post_id") as! Int
        }
        
        let my_id_userDefaults = UserDefaults.standard.value(forKey: "save_myID")
        if my_id_userDefaults != nil{
            my_id = UserDefaults.standard.value(forKey: "save_myID") as! Int
        }
        
        
        //let certificationNumber = UserDefaults.standard.value(forKey: "save_isMember") as! Int
        //let myTown = UserDefaults.standard.value(forKey: "save_myTown") as! String
        //let placeID = UserDefaults.standard.value(forKey: "save_placeID") as! Int
        //let phone_number = UserDefaults.standard.value(forKey: "save_phone_number") as! String
        //let user_nickname = UserDefaults.standard.value(forKey: "save_user_nickname") as! String
        //let user_image = UserDefaults.standard.value(forKey: "save_user_image") as! String
        //        let myLatitude = UserDefaults.standard.value(forKey: "save_myLatitude") as! Float
        //        let mylongitude = UserDefaults.standard.value(forKey: "save_mylongitude") as! Float
        //        let distance = UserDefaults.standard.value(forKey: "save_distance") as! Float
        //        let jwt = UserDefaults.standard.value(forKey: "save_jwt") as! String
        //
        //        let post_id = UserDefaults.standard.value(forKey: "save_post_id") as! Int
        
        
        
        
        print("-----------------------------------------------------------------------------------------------------------------------------------\nUSER DEFAULTS INFORMATION \n certificationNumber:\(certificationNumber)\n, myTown: \(myTown)\n, place ID = \(placeID)\n, jwt = \(jwt)\n, userNickName = \(user_nickname)\n, userImage = \(user_image)\n, latitude = \(myLatitude)\n, longitude = \(mylongitude) \n-----------------------------------------------------------------------------------------------------------------------------------")
        
        
        let initialViewController = InitialViewController()
        self.window?.rootViewController = UINavigationController(rootViewController: initialViewController)
        // 오토 로그인 미설정 - 로그아웃 상태에서의 로그인
        if certificationNumber == 0 {
            let initialViewController = InitialViewController()
            self.window?.rootViewController = UINavigationController(rootViewController: initialViewController)
            
        }
        else if certificationNumber == 1{
            // 오토 로그인이 된 상태(정보 할당)
            ISMEMBER = 1
            MYTOWN = myTown
            PLACE_ID = placeID
            USER_NICKNAME = user_nickname
            USER_IMAGE = user_image
            JWT = jwt
            PHONENUMBER = phone_number
            DISTANCE = distance
            MYLONGITUDE = mylongitude
            MYLATITUDE = myLatitude
            POST_ID = post_id
            MY_ID = my_id
            
            let mainVC = MainTabBarController()
            window?.rootViewController = mainVC
        }
            
        else{
            let initialViewController = InitialViewController()
            self.window?.rootViewController = UINavigationController(rootViewController: initialViewController)
        }
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ios")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}


