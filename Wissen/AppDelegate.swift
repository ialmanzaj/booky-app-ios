//
//  AppDelegate.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/22/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Mixpanel
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
	
	var window: UIWindow?
	var authCoordinator: AuthCoordinator?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		
		//GIDSignIn.sharedInstance().clientID = "297724466424-v3mmh4ldj4embgcik5f4qva6e30n3820.apps.googleusercontent.com"
		//GIDSignIn.sharedInstance().delegate = self

		
		//setup fabric
		Fabric.with([Crashlytics.self])
		
		//setup mix panel
		Mixpanel.initialize(token: "02e2770f9f820e3d9d5ac65b01916738")
		
		// Override point for customization after application launch.
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = UINavigationController()
		self.authCoordinator = AuthCoordinator(nav: window?.rootViewController as! UINavigationController)
		self.authCoordinator?.start()
		self.window?.makeKeyAndVisible()
		
		return true
	}

	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
		return GIDSignIn.sharedInstance().handle(url as URL?,
												 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
												 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
	}
	
	
	
	func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
			  withError error: Error!) {
		// Perform any operations when the user disconnects from app here.
		// ...
	}
	
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
			  withError error: Error!) {
		if let error = error {
			print("\(error.localizedDescription)")
		} else {
			// Perform any operations on signed in user here.
			let userId = user.userID                  // For client-side use only!
			let idToken = user.authentication.idToken // Safe to send to the server
			let fullName = user.profile.name
			let givenName = user.profile.givenName
			let familyName = user.profile.familyName
			let email = user.profile.email
			// ...
		}
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
	}
	
	


}

