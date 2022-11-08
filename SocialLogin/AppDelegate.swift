//
//  AppDelegate.swift
//  SocialLogin
//
//  Created by smh on 2022/11/04.
//

import UIKit
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 네이버 로그인 - 기본 설정
        let naverInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        naverInstance?.isNaverAppOauthEnable = true         // 네이버앱 인증 방식 활성화
        naverInstance?.isInAppOauthEnable = true            // SafariViewController 인증 방식 활성화
        naverInstance?.isOnlyPortraitSupportedInIphone()    // 아이폰에서 인증 화면을 세로 모드에서만 적용
        
        naverInstance?.serviceUrlScheme = "bodywell.SocialLogin"
        naverInstance?.consumerKey = "NGofzuKqHbSAatF5frh4"
        naverInstance?.consumerSecret = "HynfktCFMv"
        naverInstance?.appName = "네이버 아이디로 로그인"
        
        return true
    }

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
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        print(#function)
//        NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
//        
//        return true
//    }


}

