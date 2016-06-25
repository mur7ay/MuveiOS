//
//  AppDelegate.swift
//  Muve
//
//  Created by shawn murray on 6/10/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        FIRApp.configure()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        if let loginType = LoginHelper.getLoginType() {
            switch loginType {
            case .email:
                if let loginAndPass = LoginHelper.getKeyChainLogin() {
                    let loaderScreen = LoaderScreenViewController.create() as! LoaderScreenViewController
                    loaderScreen.credentials = loginAndPass
                    setRoot(loaderScreen)
                } else {
                    setRoot(LoginViewController.create(), withNavigationController:  true)
                }
            case .google:
                if let token = LoginHelper.getKeyChainTokenGoogle() {
                    LoginHelper.googleLogin(token.0, accessToken: token.1) { user, error in
                        if let _error = error {
                            print(_error.localizedDescription)
                            self.setRoot(LoginViewController())
                        } else {
                            self.setRoot(TabBarViewController())
                        }
                    }
                }
            case .facebook:
                break
            }
        }
        return true
    }

    @available(iOS 9.0, *)
    func application(application: UIApplication,
                     openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                                                    annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if let error = error {
            print(error.localizedDescription)
            return
        } else {
            let authentication = user.authentication
            LoginHelper.googleLogin(authentication.idToken, accessToken: authentication.accessToken) { user, error in
                if let _error = error {
                    print(_error.localizedDescription)
                } else {
                    let tokens = (authentication.idToken!,authentication.accessToken!)
                    LoginHelper.setKeyChainTokenGoogle(tokens)
                    self.setRoot(TabBarViewController())
                }
            }
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        LoginHelper.removeKeyChains()
        window?.rootViewController = LoginViewController.create() as! LoginViewController
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

    private func setRoot(controller: UIViewController, withNavigationController: Bool = false) {
        if withNavigationController {
            self.window?.rootViewController? = UINavigationController(rootViewController: controller)
        } else {
            self.window?.rootViewController? = controller
        }
    }

}

