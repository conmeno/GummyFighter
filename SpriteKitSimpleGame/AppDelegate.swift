//
//  AppDelegate.swift
//  SpriteKitSimpleGame
//
//  Created by Main Account on 9/30/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,ChartboostDelegate {

  var window: UIWindow?

    var UIiAd: ADBannerView = ADBannerView()
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
    Chartboost.startWithAppId("55d059c15b14537f68763fbe", appSignature: "f611d0f24a26a598aa32cd0701e2786a5efa1a4f", delegate: self)
    
//    //vungle
//    // Override point for customization after application launch.
//    var appID = "1019089262"
//    var sdk = VungleSDK.sharedSDK()
//    // start vungle publisher library
//    sdk.startWithAppId(appID)
//    sdk.setLoggingEnabled(true)
//    
//    //end vung le
//    //adcolony\
//    AdColony.configureWithAppID("appfdd8cc532b6e4b5d81", zoneIDs: ["vzc1c1b51b68a749f797"], delegate: nil, logging: true)
//    
//     
//    MobileCore.initWithToken("IEO751TSK1E14E2X1RZC6HF5AAVJ", logLevel: DEBUG_LOG_LEVEL, adUnits:
//        [NSNumber (unsignedInt: AD_UNIT_ALL_UNITS.value)])
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

