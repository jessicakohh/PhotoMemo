//
//  MainViewManager.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/13.
//

import UIKit

class MainViewManager {
    
    static let shared = MainViewManager()
    
    private var window: UIWindow!
    private var rootViewController: UIViewController? {
        didSet {
            window.rootViewController = rootViewController
        }
    }
    
    func show(in window: UIWindow) {
        self.window = window
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        
//        setTapBarController()
        setLoginViewController()
    }
    
    private func setTapBarController() {
        let tabBarViewController = UITabBarController()
        
        let vc1 = UINavigationController(rootViewController: PhotoViewController())
        let vc2 = UINavigationController(rootViewController: SettingViewController())
        
        tabBarViewController.setViewControllers([vc1, vc2], animated: false)
        tabBarViewController.modalPresentationStyle = .fullScreen
        tabBarViewController.tabBar.backgroundColor = .white
        tabBarViewController.tabBar.tintColor = .mainDarkGrey
        
        guard let items = tabBarViewController.tabBar.items else { return }
        items[0].image = UIImage(systemName: "folder.circle.fill")
        items[0].selectedImage = UIImage(systemName: "folder.circle.fill")
        items[1].image = UIImage(systemName: "gearshape.fill")
        items[1].selectedImage = UIImage(systemName: "gearshape.fill")
        
        tabBarViewController.selectedIndex = 0
        tabBarViewController.tabBar.backgroundColor = .mainGrey
        rootViewController = tabBarViewController
    }
    
    private func setLoginViewController() {
//        let loginViewController = UINavigationController(rootViewController: LoginViewController())
//        rootViewController = loginViewController
        
        let loginViewController = UINavigationController(rootViewController: SignInViewController())
        rootViewController = loginViewController
    }
    
}
