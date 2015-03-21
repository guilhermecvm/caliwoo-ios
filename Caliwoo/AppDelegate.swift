//
//  AppDelegate.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 18/02/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        ShopifyAPI.baseURLString = "https://kingui.myshopify.com"
        ShopifyAPI.OAuthToken = "5ae8ae530e01d5ca0efce659952c3b1e"
        
//        Parse.enableLocalDatastore()
        Parse.setApplicationId("XmNapLH4u1NDnwchVm8XvLz8MaTi6XvF393IfEmg", clientKey: "gswyvHzdfJTxNcISSJDlvYEQTAujN6VfcCJio6l2")
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(nil, block: nil)
        PFAnalytics.trackAppOpenedWithRemoteNotificationPayloadInBackground(nil, block: nil)
        
        PFUser.enableAutomaticUser()
        PFUser.currentUser().incrementKey("runCount")
//        PFUser.currentUser().ACL = PFACL(user: PFUser.currentUser())
        PFUser.currentUser().saveInBackgroundWithBlock(nil)
        
        // get user likes        
        var query = PFQuery(className:"Like")
        query.whereKey("user", equalTo: PFUser.currentUser())
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error == nil) {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        CWCache.sharedInstance.setPhotoLikedByUser(object["product"] as PFObject, liked: true)
                    }
                }
            }
        }
        
        // push notification
        let userNotificationTypes = (UIUserNotificationType.Alert |
            UIUserNotificationType.Badge |
            UIUserNotificationType.Sound);
        
        let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        let currentInstallation = PFInstallation.currentInstallation()
        if currentInstallation.badge != 0 {
            currentInstallation.badge = 0
            currentInstallation.saveEventually(nil)
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackgroundWithBlock { (success, error) -> Void in
            if (error != nil) {
                NSLog("didRegisterForRemoteNotificationsWithDeviceToken")
                NSLog("Error: \(error)")
            }
        }
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        NSLog("didFailToRegisterForRemoteNotificationsWithError")
        NSLog("Error: \(error)")
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
    }
    
}

