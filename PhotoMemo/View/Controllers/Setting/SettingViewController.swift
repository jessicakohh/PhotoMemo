//
//  SettingViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/14.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var settingView = SettingView()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    override func loadView() {
        view = settingView
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "Profile"
        navigationItem.titleView?.tintColor = .mainDarkGrey
    }
    
    // MARK: - Layout Extension



    
    
}
