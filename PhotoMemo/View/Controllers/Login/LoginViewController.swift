//
//  LoginViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/18.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let loginView = LoginView()
    private let viewModel = LoginViewModel()
        
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
      view = loginView
  }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    
    // MARK: - Layout Extension
}


