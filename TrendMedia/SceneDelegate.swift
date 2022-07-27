//
//  SceneDelegate.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
//        UserDefaults.standard.set(false, forKey: "First") // true이면 vc를 띄우고, false이면 Searchmovie 다른 화면에 배치해야함
//        
//        guard let scene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(windowScene: scene)
//
//        
//        if UserDefaults.standard.bool(forKey: "First") {
//            
//            let sb = UIStoryboard(name: "Trend" , bundle: nil)
//            
//            let vc = sb.instantiateViewController(withIdentifier: "TestSceneViewController") as! TestSceneViewController
//            
//            // 첫 시작화면으로 지정하기
//            window?.rootViewController = vc
//            
//        } else {
//                        
//            let sb = UIStoryboard(name: "Search" , bundle: nil)
//            
//            let vc = sb.instantiateViewController(withIdentifier: "MovieTableViewController") as! MovieTableViewController
//            let nav = UINavigationController(rootViewController: vc)
//            
//            // 첫 시작화면으로 지정하기
//            window?.rootViewController = nav
//        }
//        
        //window?.makeKeyAndVisible() // 버전별 대응 척 화면을 보여주기 위함임!
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

