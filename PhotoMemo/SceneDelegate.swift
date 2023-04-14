//
//  SceneDelegate.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2022/12/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
 
        guard let window else { return }
        MainViewManager.shared.show(in: window)
        window.makeKeyAndVisible()
        
    }
}
